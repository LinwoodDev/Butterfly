import 'dart:convert';
import 'dart:io';

import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/background.dart';
import 'package:butterfly/pad/dialogs/color_pick.dart';
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
            onPressed: () => showDialog(
                context: context, builder: (context) => ExportDialog(bloc: widget.bloc))),
        IconButton(
          icon: const Icon(PhosphorIcons.paletteLight),
          tooltip: AppLocalizations.of(context)!.color,
          onPressed: () => showDialog(
              context: context,
              builder: (context) => ColorPickerDialog(
                    bloc: widget.bloc,
                    viewMode: true,
                  )),
        ),
        IconButton(
            icon: const Icon(PhosphorIcons.floppyDiskLight),
            tooltip: AppLocalizations.of(context)!.save,
            onPressed: () async {
              const encoder = JsonEncoder.withIndent("\t");
              var json = encoder.convert(state.document.toJson());
              if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
                Clipboard.setData(ClipboardData(text: json));
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(AppLocalizations.of(context)!.copyTitle),
                          content: Text(AppLocalizations.of(context)!.copyMessage),
                          actions: [
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.ok),
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
                  var file = File(value);
                  void write() {
                    file.writeAsStringSync(json);
                  }

                  if (!file.existsSync()) {
                    write();
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(AppLocalizations.of(context)!.areYouSure),
                              content: Text(AppLocalizations.of(context)!.existOverride),
                              actions: [
                                TextButton(
                                    child: Text(AppLocalizations.of(context)!.no),
                                    onPressed: () => Navigator.of(context).pop()),
                                TextButton(
                                    child: Text(AppLocalizations.of(context)!.yes),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      write();
                                    })
                              ],
                            ));
                  }
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
