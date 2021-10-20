import 'dart:convert';

import 'package:butterfly/api/open_help.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/open.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'save.dart';

class ColorPickerDialog extends StatefulWidget {
  final DocumentBloc bloc;
  final bool viewMode;
  final Color defaultColor;
  const ColorPickerDialog(
      {Key? key, required this.bloc, this.defaultColor = Colors.white, this.viewMode = false})
      : super(key: key);

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  String? selected;

  void _showColorOperation(int index) {
    if (selected == null) return;
    showModalBottomSheet(
        context: context,
        builder: (context) => BlocProvider.value(
              value: widget.bloc,
              child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                if (state is! DocumentLoadSuccess) return Container();
                var palettes = state.document.palettes[selected];
                if ((palettes?.length ?? 0) <= index) return Container();
                final color = palettes?[index] ?? Colors.white;
                final newPalettes = Map<String, List<Color>>.from(state.document.palettes);
                final newPalette = List<Color>.from(newPalettes[selected] ?? []);
                return SizedBox(
                    height: 300,
                    child: Column(children: [
                      SizedBox(
                        height: 125,
                        child: Center(child: Container(color: color, height: 100, width: 100)),
                      ),
                      const Divider(thickness: 1),
                      Expanded(
                          child: ListView(children: [
                        ListTile(
                            leading: const Icon(PhosphorIcons.penLight),
                            title: Text(AppLocalizations.of(context)!.edit),
                            onTap: () async {
                              var value = await showDialog(
                                  context: context,
                                  builder: (context) => CustomColorPicker(defaultColor: color));
                              if (value != null) {
                                newPalette[index] = value;
                                newPalettes[selected!] = newPalette;
                                widget.bloc.add(DocumentPaletteChanged(newPalettes));
                              }
                            }),
                        ListTile(
                          leading: const Icon(PhosphorIcons.trashLight),
                          title: Text(AppLocalizations.of(context)!.delete),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(AppLocalizations.of(context)!.areYouSure),
                                      content: Text(AppLocalizations.of(context)!.reallyDelete),
                                      actions: [
                                        TextButton(
                                            child: Text(AppLocalizations.of(context)!.no),
                                            onPressed: () => Navigator.of(context).pop()),
                                        TextButton(
                                            child: Text(AppLocalizations.of(context)!.yes),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                              newPalette.removeAt(index);
                                              newPalettes[selected!] = newPalette;
                                              widget.bloc.add(DocumentPaletteChanged(newPalettes));
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
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                    if (state is! DocumentLoadSuccess) {
                      return Container();
                    }
                    selected ??=
                        state.document.palettes.isEmpty ? null : state.document.palettes.keys.first;
                    var palette = state.document.palettes.isEmpty
                        ? []
                        : state.document.palettes[selected ?? state.document.palettes.keys.first] ??
                            [];
                    return Column(
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
                                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                                  child: Wrap(
                                    verticalDirection: VerticalDirection.up,
                                    runAlignment: WrapAlignment.end,
                                    alignment: WrapAlignment.spaceAround,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    children: [
                                      DropdownButton<String>(
                                        alignment: Alignment.center,
                                        value: selected ??
                                            (state.document.palettes.isNotEmpty
                                                ? state.document.palettes.keys.first
                                                : null),
                                        onChanged: (value) {
                                          setState(() {
                                            selected = value;
                                          });
                                        },
                                        items: state.document.palettes.keys.map((color) {
                                          return DropdownMenuItem<String>(
                                            value: color,
                                            child: Text(color),
                                          );
                                        }).toList(),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                tooltip: AppLocalizations.of(context)!.add,
                                                icon: const Icon(PhosphorIcons.plusLight),
                                                onPressed: () {
                                                  final _nameController = TextEditingController();
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) => AlertDialog(
                                                              actions: [
                                                                TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.of(context).pop(),
                                                                    child: Text(AppLocalizations.of(
                                                                            context)!
                                                                        .cancel)),
                                                                TextButton(
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                      widget.bloc.add(
                                                                          DocumentPaletteChanged(
                                                                        Map<String,
                                                                                List<Color>>.from(
                                                                            state.document.palettes)
                                                                          ..[_nameController.text] =
                                                                              [],
                                                                      ));
                                                                    },
                                                                    child: Text(AppLocalizations.of(
                                                                            context)!
                                                                        .create)),
                                                              ],
                                                              title: Text(
                                                                  AppLocalizations.of(context)!
                                                                      .enterName),
                                                              content: TextField(
                                                                  autofocus: true,
                                                                  controller: _nameController)));
                                                }),
                                            IconButton(
                                                tooltip: AppLocalizations.of(context)!.edit,
                                                icon: const Icon(PhosphorIcons.penLight),
                                                onPressed: () {
                                                  if (selected == null) return;
                                                  final _nameController =
                                                      TextEditingController(text: selected ?? "");
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) => AlertDialog(
                                                              actions: [
                                                                TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.of(context).pop(),
                                                                    child: Text(AppLocalizations.of(
                                                                            context)!
                                                                        .cancel)),
                                                                TextButton(
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                      if (selected == null ||
                                                                          state.document.palettes[
                                                                                  selected] ==
                                                                              null ||
                                                                          _nameController.text ==
                                                                              selected) {
                                                                        return;
                                                                      }
                                                                      var newPalettes = Map<String,
                                                                              List<Color>>.from(
                                                                          state.document.palettes);
                                                                      newPalettes[_nameController
                                                                              .text] =
                                                                          newPalettes[selected!] ??
                                                                              [];
                                                                      newPalettes.remove(selected!);
                                                                      selected = null;
                                                                      widget.bloc.add(
                                                                          DocumentPaletteChanged(
                                                                              newPalettes));
                                                                    },
                                                                    child: Text(AppLocalizations.of(
                                                                            context)!
                                                                        .ok)),
                                                              ],
                                                              title: Text(
                                                                  AppLocalizations.of(context)!
                                                                      .enterName),
                                                              content: TextField(
                                                                  autofocus: true,
                                                                  controller: _nameController)));
                                                }),
                                            IconButton(
                                                tooltip: AppLocalizations.of(context)!.remove,
                                                icon: const Icon(PhosphorIcons.minusLight),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) => AlertDialog(
                                                            title: Text(
                                                                AppLocalizations.of(context)!
                                                                    .areYouSure),
                                                            content: Text(
                                                                AppLocalizations.of(context)!
                                                                    .reallyDelete),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.of(context).pop(),
                                                                  child: Text(
                                                                      AppLocalizations.of(context)!
                                                                          .no)),
                                                              TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                    if (selected == null) {
                                                                      return;
                                                                    }
                                                                    var newPalettes = Map<String,
                                                                            List<Color>>.from(
                                                                        state.document.palettes);
                                                                    newPalettes.remove(selected!);
                                                                    selected = null;
                                                                    widget.bloc.add(
                                                                        DocumentPaletteChanged(
                                                                            newPalettes));
                                                                  },
                                                                  child: Text(
                                                                      AppLocalizations.of(context)!
                                                                          .yes)),
                                                            ],
                                                          ));
                                                }),
                                            const VerticalDivider(),
                                            IconButton(
                                                tooltip: AppLocalizations.of(context)!.open,
                                                icon: const Icon(PhosphorIcons.folderOpenLight),
                                                onPressed: () {
                                                  showDialog(
                                                          builder: (context) => const OpenDialog(),
                                                          context: context)
                                                      .then((data) {
                                                    final palettes = <String, List<Color>>{};
                                                    if (data == null) return;
                                                    palettes.addAll(
                                                        Map<String, dynamic>.from(jsonDecode(data))
                                                            .map((key, value) => MapEntry(
                                                                key,
                                                                List<int>.from(value)
                                                                    .map<Color>((colorValue) =>
                                                                        Color(colorValue))
                                                                    .toList())));
                                                    selected = null;
                                                    widget.bloc
                                                        .add(DocumentPaletteChanged(palettes));
                                                  });
                                                }),
                                            IconButton(
                                                tooltip: AppLocalizations.of(context)!.save,
                                                icon: const Icon(PhosphorIcons.floppyDiskLight),
                                                onPressed: () {
                                                  var data = json.encode(state.document.palettes
                                                      .map((key, value) => MapEntry(key,
                                                          value.map((e) => e.value).toList())));
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) => SaveDialog(data: data));
                                                }),
                                            IconButton(
                                                tooltip: AppLocalizations.of(context)!.help,
                                                icon: const Icon(
                                                    PhosphorIcons.circleWavyQuestionLight),
                                                onPressed: () => openHelp(["color_picker"])),
                                            IconButton(
                                                tooltip: AppLocalizations.of(context)!.resetPalette,
                                                icon: const Icon(PhosphorIcons.clockClockwiseLight),
                                                onPressed: () {
                                                  selected = null;
                                                  widget.bloc.add(DocumentPaletteChanged(
                                                      AppDocument.getDefaultPalette(context)));
                                                }),
                                            const VerticalDivider(),
                                            IconButton(
                                                tooltip: AppLocalizations.of(context)!.close,
                                                icon: const Icon(PhosphorIcons.xLight),
                                                onPressed: () => Navigator.of(context).pop()),
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
                                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                                      onLongPress: () => _showColorOperation(index),
                                      onTap: () => Navigator.of(context).pop(palette[index]),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: palette[index],
                                            borderRadius:
                                                const BorderRadius.all(Radius.circular(32))),
                                      )))).toList(),
                            if (selected != null)
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Material(
                                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(32))),
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(1322))),
                                      width: 100,
                                      height: 100,
                                      child: const Center(
                                          child: Icon(PhosphorIcons.plusLight, size: 42)),
                                    ),
                                    onTap: () async {
                                      var value = await showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CustomColorPicker(defaultColor: widget.defaultColor));
                                      if (value != null) {
                                        var newPalettes =
                                            Map<String, List<Color>>.from(state.document.palettes);
                                        newPalettes[selected!] =
                                            List.from(newPalettes[selected!] ?? [])..add(value);

                                        widget.bloc.add(DocumentPaletteChanged(newPalettes));
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
                          var value = await showDialog(
                              context: context,
                              builder: (context) =>
                                  CustomColorPicker(defaultColor: widget.defaultColor));
                          if (value != null) Navigator.of(context).pop(value);
                        },
                        child: Text(AppLocalizations.of(context)!.custom)),
                ],
              ),
            ),
          )),
    );
  }
}

