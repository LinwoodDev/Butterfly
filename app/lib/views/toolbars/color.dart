import 'package:butterfly/dialogs/packs/select.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';

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
      try {
        final packName = state.data.getPacks().firstOrNull;
        if (packName == null) return;
        final pack = state.data.getPack(packName);
        final palettes = pack?.getPalettes();
        if (palettes?.isEmpty ?? true) return;
        final palette = pack?.getPalette(palettes!.first);
        if (palette != null) {
          currentPalette =
              PackAssetLocation(pack: packName, name: palette.name);
        }
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      final bloc = context.read<DocumentBloc>();
      ColorPalette? palette;
      NoteData? pack;
      int color = Color(widget.color).withAlpha(255).value;

      if (state is! DocumentLoadSuccess) return Container();
      try {
        if (currentPalette != null) {
          pack = state.data.getPack(currentPalette!.pack);
          palette = pack?.getPalette(currentPalette!.name);
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!(palette?.colors.contains(color) ?? false)) ...[
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
                          color: color,
                          current: current,
                          onChanged: (value) {
                            widget.onChanged(value);
                          },
                          onDeleted: () {
                            var palette =
                                pack?.getPalette(currentPalette!.name);
                            palette = palette?.copyWith(
                              colors: List<int>.from(palette.colors)
                                ..removeAt(index),
                            );
                            pack?.setPalette(palette!);
                            bloc.add(DocumentPackUpdated(
                                currentPalette!.name, pack!));
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
                              builder: (context) => ColorPicker(
                                value: Color(widget.color),
                                pinOption: palette != null,
                              ),
                            );
                            if (response != null) {
                              widget.onChanged(response.color);
                              if (response.pin) {
                                var palette =
                                    pack?.getPalette(currentPalette!.name);
                                palette = palette?.copyWith(
                                  colors: [...palette.colors, response.color],
                                );
                                pack?.setPalette(palette!);
                                bloc.add(DocumentPackUpdated(
                                    currentPalette!.name, pack!));
                              }
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: const AspectRatio(
                            aspectRatio: 1,
                            child: PhosphorIcon(PhosphorIconsLight.plus),
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
                      final result = await showDialog<PackAssetLocation>(
                          context: context,
                          builder: (context) => BlocProvider.value(
                                value: bloc,
                                child: SelectPackAssetDialog(
                                  type: PackAssetType.palette,
                                  selected: currentPalette,
                                ),
                              ));

                      if (result == null) return;
                      setState(() {
                        currentPalette = result;
                      });
                    },
                    icon: const PhosphorIcon(PhosphorIconsLight.package)),
              ),
            ),
          ],
        );
      } catch (e) {
        return Container();
      }
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
        builder: (context) => ColorPicker(
          value: Color(current),
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
