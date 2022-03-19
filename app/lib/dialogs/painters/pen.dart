import 'package:butterfly/api/open_help.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/color_pick.dart';
import 'package:butterfly/models/painters/painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/exact_slider.dart';

class PenPainterDialog extends StatefulWidget {
  final DocumentBloc bloc;
  final int painterIndex;

  const PenPainterDialog(
      {Key? key, required this.bloc, required this.painterIndex})
      : super(key: key);

  @override
  _PenPainterDialogState createState() => _PenPainterDialogState();
}

class _PenPainterDialogState extends State<PenPainterDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(child: Builder(builder: (context) {
        var state = widget.bloc.state;
        if (state is! DocumentLoadSuccess) return Container();
        var painter =
            state.document.painters[widget.painterIndex] as PenPainter;
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
                    title: Text(AppLocalizations.of(context)!.pen),
                    leading: const Icon(PhosphorIcons.penLight),
                    actions: [
                      IconButton(
                          tooltip: AppLocalizations.of(context)!.help,
                          icon:
                              const Icon(PhosphorIcons.circleWavyQuestionLight),
                          onPressed: () => openHelp(['painters', 'pen'])),
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
                            ExactSlider(
                                header: Text(
                                    AppLocalizations.of(context)!.strokeWidth),
                                value: painter.property.strokeWidth,
                                min: 0,
                                max: 70,
                                defaultValue: 5,
                                onChanged: (value) => setState(() => painter =
                                    painter.copyWith(
                                        property: painter.property
                                            .copyWith(strokeWidth: value)))),
                            ExactSlider(
                                header: Text(AppLocalizations.of(context)!
                                    .strokeMultiplier),
                                value: painter.property.strokeMultiplier,
                                min: 0,
                                max: 70,
                                defaultValue: 5,
                                onChanged: (value) => setState(() => painter =
                                    painter.copyWith(
                                        property: painter.property.copyWith(
                                            strokeMultiplier: value)))),
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
                                          builder: (ctx) => BlocProvider.value(
                                                value: context
                                                    .read<DocumentBloc>(),
                                                child: ColorPickerDialog(
                                                    defaultColor:
                                                        painter.property.color),
                                              ));
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(32))),
                                      constraints: const BoxConstraints(
                                          maxWidth: 100, maxHeight: 100),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 15),
                            CheckboxListTile(
                                value: painter.zoomDependent,
                                title: Text(AppLocalizations.of(context)!
                                    .zoomDependent),
                                onChanged: (value) => setState(() => painter =
                                    painter.copyWith(zoomDependent: value))),
                            CheckboxListTile(
                                value: painter.property.fill,
                                title: Text(AppLocalizations.of(context)!.fill),
                                onChanged: (value) => setState(() => painter =
                                    painter.copyWith(
                                        property: painter.property
                                            .copyWith(fill: value))))
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
