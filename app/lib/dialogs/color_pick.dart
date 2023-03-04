import 'dart:convert';

import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/import.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/visualizer/int.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../widgets/header.dart';
import 'export.dart';
import '../widgets/exact_slider.dart';

class ColorPickerDialog extends StatefulWidget {
  final bool viewMode;
  final Color defaultColor;

  const ColorPickerDialog(
      {super.key, this.defaultColor = Colors.white, this.viewMode = false});

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  int selected = 0;

  void _showColorOperation(int index) {
    showModalBottomSheet(
        context: context,
        constraints: const BoxConstraints(maxWidth: 640),
        builder: (ctx) => BlocProvider.value(
              value: context.read<DocumentBloc>(),
              child: BlocBuilder<DocumentBloc, DocumentState>(
                  builder: (ctx, state) {
                if (state is! DocumentLoadSuccess) return Container();
                var palette = state.document.palettes[selected];
                if ((palette.colors.length) <= index) return Container();
                final color = palette.colors[index];
                final newPalettes =
                    List<ColorPalette>.from(state.document.palettes);
                final newPalette = List<int>.from(palette.colors);
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
                              final bloc = context.read<DocumentBloc>();
                              final value =
                                  await showDialog<ColorPickerResponse>(
                                      context: context,
                                      builder: (context) => CustomColorPicker(
                                          defaultColor: Color(color)));
                              if (value != null) {
                                newPalette[index] = value.color;
                                newPalettes[selected] =
                                    palette.copyWith(colors: newPalette);
                                bloc.add(DocumentPaletteChanged(newPalettes));
                              }
                            }),
                        ListTile(
                          leading: const Icon(PhosphorIcons.trashLight),
                          title: Text(AppLocalizations.of(context).delete),
                          onTap: () {
                            showDialog<void>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: Text(AppLocalizations.of(context)
                                          .areYouSure),
                                      content: Text(AppLocalizations.of(context)
                                          .reallyDelete),
                                      actions: [
                                        TextButton(
                                            child: Text(
                                                AppLocalizations.of(context)
                                                    .no),
                                            onPressed: () =>
                                                Navigator.of(ctx).pop()),
                                        ElevatedButton(
                                            child: Text(
                                                AppLocalizations.of(context)
                                                    .yes),
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                              Navigator.of(ctx).pop();
                                              newPalette.removeAt(index);
                                              newPalettes[selected] = palette
                                                  .copyWith(colors: newPalette);
                                              context.read<DocumentBloc>().add(
                                                  DocumentPaletteChanged(
                                                      newPalettes));
                                            })
                                      ],
                                    ));
                          },
                        )
                      ]))
                    ]));
              }),
            ));
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
                BlocBuilder<DocumentBloc, DocumentState>(
                    builder: (context, state) {
                  if (state is! DocumentLoadSuccess) {
                    return Container();
                  }
                  var empty = state.document.palettes.isEmpty;
                  selected = empty
                      ? 0
                      : selected.clamp(0, state.document.palettes.length - 1);
                  var palette = empty
                      ? <int>[]
                      : state.document.palettes[selected].colors;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Material(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LayoutBuilder(builder: (context, constraints) {
                            return SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: constraints.maxWidth),
                                child: Wrap(
                                  verticalDirection: VerticalDirection.up,
                                  runAlignment: WrapAlignment.end,
                                  alignment: WrapAlignment.spaceAround,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          DropdownMenu<int>(
                                            initialSelection:
                                                state.document.palettes.isEmpty
                                                    ? null
                                                    : selected,
                                            onSelected: (value) {
                                              setState(() {
                                                selected = value ?? selected;
                                              });
                                            },
                                            dropdownMenuEntries: state
                                                .document.palettes
                                                .asMap()
                                                .entries
                                                .map((e) =>
                                                    DropdownMenuEntry<int>(
                                                      value: e.key,
                                                      label: e.value.name,
                                                    ))
                                                .toList(),
                                          ),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)
                                                      .add,
                                              icon: const Icon(
                                                  PhosphorIcons.plusLight),
                                              onPressed: _createPalette),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)
                                                      .edit,
                                              icon: const Icon(
                                                  PhosphorIcons.penLight),
                                              onPressed:
                                                  empty ? null : _editPalette),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)
                                                      .remove,
                                              icon: const Icon(
                                                  PhosphorIcons.minusLight),
                                              onPressed: empty
                                                  ? null
                                                  : _deletePalette),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const VerticalDivider(),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)
                                                      .import,
                                              icon: const Icon(PhosphorIcons
                                                  .arrowSquareInLight),
                                              onPressed: _importPalette),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)
                                                      .export,
                                              icon: const Icon(
                                                  PhosphorIcons.exportLight),
                                              onPressed: _exportPalette),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)
                                                      .help,
                                              icon: const Icon(PhosphorIcons
                                                  .circleWavyQuestionLight),
                                              onPressed: () =>
                                                  openHelp(['color_picker'])),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)
                                                      .resetPalette,
                                              icon: const Icon(PhosphorIcons
                                                  .clockClockwiseLight),
                                              onPressed: _resetPalette),
                                          const VerticalDivider(),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)
                                                      .close,
                                              icon: const Icon(
                                                  PhosphorIcons.xLight),
                                              onPressed: () =>
                                                  Navigator.of(context).pop()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Wrap(alignment: WrapAlignment.start, children: [
                          if (state.document.palettes.isNotEmpty)
                            ...(List.generate(
                                palette.length,
                                (index) => InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(32)),
                                    onLongPress: () =>
                                        _showColorOperation(index),
                                    onTap: () => Navigator.of(context)
                                        .pop(palette[index]),
                                    child: Container(
                                      width: 75,
                                      height: 75,
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Color(palette[index]),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(32))),
                                    )))).toList(),
                          if (selected < state.document.palettes.length)
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(32)),
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
                                    final bloc = context.read<DocumentBloc>();
                                    var value =
                                        await showDialog<ColorPickerResponse>(
                                            context: context,
                                            builder: (context) =>
                                                CustomColorPicker(
                                                    defaultColor:
                                                        widget.defaultColor));
                                    if (value != null) {
                                      var newPalettes = List<ColorPalette>.from(
                                          state.document.palettes);
                                      newPalettes[selected] =
                                          newPalettes[selected].copyWith(
                                              colors: List<int>.from(
                                                  newPalettes[selected].colors)
                                                ..add(value.color));
                                      bloc.add(
                                          DocumentPaletteChanged(newPalettes));
                                    }
                                  },
                                ),
                              ),
                            )
                        ]),
                      ),
                    ],
                  );
                }),
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

  Future<void> _importPalette() async {
    final bloc = context.read<DocumentBloc>();
    final data = await showDialog<String>(
        builder: (context) => const ImportDialog(), context: context);
    final palettes = <ColorPalette>[];
    if (data == null) return;
    var value = jsonDecode(data);
    palettes.addAll(List<Map<String, dynamic>>.from(value['palettes'])
        .map((e) => ColorPalette.fromJson(e))
        .toList());
    bloc.add(DocumentPaletteChanged(palettes));
  }

  Future<void> _exportPalette() async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    var data = json.encode({
      'fileVersion': kFileVersion,
      'palettes': state.document.palettes.map((e) => e.toJson()).toList()
    });
    showDialog<void>(
        context: context, builder: (context) => ExportDialog(data: data));
  }

  Future<void> _createPalette() async {
    final bloc = context.read<DocumentBloc>();
    final palettes = (bloc.state as DocumentLoadSuccess).document.palettes;
    final name = await showDialog<String>(
        context: context,
        builder: (context) => NameDialog(
              validator: defaultNameValidator(
                  context, null, palettes.map((e) => e.name).toList()),
            ));
    if (name == null) return;

    bloc.add(DocumentPaletteChanged(
      List<ColorPalette>.from(
          (bloc.state as DocumentLoadSuccess).document.palettes)
        ..add(ColorPalette(name: name)),
    ));
  }

  Future<void> _editPalette() async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state as DocumentLoadSuccess;
    if (selected >= state.document.palettes.length || selected < 0) return;
    var newPalettes = List<ColorPalette>.from(state.document.palettes);
    final name = await showDialog<String>(
        context: context,
        builder: (context) => NameDialog(
            validator: defaultNameValidator(context, newPalettes[selected].name,
                newPalettes.map((e) => e.name).toList())));
    if (name == null) return;
    newPalettes[selected] = newPalettes[selected].copyWith(name: name);
    bloc.add(DocumentPaletteChanged(newPalettes));
  }

  Future<void> _deletePalette() async {
    var state = context.read<DocumentBloc>().state as DocumentLoadSuccess;
    if (selected >= state.document.palettes.length || selected < 0) return;
    return showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(AppLocalizations.of(context).areYouSure),
              content: Text(AppLocalizations.of(context).reallyDelete),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(AppLocalizations.of(context).no)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      var newPalettes =
                          List<ColorPalette>.from(state.document.palettes);
                      newPalettes.removeAt(selected);
                      context
                          .read<DocumentBloc>()
                          .add(DocumentPaletteChanged(newPalettes));
                      if (selected >= newPalettes.length && selected <= 0) {
                        selected = newPalettes.length - 1;
                      }
                    },
                    child: Text(AppLocalizations.of(context).yes)),
              ],
            ));
  }

  Future<void> _resetPalette() {
    return showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
                title: Text(AppLocalizations.of(ctx).areYouSure),
                content: Text(AppLocalizations.of(ctx).reallyReset),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(AppLocalizations.of(ctx).no)),
                  ElevatedButton(
                      onPressed: () {
                        selected = 0;
                        context.read<DocumentBloc>().add(DocumentPaletteChanged(
                            DocumentDefaults.getMaterialPalette(context)));
                        Navigator.of(ctx).pop();
                      },
                      child: Text(AppLocalizations.of(context).yes))
                ]));
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
