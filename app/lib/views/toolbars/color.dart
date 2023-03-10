import 'package:butterfly/dialogs/packs/select.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';
import '../../dialogs/color_pick.dart';

class ColorToolbarView extends StatefulWidget {
  final int color;
  final ValueChanged<int> onChanged;

  const ColorToolbarView({
    super.key,
    required this.color,
    required this.onChanged,
  });

  @override
  State<ColorToolbarView> createState() => _ColorToolbarViewState();
}

class _ColorToolbarViewState extends State<ColorToolbarView> {
  final ScrollController _scrollController = ScrollController();
  PackAssetLocation? currentPalette;
  @override
  void initState() {
    super.initState();
    final state = context.read<DocumentBloc>().state;
    if (state is DocumentLoadSuccess) {
      final pack = state.document.packs.firstOrNull;
      final palette = pack?.palettes.firstOrNull;
      if (palette != null) {
        currentPalette =
            PackAssetLocation(pack: pack!.name, name: palette.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      final bloc = context.read<DocumentBloc>();
      ColorPalette? palette;
      ButterflyPack? pack;

      if (state is! DocumentLoadSuccess) return Container();
      if (currentPalette != null) {
        pack = state.document.getPack(currentPalette!.pack);
        palette = pack?.getPalette(currentPalette!.name);
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!(palette?.colors.contains(widget.color) ?? false)) ...[
            _ColorButton(
              current: widget.color,
              color: widget.color,
              bloc: bloc,
              chooseOnPress: true,
              onChanged: (value) {
                widget.onChanged(value);
              },
            ),
            if (palette != null) const VerticalDivider(),
          ],
          if (palette != null)
            Expanded(
                child: Scrollbar(
              controller: _scrollController,
              child: ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(palette.colors.length, (index) {
                      final current = palette!.colors[index];
                      return _ColorButton(
                        bloc: bloc,
                        color: widget.color,
                        current: current,
                        onChanged: (value) {
                          widget.onChanged(value);
                        },
                        onDeleted: () {
                          final newPalettes =
                              List<ColorPalette>.from(pack?.palettes ?? [])
                                  .map((e) {
                            if (e.name == currentPalette?.name) {
                              return e.copyWith(
                                  colors: List<int>.from(e.colors)
                                    ..removeAt(index));
                            }
                            return e;
                          }).toList();
                          final newPack = pack?.copyWith(palettes: newPalettes);
                          if (newPack == null) return;
                          bloc.add(DocumentPackUpdated(
                              currentPalette!.name, newPack));
                        },
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          final response =
                              await showDialog<ColorPickerResponse>(
                            context: context,
                            builder: (context) => CustomColorPicker(
                              defaultColor: Color(widget.color),
                              pinOption: palette != null,
                            ),
                          );
                          if (response != null) {
                            widget.onChanged(response.color);
                            if (response.pin) {
                              final newPalettes =
                                  List<ColorPalette>.from(pack?.palettes ?? [])
                                      .map((e) {
                                if (e.name == currentPalette?.name) {
                                  return e.copyWith(
                                      colors: [...e.colors, response.color]);
                                }
                                return e;
                              }).toList();
                              final newPack =
                                  pack?.copyWith(palettes: newPalettes);
                              if (newPack == null) return;
                              bloc.add(DocumentPackUpdated(
                                  currentPalette!.name, newPack));
                            }
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: const AspectRatio(
                          aspectRatio: 1,
                          child: Icon(PhosphorIcons.plusLight),
                        ),
                      ),
                    ),
                  ]),
            )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: IconButton(
                  onPressed: () async {
                    final document = state.document;
                    final result = await showDialog<PackAssetLocation>(
                        context: context,
                        builder: (context) => SelectPackAssetDialog(
                            type: PackAssetType.palette, document: document));

                    if (result == null) return;
                    setState(() {
                      currentPalette = result;
                    });
                  },
                  icon: const Icon(PhosphorIcons.packageLight)),
            ),
          ),
        ],
      );
    });
  }
}

class _ColorButton extends StatelessWidget {
  final int current, color;
  final DocumentBloc bloc;
  final ValueChanged<int> onChanged;
  final VoidCallback? onDeleted;
  final bool chooseOnPress;

  const _ColorButton({
    required this.current,
    required this.color,
    required this.bloc,
    required this.onChanged,
    this.chooseOnPress = false,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> choose() async {
      final newColor = await showDialog<ColorPickerResponse>(
        context: context,
        builder: (context) => CustomColorPicker(
          defaultColor: Color(current),
          deleteOption: onDeleted != null,
        ),
      );
      if (newColor == null) return;
      if (newColor.delete) {
        onDeleted?.call();
      } else {
        onChanged(newColor.color);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => chooseOnPress ? choose() : onChanged(current),
        onLongPress: choose,
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(current),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color == current
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
