import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/color_pick.dart';
import 'package:butterfly/painter/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LabelPainterDialog extends StatefulWidget {
  final DocumentBloc bloc;
  final int painterIndex;
  const LabelPainterDialog({Key? key, required this.bloc, required this.painterIndex})
      : super(key: key);

  @override
  _LabelPainterDialogState createState() => _LabelPainterDialogState();
}

class _LabelPainterDialogState extends State<LabelPainterDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _thicknessController = TextEditingController();
  bool _decorationExpanded = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
        if (state is! DocumentLoadSuccess) return Container();
        var painter = state.document.painters[widget.painterIndex] as LabelPainter;
        return Container(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: StatefulBuilder(builder: (context, setState) {
              if (_nameController.text != painter.name) _nameController.text = painter.name;
              if (_sizeController.text != painter.size.toStringAsFixed(2)) {
                _sizeController.text = painter.size.toStringAsFixed(2);
              }
              if (_thicknessController.text != painter.decorationThickness.toStringAsFixed(2)) {
                _thicknessController.text = painter.decorationThickness.toStringAsFixed(2);
              }
              return Scaffold(
                  appBar: AppBar(
                    title: Text(AppLocalizations.of(context)!.label),
                    leading: const Icon(PhosphorIcons.textTLight),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(children: [
                            TextField(
                                decoration:
                                    InputDecoration(labelText: AppLocalizations.of(context)!.name),
                                controller: _nameController,
                                onChanged: (value) =>
                                    setState(() => painter = painter.copyWith(name: value))),
                            Row(children: [
                              ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 100),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!.size),
                                    controller: _sizeController,
                                    onChanged: (value) => setState(() =>
                                        painter = painter.copyWith(size: double.tryParse(value))),
                                  )),
                              Expanded(
                                child: Slider(
                                    value: painter.size.clamp(6, 96),
                                    min: 6,
                                    max: 96,
                                    onChanged: (value) =>
                                        setState(() => painter = painter.copyWith(size: value))),
                              )
                            ]),
                            ListTile(
                                title: Text(AppLocalizations.of(context)!.fontWeight),
                                trailing: DropdownButton<FontWeight>(
                                    value: painter.fontWeight,
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
                                    onChanged: (value) => setState(
                                        () => painter = painter.copyWith(fontWeight: value)))),
                            CheckboxListTile(
                                title: Text(AppLocalizations.of(context)!.italic),
                                value: painter.italic,
                                onChanged: (value) =>
                                    setState(() => painter = painter.copyWith(italic: value))),
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
                                          value: painter.lineThrough,
                                          onChanged: (value) => setState(() =>
                                              painter = painter.copyWith(lineThrough: value))),
                                      CheckboxListTile(
                                          title: Text(AppLocalizations.of(context)!.underline),
                                          value: painter.underline,
                                          onChanged: (value) => setState(
                                              () => painter = painter.copyWith(underline: value))),
                                      CheckboxListTile(
                                          title: Text(AppLocalizations.of(context)!.overline),
                                          value: painter.overline,
                                          onChanged: (value) => setState(
                                              () => painter = painter.copyWith(overline: value))),
                                      ListTile(
                                          title: Text(AppLocalizations.of(context)!.fontWeight),
                                          trailing: DropdownButton<TextDecorationStyle>(
                                              value: painter.decorationStyle,
                                              items: List.generate(
                                                  TextDecorationStyle.values.length, (index) {
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
                                              onChanged: (value) => setState(() => painter =
                                                  painter.copyWith(decorationStyle: value)))),
                                      ListTile(
                                          onTap: () async {
                                            var value = await showDialog(
                                                context: context,
                                                builder: (context) => ColorPickerDialog(
                                                    defaultColor: painter.decorationColor,
                                                    bloc: widget.bloc));
                                            if (value != null) {
                                              setState(() => painter = painter.copyWith(
                                                  decorationColor: value as Color));
                                            }
                                          },
                                          leading: Container(
                                              width: 30,
                                              height: 30,
                                              color: painter.decorationColor),
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
                                                onChanged: (value) => setState(() => painter =
                                                    painter.copyWith(
                                                        decorationThickness:
                                                            double.tryParse(value))),
                                              )),
                                          Expanded(
                                            child: Slider(
                                                value: painter.decorationThickness.clamp(0.1, 4),
                                                min: 0.1,
                                                max: 4,
                                                onChanged: (value) => setState(() => painter =
                                                    painter.copyWith(decorationThickness: value))),
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
                                    onTap: () async {
                                      var color = await showDialog(
                                          context: context,
                                          builder: (context) => ColorPickerDialog(
                                              bloc: widget.bloc, defaultColor: painter.color));
                                      if (color != null) {
                                        setState(() => painter = painter.copyWith(color: color));
                                      }
                                    },
                                    child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 100, maxHeight: 100),
                                        color: painter.color)),
                              ],
                            ),
                          ]),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  primary: Theme.of(context).colorScheme.error),
                              child: Text(AppLocalizations.of(context)!.delete.toUpperCase()),
                              onPressed: () {
                                Navigator.of(context).pop();
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                    AppLocalizations.of(context)!.no.toUpperCase()),
                                                onPressed: () => Navigator.of(context).pop(),
                                              ),
                                              TextButton(
                                                child: Text(AppLocalizations.of(context)!
                                                    .yes
                                                    .toUpperCase()),
                                                onPressed: () {
                                                  widget.bloc
                                                      .add(PainterRemoved(widget.painterIndex));
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                            title: Text(AppLocalizations.of(context)!.areYouSure),
                                            content:
                                                Text(AppLocalizations.of(context)!.reallyDelete)));
                              },
                            ),
                            Expanded(child: Container()),
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.cancel.toUpperCase()),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              child: Text(AppLocalizations.of(context)!.ok.toUpperCase()),
                              onPressed: () {
                                widget.bloc.add(PainterChanged(painter, widget.painterIndex));
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
