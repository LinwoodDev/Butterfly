import 'package:butterfly/api/open_help.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/painter.dart';
import '../../widgets/exact_slider.dart';

class AreaPainterDialog extends StatefulWidget {
  final DocumentBloc bloc;
  final int painterIndex;
  const AreaPainterDialog(
      {Key? key, required this.bloc, required this.painterIndex})
      : super(key: key);

  @override
  _AreaPainterDialogState createState() => _AreaPainterDialogState();
}

class _AreaPainterDialogState extends State<AreaPainterDialog> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(child: Builder(builder: (context) {
        var state = widget.bloc.state;
        if (state is! DocumentLoadSuccess) return Container();
        var painter =
            state.document.painters[widget.painterIndex] as AreaPainter;
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
                    title: Text(AppLocalizations.of(context)!.eraser),
                    leading: const Icon(PhosphorIcons.eraserLight),
                    actions: [
                      IconButton(
                          tooltip: AppLocalizations.of(context)!.help,
                          icon:
                              const Icon(PhosphorIcons.circleWavyQuestionLight),
                          onPressed: () => openHelp(['painters', 'area'])),
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
                                header:
                                    Text(AppLocalizations.of(context)!.width),
                                value: painter.constrainedWidth,
                                min: 0,
                                max: 500,
                                defaultValue: 0,
                                onChanged: (value) => setState(() => painter =
                                    painter.copyWith(constrainedWidth: value))),
                            ExactSlider(
                                header:
                                    Text(AppLocalizations.of(context)!.height),
                                value: painter.constrainedHeight,
                                min: 0,
                                max: 500,
                                defaultValue: 0,
                                onChanged: (value) => setState(() => painter =
                                    painter.copyWith(
                                        constrainedHeight: value))),
                            ExactSlider(
                                header: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .aspectRatio,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    PopupMenuButton<AreaRatioPreset>(
                                      itemBuilder: (context) => AreaRatioPreset
                                          .values
                                          .map((e) => PopupMenuItem(
                                                value: e,
                                                child: Text(
                                                    e.getLocalized(context)),
                                              ))
                                          .toList(),
                                      onSelected: (preset) => setState(() =>
                                          painter = painter.copyWith(
                                              constrainedAspectRatio:
                                                  preset.ratio)),
                                      tooltip:
                                          AppLocalizations.of(context)!.presets,
                                    )
                                  ],
                                ),
                                value: painter.constrainedAspectRatio,
                                min: 0,
                                max: 10,
                                defaultValue: 0,
                                onChanged: (value) => setState(() => painter =
                                    painter.copyWith(
                                        constrainedAspectRatio: value))),
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
