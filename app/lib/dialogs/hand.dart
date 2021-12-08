import 'package:butterfly/api/open_help.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HandDialog extends StatefulWidget {
  final DocumentBloc bloc;

  const HandDialog({Key? key, required this.bloc}) : super(key: key);

  @override
  _HandDialogState createState() => _HandDialogState();
}

class _HandDialogState extends State<HandDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(child:
          BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
        if (state is! DocumentLoadSuccess) return Container();
        var property = state.document.handProperty;
        return Container(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: StatefulBuilder(builder: (context, setState) {
              return Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(AppLocalizations.of(context)!.hand),
                    leading: const Icon(PhosphorIcons.handLight),
                    actions: [
                      IconButton(
                          tooltip: AppLocalizations.of(context)!.help,
                          icon:
                              const Icon(PhosphorIcons.circleWavyQuestionLight),
                          onPressed: () => openHelp(['tools', 'hand'])),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(children: [
                            CheckboxListTile(
                                value: property.includeEraser,
                                title: Text(AppLocalizations.of(context)!
                                    .includeEraser),
                                onChanged: (value) => setState(() => property =
                                    property.copyWith(includeEraser: value))),
                          ]),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.cancel),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              child: Text(AppLocalizations.of(context)!.ok),
                              onPressed: () {
                                widget.bloc.add(HandPropertyChanged(property));
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
