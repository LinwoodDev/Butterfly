import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/camera.dart';
import 'package:butterfly/dialogs/pages.dart';
import 'package:butterfly/models/element.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pdf/pdf.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:printing/printing.dart';

import 'error.dart';

class InsertDialog extends StatefulWidget {
  final Offset position;
  const InsertDialog({super.key, required this.position});

  @override
  _InsertDialogState createState() => _InsertDialogState();
}

class _InsertDialogState extends State<InsertDialog> {
  void _submit(List<PadElement> elements) {
    var bloc = context.read<DocumentBloc>();
    var state = bloc.state;
    var transform = context.read<TransformCubit>().state;
    if (state is! DocumentLoadSuccess) return;
    var bakedViewport = state.cameraViewport;
    bloc.add(ElementsCreated(elements));
    bloc.add(ImageBaked(
        viewportSize: bakedViewport.toSize(),
        cameraTransform: transform,
        pixelRatio: MediaQuery.of(context).devicePixelRatio));
    Navigator.of(context).pop();
  }

  Future<void> _insertImage(Uint8List content) async {
    _runInsertImage(content).catchError((error, stackTrace) => showDialog(
        context: context,
        builder: (context) =>
            ErrorDialog(error: error, stackTrace: stackTrace)));
  }

  Future<void> _runInsertImage(Uint8List content) async {
    var bloc = context.read<DocumentBloc>();
    var codec = await ui.instantiateImageCodec(content);
    var frame = await codec.getNextFrame();
    var image = frame.image.clone();

    var bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    var state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    _submit([
      ImageElement(
          height: image.height,
          width: image.width,
          layer: state.currentLayer,
          pixels: bytes?.buffer.asUint8List() ?? Uint8List(0),
          position: widget.position)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(PhosphorIcons.plusLight),
          ),
          Text(AppLocalizations.of(context)!.insert),
        ],
      ),
      scrollable: true,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.image),
          leading: const Icon(PhosphorIcons.imageLight),
          onTap: () async {
            var files = await FilePicker.platform.pickFiles(
                type: FileType.image, allowMultiple: false, withData: true);
            if (files?.files.isEmpty ?? true) return;
            var e = files!.files.first;
            var content = e.bytes ?? Uint8List(0);
            if (!kIsWeb) {
              content = await File(e.path ?? '').readAsBytes();
            }
            _insertImage(content);
          },
        ),
        if (kIsWeb ||
            Platform.isWindows ||
            Platform.isAndroid ||
            Platform.isIOS)
          ListTile(
              title: Text(AppLocalizations.of(context)!.camera),
              leading: const Icon(PhosphorIcons.cameraLight),
              onTap: () async {
                var content = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CameraDialog()),
                ) as Uint8List?;
                if (content == null) return;
                _insertImage(content);
              }),
        ListTile(
            title: Text(AppLocalizations.of(context)!.pdf),
            leading: const Icon(PhosphorIcons.filePdfLight),
            onTap: () async {
              try {
                final files = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                    allowMultiple: false,
                    withData: true);
                if (files?.files.isEmpty ?? true) return;
                var e = files!.files.first;
                var content = e.bytes ?? Uint8List(0);
                if (!kIsWeb) {
                  content = await File(e.path ?? '').readAsBytes();
                }
                final elements = <Uint8List>[];
                await for (var page in Printing.raster(content)) {
                  final png = await page.toPng();
                  elements.add(png);
                }
                final callback = await showDialog<PageDialogCallback>(
                    context: context,
                    builder: (context) => PagesDialog(pages: elements));
                if (callback == null) return;
                final selectedElements = <ImageElement>[];
                var y = widget.position.dy;
                await for (var page in Printing.raster(content,
                    pages: callback.pages,
                    dpi: PdfPageFormat.inch * callback.quality)) {
                  final png = await page.toPng();
                  final scale = callback.quality;
                  selectedElements.add(ImageElement(
                      height: page.height,
                      width: page.width,
                      pixels: png,
                      constraints: ElementConstraints.scaled(scale),
                      position: Offset(widget.position.dx, y)));
                  y += page.height;
                }
                _submit(selectedElements);
              } catch (e, stackTrace) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        ErrorDialog(error: e, stackTrace: stackTrace));
              }
            }),
      ]),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel)),
      ],
    );
  }
}
