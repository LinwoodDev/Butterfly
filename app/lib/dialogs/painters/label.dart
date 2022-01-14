import 'package:butterfly/api/open_help.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/color_pick.dart';
import 'package:butterfly/models/painters/label.dart';
import 'package:butterfly/models/properties/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LabelPainterDialog extends StatefulWidget {
  final DocumentBloc bloc;
  final int painterIndex;
  const LabelPainterDialog(
      {Key? key, required this.bloc, required this.painterIndex})
      : super(key: key);

  @override
  _LabelPainterDialogState createState() => _LabelPainterDialogState();
}

class _LabelPainterDialogState extends State<LabelPainterDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(child:
          BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
        if (state is! DocumentLoadSuccess) return Container();
        var painter =
            state.document.painters[widget.painterIndex] as LabelPainter;
        return Container(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: StatefulBuilder(builder: (context, setState) {
              if (_nameController.text != painter.name) {
                _nameController.text = painter.name;
              }
              return Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(AppLocalizations.of(context)!.label),
                    leading: const Icon(PhosphorIcons.textTLight),
                    actions: [
                      IconButton(
                          tooltip: AppLocalizations.of(context)!.help,
                          icon:
                              const Icon(PhosphorIcons.circleWavyQuestionLight),
                          onPressed: () => openHelp(['painters', 'label'])),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(children: [
                            TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText:
                                        AppLocalizations.of(context)!.name),
                                controller: _nameController,
                                onChanged: (value) => setState(() =>
                                    painter = painter.copyWith(name: value))),
                            LabelPropertyView(
                                onChanged: (property) => setState(() =>
                                    painter =
                                        painter.copyWith(property: property))),
                          ]),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  primary: Theme.of(context).colorScheme.error),
                              child: Text(AppLocalizations.of(context)!.delete),
                              onPressed: () {
                                Navigator.of(context).pop();
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            actions: [
                                              TextButton(
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .no),
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                              ),
                                              TextButton(
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .yes),
                                                onPressed: () {
                                                  widget.bloc.add(
                                                      PainterRemoved(
                                                          widget.painterIndex));
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .areYouSure),
                                            content: Text(
                                                AppLocalizations.of(context)!
                                                    .reallyDelete)));
                              },
                            ),
                            Expanded(child: Container()),
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.cancel),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              child: Text(AppLocalizations.of(context)!.ok),
                              onPressed: () {
                                widget.bloc.add(PainterChanged(
                                    painter, widget.painterIndex));
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
            }));
      })),
    );
  }
}

typedef LabelPropertyCallback = void Function(LabelProperty);

class LabelPropertyView extends StatefulWidget {
  final LabelProperty initialValue;
  final LabelPropertyCallback onChanged;

  const LabelPropertyView(
      {Key? key,
      this.initialValue = const LabelProperty(),
      required this.onChanged})
      : super(key: key);

  @override
  State<LabelPropertyView> createState() => _LabelPropertyViewState();
}

class _LabelPropertyViewState extends State<LabelPropertyView> {
  late LabelProperty _value;
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _thicknessController = TextEditingController();
  final TextEditingController _spacingController = TextEditingController();
  bool _decorationExpanded = false;

  @override
  void initState() {
    super.initState();
    change(widget.initialValue, false);
  }

