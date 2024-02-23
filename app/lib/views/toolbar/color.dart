import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/packs/select.dart';
import 'package:butterfly/views/toolbar/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';

enum ColorPickerToolbarAction { delete, pin, eyeDropper }

class ColorToolbarView extends StatefulWidget implements PreferredSizeWidget {
  final int color;
  final ValueChanged<int> onChanged;
  final void Function(BuildContext)? onEyeDropper;

  const ColorToolbarView({
    super.key,
    required this.color,
    required this.onChanged,
    this.onEyeDropper,
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

    void addColor() async {
      final settingsCubit = context.read<SettingsCubit>();
      final response =
          await showDialog<ColorPickerResponse<ColorPickerToolbarAction>>(
        context: context,
        builder: (context) => ColorPicker<ColorPickerToolbarAction>(
          value: Color(widget.color),
          suggested:
              settingsCubit.state.recentColors.map((e) => Color(e)).toList(),
          secondaryActions: widget.onEyeDropper == null
              ? null
              : (close) => [
                    OutlinedButton(
                      onPressed: () =>
                          close(ColorPickerToolbarAction.eyeDropper),
                      child: Text(AppLocalizations.of(context).eyeDropper),
                    ),
                  ],
          primaryActions: palette == null
              ? null
              : (close) => [
                    OutlinedButton(
                      onPressed: () => close(ColorPickerToolbarAction.pin),
                      child: Text(AppLocalizations.of(context).pin),
                    ),
                  ],
        ),
      );
      if (response == null) return;
      widget.onChanged(response.color);
      if (response.action == ColorPickerToolbarAction.eyeDropper) {
        widget.onEyeDropper?.call(context);
        return;
      }
      if (response.action != ColorPickerToolbarAction.pin) {
        settingsCubit.addRecentColors(response.color);
        return;
      }
      var currentPalette = pack?.getPalette(colorPalette!.name);
      currentPalette = currentPalette?.copyWith(
        colors: [...currentPalette.colors, response.color],
      );
      bloc.add(
          PackUpdated(colorPalette!.pack, pack!.setPalette(currentPalette!)));
    }

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
            ColorButton(
              color: Color(widget.color),
              selected: true,
              onTap: addColor,
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
                      void changeColor() async {
                        var palette = pack?.getPalette(colorPalette!.name);
                        final settingsCubit = context.read<SettingsCubit>();
                        final response = await showDialog<
                            ColorPickerResponse<ColorPickerToolbarAction>>(
                          context: context,
                          builder: (context) =>
                              ColorPicker<ColorPickerToolbarAction>(
                            value: Color(value),
                            suggested: settingsCubit.state.recentColors
                                .map((e) => Color(e))
                                .toList(),
                            secondaryActions: (close) => [
                              OutlinedButton(
                                onPressed: () =>
                                    close(ColorPickerToolbarAction.delete),
                                child:
                                    Text(AppLocalizations.of(context).delete),
                              ),
                            ],
                          ),
                        );
                        if (response == null) return;
                        if (response.action ==
                            ColorPickerToolbarAction.delete) {
                          palette = palette?.copyWith(
                            colors: List<int>.from(palette.colors)
                              ..removeAt(index),
                          );
                        } else {
                          palette = palette?.copyWith(
                            colors: List<int>.from(palette.colors)
                              ..[index] = response.color,
                          );
                        }
                        bloc.add(PackUpdated(
                            colorPalette!.pack, pack!.setPalette(palette!)));
                        widget.onChanged(response.color);
                        setState(() {});
                      }

                      return ColorButton(
                        color: Color(value),
                        selected: value == color,
                        onTap: () => widget.onChanged(value),
                        onSecondaryTap: changeColor,
                        onLongPress: changeColor,
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: addColor,
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
