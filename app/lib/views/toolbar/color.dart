import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/packs/select.dart';
import 'package:butterfly/views/toolbar/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';

enum ColorPickerToolbarAction { delete, pin, eyeDropper }

class ColorToolbarView extends StatefulWidget implements PreferredSizeWidget {
  final SRGBColor color;
  final ValueChanged<SRGBColor> onChanged;
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
  late final PackFileSystem _packSystem;
  final ScrollController _scrollController = ScrollController();
  PackItem<ColorPalette>? _colorPalette;

  @override
  void initState() {
    super.initState();
    _packSystem = context.read<ButterflyFileSystem>().buildDefaultPackSystem();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final palette = await _findPalette();
      setState(() {
        _colorPalette = palette;
      });
    });
  }

  Future<PackItem<ColorPalette>?> _findPalette() async {
    final files = await _packSystem.getKeys();
    for (final name in files) {
      final pack = await _packSystem.getFile(name);
      if (pack == null) continue;
      final palettes = pack.getPalettes();
      return palettes.map((e) {
        final palette = pack.getPalette(e);
        if (palette == null) return null;
        return PackItem<ColorPalette>.build(
          name,
          e,
          pack,
          palette,
        );
      }).firstOrNull;
    }
    return null;
  }

  Future<void> _updatePalette(ColorPalette palette) async {
    var selected = _colorPalette;
    if (selected == null) return;
    final newPack = selected.pack.setPalette(selected.key, palette);
    return _packSystem.updateFile(
      selected.namespace,
      newPack,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addColor() async {
    final settingsCubit = context.read<SettingsCubit>();
    final response =
        await showDialog<ColorPickerResponse<ColorPickerToolbarAction>>(
      context: context,
      builder: (context) => ColorPicker<ColorPickerToolbarAction>(
        value: widget.color,
        suggested: settingsCubit.state.recentColors,
        secondaryActions: widget.onEyeDropper == null
            ? null
            : (close) => [
                  OutlinedButton(
                    onPressed: () => close(ColorPickerToolbarAction.eyeDropper),
                    child: Text(AppLocalizations.of(context).eyeDropper),
                  ),
                ],
        primaryActions: _colorPalette == null
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
    final srgb = response.toSRGB();
    widget.onChanged(srgb);
    if (response.action == ColorPickerToolbarAction.eyeDropper) {
      widget.onEyeDropper?.call(context);
      return;
    }
    if (response.action != ColorPickerToolbarAction.pin) {
      settingsCubit.addRecentColors(srgb);
      return;
    }
  }

  void _changeColor(int index, SRGBColor value) async {
    final palette = _colorPalette;
    if (palette == null) return;
    final settingsCubit = context.read<SettingsCubit>();
    final response =
        await showDialog<ColorPickerResponse<ColorPickerToolbarAction>>(
      context: context,
      builder: (context) => ColorPicker<ColorPickerToolbarAction>(
        value: value,
        suggested: settingsCubit.state.recentColors,
        secondaryActions: (close) => [
          OutlinedButton(
            onPressed: () => close(
              ColorPickerToolbarAction.delete,
            ),
            child: Text(
              AppLocalizations.of(context).delete,
            ),
          ),
        ],
      ),
    );
    if (response == null) return;
    if (response.action == ColorPickerToolbarAction.delete) {
      _updatePalette(palette.item.copyWith(
        colors: List<SRGBColor>.from(palette.item.colors)..removeAt(index),
      ));
    } else {
      _updatePalette(palette.item.copyWith(
        colors: List<SRGBColor>.from(palette.item.colors)
          ..add(response.toSRGB()),
      ));
    }
    widget.onChanged(response.toSRGB());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
    SRGBColor color = widget.color.withValues(a: 255);

    final palette = _colorPalette?.item;

    return Scrollbar(
      controller: _scrollController,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        children: [
          if (!(palette?.colors.contains(color) ?? false)) ...[
            ColorButton.srgb(
              color: widget.color,
              selected: true,
              onTap: _addColor,
            ),
            if (palette != null) const VerticalDivider(),
          ],
          if (palette != null) ...[
            ...List.generate(palette.colors.length, (index) {
              final value = palette.colors[index];

              return ColorButton.srgb(
                color: value,
                selected: value == color,
                onTap: () => widget.onChanged(value),
                onSecondaryTap: () => _changeColor(index, value),
                onLongPress: () => _changeColor(index, value),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: _addColor,
                borderRadius: BorderRadius.circular(12),
                child: const AspectRatio(
                  aspectRatio: 1,
                  child: PhosphorIcon(PhosphorIconsLight.plus),
                ),
              ),
            ),
          ],
          AspectRatio(
            aspectRatio: 1,
            child: IconButton(
              onPressed: () async {
                final result = await showDialog<PackItem<ColorPalette>>(
                  context: context,
                  builder: (context) => SelectPackAssetDialog<ColorPalette>(
                    selectedObject: _colorPalette?.item,
                  ),
                );

                if (result == null) return;
                setState(() {
                  _colorPalette = result;
                });
              },
              icon: const PhosphorIcon(PhosphorIconsLight.package),
              tooltip: AppLocalizations.of(context).selectAsset,
            ),
          ),
        ],
      ),
    );
  }
}
