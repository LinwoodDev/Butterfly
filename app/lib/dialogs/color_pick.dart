import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/visualizer/int.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../widgets/header.dart';
import '../widgets/exact_slider.dart';
import 'packs/select.dart';

class ColorPickerDialog extends StatefulWidget {
  final bool viewMode;
  final Color defaultColor;
  final ColorPalette? palette;
  final ValueChanged<ColorPalette>? onChanged;
  final DocumentBloc? bloc;

  const ColorPickerDialog({
    super.key,
    this.defaultColor = Colors.white,
    this.viewMode = false,
    this.bloc,
    this.palette,
    this.onChanged,
  });

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  PackAssetLocation? _selected;
  ColorPalette? _palette;

  @override
  void initState() {
    super.initState();
    _palette = widget.palette;
    if (widget.bloc != null) {
      final state = widget.bloc!.state;
      if (state is DocumentLoaded) {
        final pack = state.document.packs.firstOrNull;
        final palette = pack?.palettes.firstOrNull;
        if (palette != null) {
          _selected = PackAssetLocation(pack: pack!.name, name: palette.name);
        }
      }
    }
  }

  ColorPalette? _getPalette() {
    if (_palette != null) return _palette;
    if (_selected == null) return null;
    final state = widget.bloc?.state;
    if (state is! DocumentLoaded) return null;
    return state.document.getPalette(_selected!);
  }

  void _changePalette(ColorPalette palette) {
    if (widget.onChanged != null) {
      widget.onChanged!(palette);
      setState(() {
        _palette = palette;
      });
    } else {
      final state = widget.bloc?.state;
      if (state is! DocumentLoaded) return;
      final pack =
          _selected == null ? null : state.document.getPack(_selected!.name);
      if (pack == null) return;
      final newPalettes = pack.palettes.map((e) {
        if (e.name == palette.name) {
          return palette;
        }
        return e;
      }).toList();
      widget.bloc?.add(
          DocumentPackUpdated(pack.name, pack.copyWith(palettes: newPalettes)));
    }
  }

  void _showColorOperation(int index) {
    showModalBottomSheet(
        context: context,
        constraints: const BoxConstraints(maxWidth: 640),
        builder: (ctx) {
          final palette = _getPalette();
          if (palette == null) return Container();
          if ((palette.colors.length) <= index) return Container();
          final color = palette.colors[index];
          return SizedBox(
              height: 300,
              child: Column(children: [
                SizedBox(
                  height: 125,
                  child: Center(
                      child: Container(
                          color: Color(color), height: 75, width: 75)),
                ),
                const Divider(thickness: 1),
                Expanded(
                    child: ListView(children: [
                  ListTile(
                      leading: const Icon(PhosphorIcons.penLight),
                      title: Text(AppLocalizations.of(context).edit),
                      onTap: () async {
                        final value = await showDialog<ColorPickerResponse>(
                            context: context,
                            builder: (context) =>
                                CustomColorPicker(defaultColor: Color(color)));
                        if (value != null) {
                          _changePalette(palette.copyWith(
                              colors: palette.colors..[index] = value.color));
                        }
                      }),
                  ListTile(
                    leading: const Icon(PhosphorIcons.trashLight),
                    title: Text(AppLocalizations.of(context).delete),
                    onTap: () {
                      showDialog<void>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Text(
                                    AppLocalizations.of(context).areYouSure),
                                content: Text(
                                    AppLocalizations.of(context).reallyDelete),
                                actions: [
                                  TextButton(
                                      child:
                                          Text(AppLocalizations.of(context).no),
                                      onPressed: () => Navigator.of(ctx).pop()),
                                  ElevatedButton(
                                      child: Text(
                                          AppLocalizations.of(context).yes),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        Navigator.of(ctx).pop();
                                        _changePalette(palette.copyWith(
                                            colors: palette.colors
                                              ..removeAt(index)));
                                      })
                                ],
                              ));
                    },
                  )
                ]))
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    final palette = _getPalette();
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
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: constraints.maxWidth),
                                child: Row(
                                  children: [
                                    if (widget.palette == null) ...[
                                      IconButton(
                                        onPressed: () async {
                                          final state = widget.bloc?.state;
                                          if (state is! DocumentLoaded) {
                                            return;
                                          }
                                          final result = await showDialog<
                                              PackAssetLocation?>(
                                            context: context,
                                            builder: (context) =>
                                                SelectPackAssetDialog(
                                              selected: _selected,
                                              type: PackAssetType.palette,
                                              document: state.document,
                                            ),
                                          );
                                          if (result == null) return;
                                          setState(() {
                                            _selected = result;
                                          });
                                        },
                                        icon: const Icon(
                                            PhosphorIcons.packageLight),
                                      )
                                    ] else
                                      Expanded(
                                        child: TextFormField(
                                          initialValue: _palette?.name,
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)
                                                    .name,
                                            filled: true,
                                          ),
                                          onChanged: (value) {
                                            _changePalette(_palette!
                                                .copyWith(name: value));
                                          },
                                        ),
                                      ),
                                  ],
                                )),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Wrap(alignment: WrapAlignment.start, children: [
                        ...(List.generate(
                            palette?.colors.length ?? 0,
                            (index) => InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(32)),
                                onLongPress: () => _showColorOperation(index),
                                onTap: () => Navigator.of(context)
                                    .pop(palette!.colors[index]),
                                child: Container(
                                  width: 75,
                                  height: 75,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Color(palette!.colors[index]),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(32))),
                                )))).toList(),
                        if (palette != null)
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Material(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.5),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32))),
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(32)),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1322))),
                                  width: 75,
                                  height: 75,
                                  child: const Center(
                                      child: Icon(PhosphorIcons.plusLight,
                                          size: 42)),
                                ),
                                onTap: () async {
                                  var value =
                                      await showDialog<ColorPickerResponse>(
                                          context: context,
                                          builder: (context) =>
                                              CustomColorPicker(
                                                  defaultColor:
                                                      widget.defaultColor));
                                  if (value != null) {
                                    _changePalette(palette.copyWith(
                                        colors: List<int>.from(palette.colors)
                                          ..add(value.color)));
                                  }
                                },
                              ),
                            ),
                          )
                      ]),
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
                            builder: (context) => CustomColorPicker(
                                defaultColor: widget.defaultColor));
                        if (value != null) navigator.pop(value.color);
                      },
                      child: Text(AppLocalizations.of(context).custom)),
              ],
            ),
          ),
        ));
  }
}

