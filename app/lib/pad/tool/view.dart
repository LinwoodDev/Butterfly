import 'dart:io';
import 'dart:ui';

import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/views/view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

class ViewToolbar extends StatefulWidget {
  final DocumentBloc bloc;
  const ViewToolbar({Key? key, required this.bloc}) : super(key: key);

  @override
  _ViewToolbarState createState() => _ViewToolbarState();
}

class _ViewToolbarState extends State<ViewToolbar> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
        if (state is! DocumentLoadSuccess) {
          return Container();
        }
        return IconButton(
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
                if (!kIsWeb) {
                  getApplicationDocumentsDirectory().then((dir) {
                    var file = File("${dir.path}/export.png");
                    file.writeAsBytesSync(data.buffer.asUint8List());
                    launch("file://${file.path}");
                  });
                }
              });
            });
      }),
      IconButton(icon: const Icon(PhosphorIcons.printerLight), tooltip: "Print", onPressed: () {}),
      IconButton(
          icon: const Icon(PhosphorIcons.monitorPlayLight),
          tooltip: "Presentation",
          onPressed: () {})
    ]);
  }
}