  void change(LabelProperty newValue, [bool notify = true]) {
    setState(() {
      _value = newValue;
    });
    if (double.tryParse(_sizeController.text) != _value.size) {
      _sizeController.text = _value.size.toStringAsFixed(2);
    }
    if (double.tryParse(_spacingController.text) != _value.letterSpacing) {
      _spacingController.text = _value.letterSpacing.toStringAsFixed(2);
    }
    if (double.tryParse(_thicknessController.text) !=
        _value.decorationThickness) {
      _thicknessController.text = _value.decorationThickness.toStringAsFixed(2);
    }
    if (notify) {
      widget.onChanged(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 100),
            child: TextField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.size),
              controller: _sizeController,
              onChanged: (value) =>
                  change(_value.copyWith(size: double.tryParse(value))),
            )),
        Expanded(
            child: Slider(
                value: _value.size.clamp(6, 512),
                min: 6,
                max: 512,
                onChanged: (value) => change(_value.copyWith(size: value)))),
      ]),
      Row(children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: TextField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.spacing),
              controller: _spacingController,
              onChanged: (value) => change(
                  _value.copyWith(letterSpacing: double.tryParse(value)))),
        ),
        Expanded(
            child: Slider(
                value: _value.letterSpacing.clamp(0, 20),
                min: 0,
                max: 20,
                onChanged: (value) =>
                    change(_value.copyWith(letterSpacing: value)))),
      ]),
      ListTile(
          title: Text(AppLocalizations.of(context)!.fontWeight),
          trailing: DropdownButton<FontWeight>(
              value: _value.fontWeight,
              items: List.generate(FontWeight.values.length, (index) {
                var text = ((index + 1) * 100).toString();
                if (index == 3) {
                  text = AppLocalizations.of(context)!.normal;
                } else if (index == 6) {
                  text = AppLocalizations.of(context)!.bold;
                }
                return DropdownMenuItem(
                    child: Text(text), value: FontWeight.values[index]);
              }),
              onChanged: (value) =>
                  change(_value.copyWith(fontWeight: value)))),
      CheckboxListTile(
          title: Text(AppLocalizations.of(context)!.italic),
          value: _value.italic,
          onChanged: (value) => change(_value.copyWith(italic: value))),
      ExpansionPanelList(
        expansionCallback: (panelIndex, isExpanded) =>
            setState(() => _decorationExpanded = !_decorationExpanded),
        children: [
          ExpansionPanel(
              isExpanded: _decorationExpanded,
              headerBuilder: (context, isExpanded) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.decoration,
                          style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
              body: Column(children: [
                CheckboxListTile(
                    title: Text(AppLocalizations.of(context)!.lineThrough),
                    value: _value.lineThrough,
                    onChanged: (value) =>
                        change(_value.copyWith(lineThrough: value))),
                CheckboxListTile(
                    title: Text(AppLocalizations.of(context)!.underline),
                    value: _value.underline,
                    onChanged: (value) =>
                        change(_value.copyWith(underline: value))),
                CheckboxListTile(
                    title: Text(AppLocalizations.of(context)!.overline),
                    value: _value.overline,
                    onChanged: (value) =>
                        change(_value.copyWith(overline: value))),
                ListTile(
                    title: Text(AppLocalizations.of(context)!.style),
                    trailing: DropdownButton<TextDecorationStyle>(
                        value: _value.decorationStyle,
                        items: List.generate(TextDecorationStyle.values.length,
                            (index) {
                          String text;
                          var style = TextDecorationStyle.values[index];
                          switch (style) {
                            case TextDecorationStyle.solid:
                              text = AppLocalizations.of(context)!.solid;
                              break;
                            case TextDecorationStyle.dashed:
                              text = AppLocalizations.of(context)!.dashed;
                              break;
                            case TextDecorationStyle.dotted:
                              text = AppLocalizations.of(context)!.dotted;
                              break;
                            case TextDecorationStyle.double:
                              text = AppLocalizations.of(context)!.double;
                              break;
                            case TextDecorationStyle.wavy:
                              text = AppLocalizations.of(context)!.wavy;
                          }
                          return DropdownMenuItem(
                              child: Text(text),
                              value: TextDecorationStyle.values[index]);
                        }),
                        onChanged: (value) =>
                            change(_value.copyWith(decorationStyle: value)))),
                ListTile(
                    onTap: () async {
                      var value = await showDialog(
                          context: context,
                          builder: (ctx) => BlocProvider.value(
                                value: context.read<DocumentBloc>(),
                                child: ColorPickerDialog(
                                    defaultColor: _value.decorationColor),
                              ));
                      if (value != null) {
                        change(
                            _value.copyWith(decorationColor: value as Color));
                      }
                    },
                    leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: _value.decorationColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32)))),
                    title: Text(AppLocalizations.of(context)!.color)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(children: [
                    ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 100),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.thickness),
                          controller: _thicknessController,
                          onChanged: (value) => change(_value.copyWith(
                              decorationThickness: double.tryParse(value))),
                        )),
                    Expanded(
                      child: Slider(
                          value: _value.decorationThickness.clamp(0.1, 4),
                          min: 0.1,
                          max: 4,
                          onChanged: (value) => change(
                              _value.copyWith(decorationThickness: value))),
                    )
                  ]),
                ),
              ]))
        ],
      ),
      const SizedBox(height: 50),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(32)),
              onTap: () async {
                var color = await showDialog(
                    context: context,
                    builder: (ctx) => BlocProvider.value(
                          value: context.read<DocumentBloc>(),
                          child: ColorPickerDialog(defaultColor: _value.color),
                        ));
                if (color != null) {
                  change(_value.copyWith(color: color));
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: _value.color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32))),
                  constraints:
                      const BoxConstraints(maxWidth: 100, maxHeight: 100))),
        ],
      )
    ]);
  }
}
