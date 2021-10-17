import 'dart:ui';

import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/views/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:butterfly/api/open_image.dart'
    if (dart.library.io) 'package:butterfly/api/open_image_io.dart'
    if (dart.library.js) 'package:butterfly/api/open_image_html.dart';

class ExportDialog extends StatefulWidget {
  final DocumentBloc bloc;

  const ExportDialog({Key? key, required this.bloc}) : super(key: key);

  @override
  State<ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<ExportDialog> {
  final TextEditingController _xController = TextEditingController(text: "0");

  final TextEditingController _yController = TextEditingController(text: "0");

  final TextEditingController _widthController = TextEditingController(text: "1000");

  final TextEditingController _heightController = TextEditingController(text: "1000");

  bool _renderBackground = true;
  int x = 0, y = 0, width = 1000, height = 1000;

  ByteData? _previewImage;

  @override
  void initState() {
    _regeneratePreviewImage();
    super.initState();
  }

  void _regeneratePreviewImage() async {
    var image = await generateImage();
    if (mounted) setState(() => _previewImage = image);
  }

  Future<ByteData?> generateImage() async {
    var recorder = PictureRecorder();
    var canvas = Canvas(recorder);
    PathPainter((widget.bloc.state as DocumentLoadSuccess).document, null,
            renderBackground: _renderBackground)
        .paint(canvas, Size(width.toDouble(), height.toDouble()),
            offset: -Offset(x.toDouble(), y.toDouble()));
    var picture = recorder.endRecording();
    var image = await picture.toImage(width, height);
    return await image.toByteData(format: ImageByteFormat.png);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 1000),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.export),
                leading: const Icon(PhosphorIcons.exportLight),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                              if (state is! DocumentLoadSuccess || _previewImage == null) {
                                return Container();
                              }
                              return InteractiveViewer(
                                  child: Image.memory(_previewImage!.buffer.asUint8List()));
                            }),
                          ),
                        ),
                        Expanded(
                            child: ListView(children: [
                          TextField(
                              controller: _xController,
                              decoration: const InputDecoration(labelText: 'X'),
                              onChanged: (value) => x = int.tryParse(value) ?? x,
                              onSubmitted: (value) => _regeneratePreviewImage()),
                          TextField(
                              controller: _yController,
                              decoration: const InputDecoration(labelText: 'Y'),
                              onChanged: (value) => y = int.tryParse(value) ?? y,
                              onSubmitted: (value) => _regeneratePreviewImage()),
                          TextField(
                              controller: _widthController,
                              decoration:
                                  InputDecoration(labelText: AppLocalizations.of(context)!.width),
                              onChanged: (value) => width = int.tryParse(value) ?? width,
                              onSubmitted: (value) => _regeneratePreviewImage()),
                          TextField(
                              controller: _heightController,
                              decoration:
                                  InputDecoration(labelText: AppLocalizations.of(context)!.height),
                              onChanged: (value) => height = int.tryParse(value) ?? height,
                              onSubmitted: (value) => _regeneratePreviewImage()),
                          CheckboxListTile(
                              value: _renderBackground,
                              title: Text(AppLocalizations.of(context)!.background),
                              onChanged: (value) {
                                setState(() => _renderBackground = value ?? _renderBackground);
                                _regeneratePreviewImage();
                              })
                        ]))
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
                          child: Text(AppLocalizations.of(context)!.export),
                          onPressed: () async {
                            var data = await generateImage();
                            if (data == null) {
                              return;
                            }
                            openImage(data.buffer.asUint8List());
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
