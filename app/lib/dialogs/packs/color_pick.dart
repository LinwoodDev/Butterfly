import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../delete.dart';
import 'select.dart';

class ColorPalettePickerDialog extends StatefulWidget {
  final bool viewMode;
  final SRGBColor value;
  final ColorPalette? palette;
  final ValueChanged<ColorPalette>? onChanged;
  final DocumentBloc? bloc;

  const ColorPalettePickerDialog({
    super.key,
    this.value = SRGBColor.white,
    this.viewMode = false,
    this.bloc,
    this.palette,
    this.onChanged,
  });

  @override
  _ColorPalettePickerDialogState createState() =>
      _ColorPalettePickerDialogState();
}

class _ColorPalettePickerDialogState extends State<ColorPalettePickerDialog> {
  late final PackFileSystem _packSystem;
  NoteData? _pack;
  PackItem<ColorPalette>? _selected;
  ColorPalette? _palette;

  @override
  void initState() {
    super.initState();
    _palette = widget.palette;
    _packSystem = context.read<ButterflyFileSystem>().buildDefaultPackSystem();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPalette();
    });
  }

  Future<void> _loadPalette() async {
    final pack = await _packSystem.getDefaultFile(_selected?.namespace ?? '');
    if (pack == null) return;
    final palette =
        pack.getPalette(_selected?.key ?? '') ??
        pack.getNamedPalettes().firstOrNull?.item;
    if (palette == null) return;
    setState(() {
      _pack = pack;
      _palette = palette;
    });
  }

  void _changePalette(ColorPalette palette, [String? name]) {
    if (widget.onChanged != null) {
      widget.onChanged!(palette);
    } else {
      setState(() {
        _palette = palette;
      });
      final location = _selected;
      if (location == null) return;
      final newPack = _pack?.setPalette(name ?? location.key, palette);
      if (newPack == null) return;
      _packSystem.updateFile(location.namespace, newPack);
    }
  }

  void _showColorOperation(int index) {
    showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(maxWidth: 640),
      showDragHandle: true,
      builder: (ctx) {
        if (_palette == null) return Container();
        if ((_palette!.colors.length) <= index) return Container();
        final color = _palette!.colors[index];
        final colorText = color.toHexString(alpha: false);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: color.toColor(),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 75,
                    width: 75,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      child: Text(
                        colorText,
                        style: TextTheme.of(context).headlineLarge,
                      ),
                      onTap: () => saveToClipboard(context, colorText),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            ListTile(
              leading: const PhosphorIcon(PhosphorIconsLight.pen),
              title: Text(AppLocalizations.of(context).edit),
              onTap: () async {
                final value = await showDialog<ColorPickerResponse>(
                  context: context,
                  builder: (context) => ColorPicker(value: color),
                );
                if (value != null) {
                  _changePalette(
                    _palette!.copyWith(
                      colors: List.from(_palette!.colors)
                        ..[index] = value.toSRGB(),
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const PhosphorIcon(PhosphorIconsLight.trash),
              title: Text(AppLocalizations.of(context).delete),
              onTap: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => const DeleteDialog(),
                );
                if (result != true) return;
                if (context.mounted) {
                  Navigator.of(context).pop();
                  _changePalette(
                    _palette!.copyWith(
                      colors: List.from(_palette!.colors)..removeAt(index),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Material(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: constraints.maxWidth,
                              ),
                              child: Row(
                                children: [
                                  if (widget.palette == null) ...[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            _selected?.key ?? '',
                                            style: TextTheme.of(
                                              context,
                                            ).headlineSmall,
                                          ),
                                          Text(
                                            _selected?.namespace ?? '',
                                            style: TextTheme.of(
                                              context,
                                            ).labelLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final state = widget.bloc?.state;
                                        if (state is! DocumentLoaded) {
                                          return;
                                        }
                                        final result =
                                            await showDialog<
                                              PackItem<ColorPalette>
                                            >(
                                              context: context,
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                    value: widget.bloc!,
                                                    child: SelectPackAssetDialog(
                                                      selectedItem: _selected
                                                          ?.toNamed(),
                                                      getItems: (pack) => pack
                                                          .getNamedPalettes(),
                                                    ),
                                                  ),
                                            );
                                        if (result == null) return;
                                        setState(() {
                                          _selected = result;
                                          _loadPalette();
                                        });
                                      },
                                      tooltip: AppLocalizations.of(
                                        context,
                                      ).select,
                                      icon: const PhosphorIcon(
                                        PhosphorIconsLight.package,
                                      ),
                                    ),
                                  ] else
                                    Expanded(
                                      child: TextFormField(
                                        initialValue: _selected?.key,
                                        decoration: InputDecoration(
                                          labelText: LeapLocalizations.of(
                                            context,
                                          ).name,
                                          filled: true,
                                        ),
                                        onChanged: (value) {
                                          _changePalette(_palette!, value);
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        ...List.generate(
                          _palette?.colors.length ?? 0,
                          (index) => InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(32),
                            ),
                            onLongPress: () => _showColorOperation(index),
                            onSecondaryTap: () => _showColorOperation(index),
                            onTap: () => Navigator.of(
                              context,
                            ).pop(_palette!.colors[index]),
                            child: Container(
                              width: 75,
                              height: 75,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: _palette!.colors[index].toColor(),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(32),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (_palette != null)
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Material(
                              color: Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withValues(alpha: 0.5),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32),
                                ),
                              ),
                              child: InkWell(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(32),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(1322),
                                    ),
                                  ),
                                  width: 75,
                                  height: 75,
                                  child: const Center(
                                    child: PhosphorIcon(
                                      PhosphorIconsLight.plus,
                                      size: 42,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  final value =
                                      await showDialog<ColorPickerResponse>(
                                        context: context,
                                        builder: (context) =>
                                            ColorPicker(value: widget.value),
                                      );
                                  if (value == null) return;
                                  _changePalette(
                                    _palette!.copyWith(
                                      colors: List<SRGBColor>.from(
                                        _palette!.colors,
                                      )..add(value.toSRGB()),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              if (!widget.viewMode)
                ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    var value = await showDialog<ColorPickerResponse>(
                      context: context,
                      builder: (context) => ColorPicker(value: widget.value),
                    );
                    if (value != null) navigator.pop(value.value);
                  },
                  child: Text(AppLocalizations.of(context).custom),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