class CustomColorPicker extends StatefulWidget {
  final Color defaultColor;

  const CustomColorPicker({Key? key, this.defaultColor = Colors.white}) : super(key: key);

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  late Color color;
  final TextEditingController _redController = TextEditingController();
  final TextEditingController _greenController = TextEditingController();
  final TextEditingController _blueController = TextEditingController();
  final TextEditingController _alphaController = TextEditingController();

  @override
  void initState() {
    color = widget.defaultColor;
    _updateController();
    super.initState();
  }

  void _changeColor({int? red, int? green, int? blue, int? alpha}) => setState(() {
        color = Color.fromARGB(
            alpha ?? color.alpha, red ?? color.red, green ?? color.green, blue ?? color.blue);
        _updateController();
      });
  void _updateController() {
    _redController.text = color.red.toString();
    _greenController.text = color.green.toString();
    _blueController.text = color.blue.toString();
    _alphaController.text = color.alpha.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 1000),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.color),
            leading: const Icon(PhosphorIcons.paletteLight),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Expanded(
                  child: Row(children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(color: color),
                        )),
                    Expanded(
                        flex: 3,
                        child: ListView(children: [
                          Row(children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 100),
                              child: TextField(
                                  decoration: const InputDecoration(labelText: "R"),
                                  controller: _redController,
                                  onChanged: (value) => _changeColor(red: int.tryParse(value))),
                            ),
                            Expanded(
                                child: Slider(
                              activeColor: Colors.red,
                              value: color.red.toDouble(),
                              min: 0,
                              max: 255,
                              divisions: 255,
                              onChanged: (value) => _changeColor(red: value.toInt()),
                            ))
                          ]),
                          Row(children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 100),
                              child: TextField(
                                  decoration: const InputDecoration(labelText: "G"),
                                  controller: _greenController,
                                  onChanged: (value) => _changeColor(green: int.tryParse(value))),
                            ),
                            Expanded(
                                child: Slider(
                              activeColor: Colors.green,
                              value: color.green.toDouble(),
                              min: 0,
                              max: 255,
                              divisions: 255,
                              onChanged: (value) => _changeColor(green: value.toInt()),
                            ))
                          ]),
                          Row(children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 100),
                              child: TextField(
                                  decoration: const InputDecoration(labelText: "B"),
                                  controller: _blueController,
                                  onChanged: (value) => _changeColor(blue: int.tryParse(value))),
                            ),
                            Expanded(
                                child: Slider(
                              activeColor: Colors.blue,
                              value: color.blue.toDouble(),
                              min: 0,
                              max: 255,
                              divisions: 255,
                              onChanged: (value) => _changeColor(blue: value.toInt()),
                            ))
                          ]),
                          Row(children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 100),
                              child: TextField(
                                  decoration: const InputDecoration(labelText: "A"),
                                  controller: _alphaController,
                                  onChanged: (value) => _changeColor(alpha: int.tryParse(value))),
                            ),
                            Expanded(
                                child: Slider(
                              value: color.alpha.toDouble(),
                              min: 0,
                              max: 255,
                              divisions: 255,
                              onChanged: (value) => _changeColor(alpha: value.toInt()),
                            ))
                          ])
                        ]))
                  ]),
                ),
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                      child: Text(AppLocalizations.of(context)!.cancel),
                      onPressed: () => Navigator.of(context).pop()),
                  ElevatedButton(
                      child: Text(AppLocalizations.of(context)!.ok),
                      onPressed: () => Navigator.of(context).pop(color)),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
