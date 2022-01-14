import 'dart:convert';

import 'package:butterfly/api/open_help.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/import.dart';
import 'package:butterfly/models/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'data_export.dart';

class ColorPickerDialog extends StatefulWidget {
  final bool viewMode;
  final Color defaultColor;

  const ColorPickerDialog(
      {Key? key, this.defaultColor = Colors.white, this.viewMode = false})
      : super(key: key);

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  int selected = 0;

  void _showColorOperation(int index) {
    showModalBottomSheet(
        context: context,
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
                final newPalette = List<Color>.from(palette.colors);
                return SizedBox(
                    height: 300,
                    child: Column(children: [
                      SizedBox(
                        height: 125,
                        child: Center(
                            child:
                                Container(color: color, height: 75, width: 75)),
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
                                  builder: (context) =>
                                      CustomColorPicker(defaultColor: color));
                              if (value != null) {
                                newPalette[index] = value;
                                newPalettes[selected] =
                                    palette.copyWith(colors: newPalette);
                                context
                                    .read<DocumentBloc>()
                                    .add(DocumentPaletteChanged(newPalettes));
                              }
                            }),
                        ListTile(
                          leading: const Icon(PhosphorIcons.trashLight),
                          title: Text(AppLocalizations.of(context)!.delete),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: Text(AppLocalizations.of(context)!
                                          .areYouSure),
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .reallyDelete),
                                      actions: [
                                        TextButton(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .no),
                                            onPressed: () =>
                                                Navigator.of(ctx).pop()),
                                        TextButton(
                                            child: Text(
                                                AppLocalizations.of(context)!
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
                  var palette = state.document.palettes.isEmpty
                      ? []
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
                                          DropdownButton<int>(
                                            alignment: Alignment.center,
                                            value: selected,
                                            onChanged: (value) {
                                              setState(() {
                                                selected = value ?? selected;
                                              });
                                            },
                                            items: state.document.palettes
                                                .asMap()
                                                .map((index, palette) {
                                                  return MapEntry(
                                                      index,
                                                      DropdownMenuItem<int>(
                                                        value: index,
                                                        child:
                                                            Text(palette.name),
                                                      ));
                                                })
                                                .values
                                                .toList(),
                                          ),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)!
                                                      .add,
                                              icon: const Icon(
                                                  PhosphorIcons.plusLight),
                                              onPressed: _createPalette),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)!
                                                      .edit,
                                              icon: const Icon(
                                                  PhosphorIcons.penLight),
                                              onPressed: _editPalette),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)!
                                                      .remove,
                                              icon: const Icon(
                                                  PhosphorIcons.minusLight),
                                              onPressed: _deletePalette),
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
                                                  AppLocalizations.of(context)!
                                                      .import,
                                              icon: const Icon(PhosphorIcons
                                                  .arrowSquareInLight),
                                              onPressed: () {
                                                showDialog(
                                                        builder: (context) =>
                                                            const ImportDialog(),
                                                        context: context)
                                                    .then((data) {
                                                  final palettes =
                                                      <ColorPalette>[];
                                                  if (data == null) return;
                                                  var value = jsonDecode(data);
                                                  palettes.addAll(List<
                                                              Map<String,
                                                                  dynamic>>.from(
                                                          value['palettes'])
                                                      .map((e) =>
                                                          ColorPalette.fromJson(
                                                              e))
                                                      .toList());
                                                  context
                                                      .read<DocumentBloc>()
                                                      .add(
                                                          DocumentPaletteChanged(
                                                              palettes));
                                                });
                                              }),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)!
                                                      .export,
                                              icon: const Icon(
                                                  PhosphorIcons.exportLight),
                                              onPressed: () {
                                                var data = json.encode({
                                                  'fileVersion': GetIt.I
                                                      .get<int>(
                                                          instanceName:
                                                              'fileVersion'),
                                                  'palettes': state
                                                      .document.palettes
                                                      .map((e) => e.toJson())
                                                      .toList()
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        ExportDialog(
                                                            data: data));
                                              }),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)!
                                                      .help,
                                              icon: const Icon(PhosphorIcons
                                                  .circleWavyQuestionLight),
                                              onPressed: () =>
                                                  openHelp(['color_picker'])),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)!
                                                      .resetPalette,
                                              icon: const Icon(PhosphorIcons
                                                  .clockClockwiseLight),
                                              onPressed: _resetPalette),
                                          const VerticalDivider(),
                                          IconButton(
                                              tooltip:
                                                  AppLocalizations.of(context)!
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
                                          color: palette[index],
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
                                    var value = await showDialog(
                                        context: context,
                                        builder: (context) => CustomColorPicker(
                                            defaultColor: widget.defaultColor));
                                    if (value != null) {
                                      var newPalettes = List<ColorPalette>.from(
                                          state.document.palettes);
                                      newPalettes[selected] =
                                          newPalettes[selected].copyWith(
                                              colors: List<Color>.from(
                                                  newPalettes[selected].colors)
                                                ..add(value));

                                      context.read<DocumentBloc>().add(
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
                        var value = await showDialog(
                            context: context,
                            builder: (context) => CustomColorPicker(
                                defaultColor: widget.defaultColor));
                        if (value != null) Navigator.of(context).pop(value);
                      },
                      child: Text(AppLocalizations.of(context)!.custom)),
              ],
            ),
          ),
        ));
  }

  void _createPalette() {
    final _nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(AppLocalizations.of(context)!.cancel)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        var bloc = context.read<DocumentBloc>();

                        bloc.add(DocumentPaletteChanged(
                          List<ColorPalette>.from(
                              (bloc.state as DocumentLoadSuccess)
                                  .document
                                  .palettes)
                            ..add(ColorPalette(name: _nameController.text)),
                        ));
                      },
                      child: Text(AppLocalizations.of(context)!.create)),
                ],
                title: Text(AppLocalizations.of(context)!.enterName),
                content:
                    TextField(autofocus: true, controller: _nameController)));
  }

  void _editPalette() {
    var state = context.read<DocumentBloc>().state as DocumentLoadSuccess;
    if (selected >= state.document.palettes.length) {
      return;
    }
    final _nameController =
        TextEditingController(text: state.document.palettes[selected].name);
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(AppLocalizations.of(context)!.cancel)),
                  TextButton(
                      onPressed: () {
                        var newPalettes =
                            List<ColorPalette>.from(state.document.palettes);
                        newPalettes[selected] = newPalettes[selected]
                            .copyWith(name: _nameController.text);
                        context
                            .read<DocumentBloc>()
                            .add(DocumentPaletteChanged(newPalettes));
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.ok)),
                ],
                title: Text(AppLocalizations.of(context)!.enterName),
                content:
                    TextField(autofocus: true, controller: _nameController)));
  }

  void _deletePalette() {
    var state = context.read<DocumentBloc>().state as DocumentLoadSuccess;
    if (selected >= state.document.palettes.length) {
      return;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.areYouSure),
              content: Text(AppLocalizations.of(context)!.reallyDelete),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.no)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      var newPalettes =
                          List<ColorPalette>.from(state.document.palettes);
                      newPalettes.removeAt(selected);
                      context
                          .read<DocumentBloc>()
                          .add(DocumentPaletteChanged(newPalettes));
                    },
                    child: Text(AppLocalizations.of(context)!.yes)),
              ],
            ));
  }

  void _resetPalette() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                title: Text(AppLocalizations.of(ctx)!.areYouSure),
                content: Text(AppLocalizations.of(ctx)!.reallyReset),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(AppLocalizations.of(ctx)!.no)),
                  TextButton(
                      onPressed: () {
                        selected = 0;
                        context.read<DocumentBloc>().add(DocumentPaletteChanged(
                            ColorPalette.getMaterialPalette(context)));
                        Navigator.of(ctx).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.yes))
                ]));
  }
}

