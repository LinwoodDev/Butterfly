import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/views/view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:butterfly/api/open_image.dart'
    if (dart.library.io) 'package:butterfly/api/open_image_io.dart'
    if (dart.library.js) 'package:butterfly/api/open_image_html.dart';

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
            icon: const Icon(PhosphorIcons.arrowSquareOutLight),
            tooltip: "Export",
            onPressed: () async {
              var recorder = PictureRecorder();
              var canvas = Canvas(recorder);
              PathPainter(state.document, null).paint(canvas, const Size(1000, 1000));
              var picture = recorder.endRecording();
              var image = await picture.toImage(1000, 1000);
              image.toByteData(format: ImageByteFormat.png).then((data) {
                if (data == null) {
                  return;
                }
                openImage(data.buffer.asUint8List());
              });
            }),
        IconButton(
            icon: const Icon(PhosphorIcons.floppyDiskLight),
            tooltip: "Save",
            onPressed: () async {
              if (kIsWeb || Platform.isAndroid || Platform.isWindows) {
                Clipboard.setData(ClipboardData(text: jsonEncode(state.document.toJson())));
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Copied to clipboard"),
                          content: const Text("You can now paste it into a text editor"),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
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
