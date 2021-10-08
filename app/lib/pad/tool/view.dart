import 'dart:convert';
import 'dart:io';

import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/background.dart';
import 'package:butterfly/pad/dialogs/export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ViewToolbar extends StatefulWidget {
  final DocumentBloc bloc;
  const ViewToolbar({Key? key, required this.bloc}) : super(key: key);

  @override
  _ViewToolbarState createState() => _ViewToolbarState();
}

class _ViewToolbarState extends State<ViewToolbar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoadSuccess) {
        return Container();
      }
      return Row(children: [
        IconButton(
          icon: const Icon(PhosphorIcons.imageLight),
          tooltip: AppLocalizations.of(context)!.background,
          onPressed: () {
            showDialog(context: context, builder: (context) => BackgroundDialog(bloc: widget.bloc));
          },
        ),
        IconButton(
            icon: const Icon(PhosphorIcons.arrowSquareOutLight),
            tooltip: AppLocalizations.of(context)!.export,
            onPressed: () async {
              showDialog(context: context, builder: (context) => ExportDialog(bloc: widget.bloc));
            }),
        IconButton(
            icon: const Icon(PhosphorIcons.floppyDiskLight),
            tooltip: AppLocalizations.of(context)!.save,
            onPressed: () async {
              if (kIsWeb || Platform.isAndroid || Platform.isWindows) {
                Clipboard.setData(ClipboardData(text: jsonEncode(state.document.toJson())));
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(AppLocalizations.of(context)!.copyTitle),
                          content: Text(AppLocalizations.of(context)!.copyMessage),
                          actions: [
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.ok.toUpperCase()),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ));
              } else {
                FilePicker.platform.saveFile(
                    fileName: "butterfly.json",
                    type: FileType.custom,
                    allowedExtensions: ["json"]).then((value) {
                  if (value == null) {
                    return;
                  }
                  File(value).writeAsStringSync(jsonEncode(state.document.toJson()));
                });
              }
            }),
      ]);
    });
    /*IconButton(icon: const Icon(PhosphorIcons.printerLight), tooltip: "Print", onPressed: () {}),
      IconButton(
          icon: const Icon(PhosphorIcons.monitorPlayLight),
          tooltip: "Presentation",
          onPressed: () {})*/
  }
}