class ColorPickerResponse {
  final int color;
  final bool pin;
  final bool delete;

  const ColorPickerResponse(this.color,
      [this.pin = false, this.delete = false]);
}

class CustomColorPicker extends StatefulWidget {
  final Color defaultColor;
  final bool pinOption, deleteOption;

  const CustomColorPicker(
      {super.key,
      this.defaultColor = Colors.white,
      this.pinOption = false,
      this.deleteOption = false});

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  late Color color;
  late final TextEditingController _hexController;

  @override
  void initState() {
    color = widget.defaultColor;
    _hexController = TextEditingController(text: color.value.toHexColor());
    super.initState();
  }

  void _changeColor({int? red, int? green, int? blue}) => setState(() {
        color = Color.fromARGB(
            255, red ?? color.red, green ?? color.green, blue ?? color.blue);
      });

  @override
  Widget build(BuildContext context) {
    if (_getColorValueFromHexString(_hexController.text) != color.value) {
      _hexController.text = color.value.toHexColor();
    }
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 1000),
        child: Column(
          children: [
            Header(
              title: Text(AppLocalizations.of(context).color),
              leading: const Icon(PhosphorIcons.paletteLight),
            ),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: LayoutBuilder(builder: (context, constraints) {
                  var isMobile = constraints.maxWidth < 600;
                  return Column(
                    children: [
                      Expanded(
                          child: isMobile
                              ? SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      _buildPreview(),
                                      _buildProperties(),
                                    ],
                                  ),
                                )
                              : Row(children: [
                                  Expanded(flex: 2, child: _buildPreview()),
                                  Expanded(
                                      flex: 3,
                                      child: SingleChildScrollView(
                                          child: _buildProperties()))
                                ])),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (widget.deleteOption) ...[
                            MaterialButton(
                                onPressed: () => Navigator.of(context).pop(
                                    ColorPickerResponse(
                                        color.value, false, true)),
                                child:
                                    Text(AppLocalizations.of(context).delete)),
                          ] else ...[
                            Container(),
                          ],
                          Row(children: [
                            TextButton(
                                child:
                                    Text(AppLocalizations.of(context).cancel),
                                onPressed: () => Navigator.of(context).pop()),
                            const SizedBox(width: 8),
                            if (widget.pinOption) ...[
                              OutlinedButton(
                                  child: Text(AppLocalizations.of(context).ok),
                                  onPressed: () => Navigator.of(context).pop(
                                      ColorPickerResponse(color.value, false))),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                  child: Text(AppLocalizations.of(context).pin),
                                  onPressed: () => Navigator.of(context).pop(
                                      ColorPickerResponse(color.value, true))),
                            ] else
                              ElevatedButton(
                                  child: Text(AppLocalizations.of(context).ok),
                                  onPressed: () => Navigator.of(context).pop(
                                      ColorPickerResponse(color.value, false))),
                          ]),
                        ],
                      )
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                constraints:
                    const BoxConstraints(maxHeight: 200, maxWidth: 200),
                color: color),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextField(
              controller: _hexController,
              decoration: const InputDecoration(filled: true),
              onSubmitted: (value) {
                final valueNumber = _getColorValueFromHexString(value);
                if (valueNumber == null) return;
                setState(() {
                  color = Color(valueNumber);
                });
              },
            ),
          ),
        ],
      );

  int? _getColorValueFromHexString(String value) {
    value = value.trim();
    if (value.startsWith('#')) value = value.substring(1);
    if (value.length == 3) {
      value = 'f$value';
    } else if (value.length == 6) {
      value = 'ff$value';
    }
    if (value.length == 4) {
      value = value[0] +
          value[0] +
          value[1] +
          value[1] +
          value[2] +
          value[2] +
          value[3] +
          value[3];
    }
    value = value.trim();
    return int.tryParse(value, radix: 16);
  }

  Widget _buildProperties() => Column(children: [
        ExactSlider(
          header: Text(AppLocalizations.of(context).red),
          fractionDigits: 0,
          defaultValue: 255,
          min: 0,
          max: 255,
          value: color.red.toDouble(),
          color: Colors.red,
          onChanged: (value) => _changeColor(red: value.toInt()),
        ),
        ExactSlider(
          header: Text(AppLocalizations.of(context).green),
          fractionDigits: 0,
          defaultValue: 255,
          min: 0,
          max: 255,
          value: color.green.toDouble(),
          color: Colors.green,
          onChanged: (value) => _changeColor(green: value.toInt()),
        ),
        ExactSlider(
          header: Text(AppLocalizations.of(context).blue),
          fractionDigits: 0,
          defaultValue: 255,
          min: 0,
          max: 255,
          color: Colors.blue,
          value: color.blue.toDouble(),
          onChanged: (value) => _changeColor(blue: value.toInt()),
        ),
      ]);
}
