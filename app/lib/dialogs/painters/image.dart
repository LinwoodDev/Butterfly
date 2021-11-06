import 'package:butterfly/api/open_help.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/painters/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ImagePainterDialog extends StatefulWidget {
  final DocumentBloc bloc;
  final int painterIndex;
  const ImagePainterDialog(
      {Key? key, required this.bloc, required this.painterIndex})
      : super(key: key);

  @override
  _ImagePainterDialogState createState() => _ImagePainterDialogState();
}

class _ImagePainterDialogState extends State<ImagePainterDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(child:
          BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
        if (state is! DocumentLoadSuccess) return Container();
        var painter =
            state.document.painters[widget.painterIndex] as ImagePainter;
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
                    title: Text(AppLocalizations.of(context)!.image),
                    leading: const Icon(PhosphorIcons.penLight),
                    actions: [
                      IconButton(
                          tooltip: AppLocalizations.of(context)!.help,
                          icon:
                              const Icon(PhosphorIcons.circleWavyQuestionLight),
                          onPressed: () => openHelp(['painters', 'image'])),
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
                                    labelText:
                                        AppLocalizations.of(context)!.name),
                                controller: _nameController,
                                onChanged: (value) => setState(() =>
                                    painter = painter.copyWith(name: value))),
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
