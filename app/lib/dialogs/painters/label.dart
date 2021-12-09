import 'package:butterfly/api/open_help.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/color_pick.dart';
import 'package:butterfly/models/painters/label.dart';
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
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _thicknessController = TextEditingController();
  final TextEditingController _spacingController = TextEditingController();
  bool _decorationExpanded = false;
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
              if (double.tryParse(_sizeController.text) !=
                  painter.property.size) {
                _sizeController.text = painter.property.size.toStringAsFixed(2);
              }
              if (double.tryParse(_spacingController.text) !=
                  painter.property.letterSpacing) {
                _spacingController.text =
                    painter.property.letterSpacing.toStringAsFixed(2);
              }
              if (double.tryParse(_thicknessController.text) !=
                  painter.property.decorationThickness) {
                _thicknessController.text =
                    painter.property.decorationThickness.toStringAsFixed(2);
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
                            Row(children: [
                              ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 100),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        labelText:
                                            AppLocalizations.of(context)!.size),
                                    controller: _sizeController,
                                    onChanged: (value) => setState(() =>
                                        painter = painter.copyWith(
                                            property: painter.property.copyWith(
                                                size: double.tryParse(value)))),
                                  )),
                              Expanded(
                                child: Slider(
                                    value: painter.property.size.clamp(6, 96),
                                    min: 6,
                                    max: 96,
                                    onChanged: (value) => setState(() =>
                                        painter = painter.copyWith(
                                            property: painter.property
                                                .copyWith(size: value)))),
                              )
                            ]),
                            Row(children: [
                              ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 100),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!
                                            .spacing),
                                    controller: _spacingController,
                                    onChanged: (value) => setState(() =>
                                        painter = painter.copyWith(
                                            property: painter.property.copyWith(
                                                letterSpacing:
                                                    double.tryParse(value)))),
                                  )),
                              Expanded(
                                child: Slider(
                                    value: painter.property.letterSpacing
                                        .clamp(-50, 50),
                                    min: -50,
                                    max: 50,
                                    onChanged: (value) => setState(() =>
                                        painter = painter.copyWith(
                                            property: painter.property.copyWith(
                                                letterSpacing: value)))),
                              )
                            ]),
                            ListTile(
                                title: Text(
                                    AppLocalizations.of(context)!.fontWeight),
                                trailing: DropdownButton<FontWeight>(
                                    value: painter.property.fontWeight,
                                    items: List.generate(
                                        FontWeight.values.length, (index) {
                                      var text = ((index + 1) * 100).toString();
                                      if (index == 3) {
                                        text = AppLocalizations.of(context)!
                                            .normal;
                                      } else if (index == 6) {
                                        text =
                                            AppLocalizations.of(context)!.bold;
                                      }
                                      return DropdownMenuItem(
                                          child: Text(text),
                                          value: FontWeight.values[index]);
                                    }),
                                    onChanged: (value) => setState(() =>
                                        painter = painter.copyWith(
                                            property: painter.property.copyWith(
                                                fontWeight: value))))),
                            CheckboxListTile(
                                title:
                                    Text(AppLocalizations.of(context)!.italic),
                                value: painter.property.italic,
                                onChanged: (value) => setState(() => painter =
                                    painter.copyWith(
                                        property: painter.property
                                            .copyWith(italic: value)))),
                            ExpansionPanelList(
                              expansionCallback: (panelIndex, isExpanded) =>
                                  setState(() => _decorationExpanded =
                                      !_decorationExpanded),
                              children: [
                                ExpansionPanel(
                                    isExpanded: _decorationExpanded,
                                    headerBuilder: (context, isExpanded) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .decoration,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                          ],
                                        ),
                                    body: Column(children: [
                                      CheckboxListTile(
                                          title: Text(
                                              AppLocalizations.of(context)!
                                                  .lineThrough),
                                          value: painter.property.lineThrough,
                                          onChanged: (value) => setState(() =>
                                              painter = painter.copyWith(
                                                  property: painter.property
                                                      .copyWith(
                                                          lineThrough:
                                                              value)))),
                                      CheckboxListTile(
                                          title: Text(
                                              AppLocalizations.of(context)!
                                                  .underline),
                                          value: painter.property.underline,
                                          onChanged: (value) => setState(() =>
                                              painter = painter.copyWith(
                                                  property: painter.property
                                                      .copyWith(
                                                          underline: value)))),
                                      CheckboxListTile(
                                          title: Text(
                                              AppLocalizations.of(context)!
                                                  .overline),
                                          value: painter.property.overline,
                                          onChanged: (value) => setState(() =>
                                              painter = painter.copyWith(
                                                  property: painter.property
                                                      .copyWith(
                                                          overline: value)))),
                                      ListTile(
                                          title: Text(AppLocalizations.of(context)!
                                              .style),
                                          trailing: DropdownButton<
                                                  TextDecorationStyle>(
                                              value: painter
                                                  .property.decorationStyle,
                                              items: List.generate(
                                                  TextDecorationStyle
                                                      .values.length, (index) {
                                                String text;
                                                var style = TextDecorationStyle
                                                    .values[index];
                                                switch (style) {
                                                  case TextDecorationStyle
                                                      .solid:
                                                    text = AppLocalizations.of(
                                                            context)!
                                                        .solid;
                                                    break;
                                                  case TextDecorationStyle
                                                      .dashed:
                                                    text = AppLocalizations.of(
                                                            context)!
                                                        .dashed;
                                                    break;
                                                  case TextDecorationStyle
                                                      .dotted:
                                                    text = AppLocalizations.of(
                                                            context)!
                                                        .dotted;
                                                    break;
                                                  case TextDecorationStyle
                                                      .double:
                                                    text = AppLocalizations.of(
                                                            context)!
                                                        .double;
                                                    break;
                                                  case TextDecorationStyle.wavy:
                                                    text = AppLocalizations.of(
                                                            context)!
                                                        .wavy;
                                                }
                                                return DropdownMenuItem(
                                                    child: Text(text),
                                                    value: TextDecorationStyle
                                                        .values[index]);
                                              }),
                                              onChanged: (value) => setState(() =>
                                                  painter = painter.copyWith(
                                                      property: painter.property
                                                          .copyWith(
                                                              decorationStyle:
                                                                  value))))),
                                      ListTile(
                                          onTap: () async {
                                            var value = await showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    ColorPickerDialog(
                                                        defaultColor: painter
                                                            .property
                                                            .decorationColor,
                                                        bloc: widget.bloc));
                                            if (value != null) {
                                              setState(() => painter =
                                                  painter.copyWith(
                                                      property: painter.property
                                                          .copyWith(
                                                              decorationColor:
                                                                  value
                                                                      as Color)));
                                            }
                                          },
                                          leading: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: painter
                                                      .property.decorationColor,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              32)))),
                                          title: Text(
                                              AppLocalizations.of(context)!
                                                  .color)),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(children: [
                                          ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 100),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    labelText:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .thickness),
                                                controller:
                                                    _thicknessController,
                                                onChanged: (value) => setState(() =>
                                                    painter = painter.copyWith(
                                                        property: painter
                                                            .property
                                                            .copyWith(
                                                                decorationThickness:
                                                                    double.tryParse(
                                                                        value)))),
                                              )),
                                          Expanded(
                                            child: Slider(
                                                value: painter.property
                                                    .decorationThickness
                                                    .clamp(0.1, 4),
                                                min: 0.1,
                                                max: 4,
                                                onChanged: (value) => setState(() =>
                                                    painter = painter.copyWith(
                                                        property: painter
                                                            .property
                                                            .copyWith(
                                                                decorationThickness:
                                                                    value)))),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(32)),
                                    onTap: () async {
                                      var color = await showDialog(
                                          context: context,
                                          builder: (context) =>
                                              ColorPickerDialog(
                                                  bloc: widget.bloc,
                                                  defaultColor:
                                                      painter.property.color));
                                      if (color != null) {
                                        setState(() => painter =
                                            painter.copyWith(
                                                property: painter.property
                                                    .copyWith(color: color)));
                                      }
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: painter.property.color,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(32))),
                                        constraints: const BoxConstraints(
                                            maxWidth: 100, maxHeight: 100))),
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
