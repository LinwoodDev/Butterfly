import 'package:butterfly/dialogs/packs/select.dart';
import 'package:butterfly/views/toolbar.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';

class ColorToolbarView extends StatefulWidget implements PreferredSizeWidget {
  final int color;
  final ValueChanged<int> onChanged;

  const ColorToolbarView({
    super.key,
    required this.color,
    required this.onChanged,
  });

  @override
  State<ColorToolbarView> createState() => _ColorToolbarViewState();

  @override
  Size get preferredSize => kToolbarSmall;
}

class _ColorToolbarViewState extends State<ColorToolbarView> {
  final ScrollController _scrollController = ScrollController();
  PackAssetLocation? colorPalette;
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
          colorPalette = PackAssetLocation(packName, palette.name);
        }
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
    final bloc = context.read<DocumentBloc>();
    final document = state.data;
    ColorPalette? palette;
    NoteData? pack;
    int color = Color(widget.color).withAlpha(255).value;

    try {
      if (colorPalette != null) {
        pack = document.getPack(colorPalette!.pack);
        palette = pack?.getPalette(colorPalette!.name);
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!(palette?.colors.contains(color) ?? false)) ...[
            _ColorButton(
              value: widget.color,
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
                      final value = palette!.colors[index];
                      return _ColorButton(
                        bloc: bloc,
                        color: color,
                        value: value,
                        onChanged: (value) {
                          widget.onChanged(value);
                        },
                        onDeleted: () {
                          var palette = pack?.getPalette(colorPalette!.name);
                          palette = palette?.copyWith(
                            colors: List<int>.from(palette.colors)
                              ..removeAt(index),
                          );
                          bloc.add(PackUpdated(
                              colorPalette!.pack, pack!.setPalette(palette!)));
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
                          if (response == null) return;
                          widget.onChanged(response.color);
                          if (!response.pin) return;
                          var currentPalette =
                              pack?.getPalette(colorPalette!.name);
                          currentPalette = currentPalette?.copyWith(
                            colors: [...currentPalette.colors, response.color],
                          );
                          bloc.add(PackUpdated(colorPalette!.pack,
                              pack!.setPalette(currentPalette!)));
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
          AspectRatio(
            aspectRatio: 1,
            child: IconButton(
              onPressed: () async {
                final result = await showDialog<PackAssetLocation>(
                    context: context,
                    builder: (context) => BlocProvider.value(
                          value: bloc,
                          child: SelectPackAssetDialog(
                            type: PackAssetType.palette,
                            selected: colorPalette,
                          ),
                        ));

                if (result == null) return;
                setState(() {
                  colorPalette = result;
                });
              },
              icon: const PhosphorIcon(PhosphorIconsLight.package),
              tooltip: AppLocalizations.of(context).selectAsset,
            ),
          ),
        ],
      );
    } catch (e) {
      return Container();
    }
  }
}

class _ColorButton extends StatelessWidget {
  final int value, color;
  final DocumentBloc bloc;
  final ValueChanged<int> onChanged;
  final VoidCallback? onDeleted;
  final bool chooseOnPress;

  const _ColorButton({
    required this.value,
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
          value: Color(value),
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
        onTap: () => chooseOnPress ? choose() : onChanged(value),
        onLongPress: choose,
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Color(value),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color == value
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
