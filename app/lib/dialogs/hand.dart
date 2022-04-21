import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../widgets/header.dart';

class HandDialog extends StatefulWidget {
  const HandDialog({Key? key}) : super(key: key);

  @override
  _HandDialogState createState() => _HandDialogState();
}

class _HandDialogState extends State<HandDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(child:
        BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoadSuccess) return Container();
      var property = state.document.handProperty;
      return Container(
          constraints: const BoxConstraints(
              maxWidth: 400, maxHeight: 600, minWidth: 200),
          child: StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Header(
                  leading: const Icon(PhosphorIcons.handLight, size: 28),
                  title: Text(
                    AppLocalizations.of(context)!.hand,
                  ),
                  help: const ['tools', 'hand'],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: ListView(shrinkWrap: true, children: [
                            CheckboxListTile(
                                value: property.includeEraser,
                                title: Text(AppLocalizations.of(context)!
                                    .includeEraser),
                                onChanged: (value) => setState(() => property =
                                    property.copyWith(
                                        includeEraser:
                                            value ?? property.includeEraser))),
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
                                context
                                    .read<DocumentBloc>()
                                    .add(HandPropertyChanged(property));
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }));
    }));
  }
}