class CustomColorPicker extends StatefulWidget {
  final Color defaultColor;

  const CustomColorPicker({Key? key, this.defaultColor = Colors.white})
      : super(key: key);

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

  void _changeColor({int? red, int? green, int? blue, int? alpha}) =>
      setState(() {
        color = Color.fromARGB(alpha ?? color.alpha, red ?? color.red,
            green ?? color.green, blue ?? color.blue);
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
            child: LayoutBuilder(builder: (context, constraints) {
              var isMobile = constraints.maxWidth < 600;
              return Column(
                children: [
                  Expanded(
                      child: isMobile
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                        child: Text(AppLocalizations.of(context)!.cancel),
                        onPressed: () => Navigator.of(context).pop()),
                    ElevatedButton(
                        child: Text(AppLocalizations.of(context)!.ok),
                        onPressed: () => Navigator.of(context).pop(color)),
                  ])
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildPreview() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
            color: color),
      );

  Widget _buildProperties() => Column(children: [
        Row(children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 100),
            child: TextField(
                decoration: const InputDecoration(labelText: 'R'),
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
                decoration: const InputDecoration(labelText: 'G'),
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
                decoration: const InputDecoration(labelText: 'B'),
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
                decoration: const InputDecoration(labelText: 'A'),
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
      ]);
}
