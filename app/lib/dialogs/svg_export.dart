import 'dart:io';
import 'dart:ui' as ui;

import 'package:butterfly/api/open_image.dart';
import 'package:butterfly/api/xml_helper.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/element.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';

import '../view_painter.dart';

class SvgExportDialog extends StatefulWidget {
  final double x, y;
  final int width, height;

  const SvgExportDialog({
    Key? key,
    this.x = 0,
    this.y = 0,
    this.width = 1000,
    this.height = 1000,
  }) : super(key: key);

  @override
  State<SvgExportDialog> createState() => _SvgExportDialogState();
}

class _SvgExportDialogState extends State<SvgExportDialog> {
  Map<PadElement, ui.Image>? images;
  final TextEditingController _xController = TextEditingController(text: '0');

  final TextEditingController _yController = TextEditingController(text: '0');

  final TextEditingController _widthController =
      TextEditingController(text: '1000');

  final TextEditingController _heightController =
      TextEditingController(text: '1000');

  bool _renderBackground = true;
  double x = 0, y = 0;
  int width = 1000, height = 1000;

  ByteData? _previewImage;
  Future? _regeneratingFuture;

  @override
  void initState() {
    x = widget.x;
    y = widget.y;
    width = widget.width;
    height = widget.height;
    _xController.text = x.toString();
    _yController.text = y.toString();
    _widthController.text = width.toString();
    _heightController.text = height.toString();
    _regeneratePreviewImage();

    super.initState();
  }

  Future<void> _regeneratePreviewImage() async {
    if (_regeneratingFuture != null) return;
    var imageFuture = _generateImage();
    _regeneratingFuture =
        _regeneratingFuture?.then((value) => imageFuture) ?? imageFuture;
    var image = await _regeneratingFuture;
    _regeneratingFuture = null;
    if (mounted) setState(() => _previewImage = image);
  }

  Future<ByteData?> _generateImage() async {
    var recorder = ui.PictureRecorder();
    var canvas = Canvas(recorder);
    var current = context.read<DocumentBloc>().state as DocumentLoadSuccess;
    var painter = ViewPainter(current.document,
        renderBackground: _renderBackground,
        cameraViewport: current.cameraViewport.unbake(current.renderers),
        transform: CameraTransform(-Offset(x.toDouble(), y.toDouble())));
    painter.paint(canvas, Size(width.toDouble(), height.toDouble()));
    var picture = recorder.endRecording();
    var image = await picture.toImage(width, height);
    return await image.toByteData(format: ui.ImageByteFormat.png);
  }

  Future<XmlDocument> _generateSvg() async {
    final document = XmlDocument();
    document.createElement('svg', attributes: {
      'xmlns': 'http://www.w3.org/2000/svg',
      'xmlns:xlink': 'http://www.w3.org/1999/xlink',
      'version': '1.1',
      'width': '${width}px',
      'height': '${height}px',
      'viewBox': '$x $y $width $height',
    });

    var current = context.read<DocumentBloc>().state as DocumentLoadSuccess;
    final rect = Rect.fromLTWH(x, y, width.toDouble(), height.toDouble());
    for (var e in current.renderers) {
      e.buildSvg(document, current.document, rect);
    }
    return document;
  }

  Future<void> _exportSvg() async {
    final data = await _generateSvg();
    if (!mounted) return;

    if (!kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      var path = await FilePicker.platform.saveFile(
        type: FileType.image,
        dialogTitle: AppLocalizations.of(context)!.export,
      );
      if (path != null) {
        var file = File(path);
        if (!(await file.exists())) {
          file.create(recursive: true);
        }
        await file.writeAsString(data.toXmlString());
        launch('file://${file.path}');
      }
    } else {
      openSvg(data.toXmlString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Dialog(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 1000),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.export),
                leading: const Icon(PhosphorIcons.exportLight),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: LayoutBuilder(builder: (context, constraints) {
                        var isMobile = constraints.maxWidth < 600;
                        if (isMobile) {
                          return ListView(
                            children: [_buildPreview(), _buildProperties()],
                          );
                        }
                        return Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: _buildPreview(),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: _buildProperties(),
                                ),
                              )
                            ]);
                      }),
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
                            Navigator.of(context).pop();
                            _exportSvg();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ),
      );
    });
  }

  Widget _buildPreview() => Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
          if (state is! DocumentLoadSuccess || _previewImage == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Image(
            image: MemoryImage(_previewImage!.buffer.asUint8List()),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          );
        }),
      );

  Widget _buildProperties() => Column(children: [
        TextField(
            controller: _xController,
            decoration: const InputDecoration(labelText: 'X'),
            onChanged: (value) => x = double.tryParse(value) ?? x,
            onSubmitted: (value) => _regeneratePreviewImage()),
        TextField(
            controller: _yController,
            decoration: const InputDecoration(labelText: 'Y'),
            onChanged: (value) => y = double.tryParse(value) ?? y,
            onSubmitted: (value) => _regeneratePreviewImage()),
        TextField(
            controller: _widthController,
            decoration:
                InputDecoration(labelText: AppLocalizations.of(context)!.width),
            onChanged: (value) => width = int.tryParse(value) ?? width,
            onSubmitted: (value) => _regeneratePreviewImage()),
        TextField(
            controller: _heightController,
            decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.height),
            onChanged: (value) => height = int.tryParse(value) ?? height,
            onSubmitted: (value) => _regeneratePreviewImage()),
        CheckboxListTile(
            value: _renderBackground,
            title: Text(AppLocalizations.of(context)!.background),
            onChanged: (value) {
              setState(() => _renderBackground = value ?? _renderBackground);
              _regeneratePreviewImage();
            })
      ]);
}
