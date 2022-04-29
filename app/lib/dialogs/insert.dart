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
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:printing/printing.dart';

class InsertDialog extends StatefulWidget {
  final Offset position;
  const InsertDialog({Key? key, required this.position}) : super(key: key);

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
    bloc.add(ImageBaked(bakedViewport.toSize(),
        MediaQuery.of(context).devicePixelRatio, transform));
    Navigator.of(context).pop();
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
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.image),
          leading: const Icon(PhosphorIcons.imageLight),
          onTap: () async {
            final bloc = context.read<DocumentBloc>();
            var files = await FilePicker.platform.pickFiles(
                type: FileType.image, allowMultiple: false, withData: true);
            if (files?.files.isEmpty ?? true) return;
            var e = files!.files.first;
            var content = e.bytes ?? Uint8List(0);
            if (!kIsWeb) {
              content = await File(e.path ?? '').readAsBytes();
            }
            var codec =
                await ui.instantiateImageCodec(content, targetWidth: 500);
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
                final bloc = context.read<DocumentBloc>();
                var content = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CameraDialog()),
                ) as Uint8List?;
                if (content == null) return;
                var codec =
                    await ui.instantiateImageCodec(content, targetWidth: 500);
                var frame = await codec.getNextFrame();
                var image = frame.image.clone();

                var bytes =
                    await image.toByteData(format: ui.ImageByteFormat.png);
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
              }),
        ListTile(
            title: Text(AppLocalizations.of(context)!.pdf),
            leading: const Icon(PhosphorIcons.filePdfLight),
            onTap: () async {
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
              var y = widget.position.dy;
              final elements = <ImageElement>[];
              await for (var page in Printing.raster(content)) {
                final png = await page.toPng();
                elements.add(ImageElement(
                    height: page.height,
                    width: page.width,
                    pixels: Uint8List.fromList(png),
                    position: Offset(widget.position.dx, y)));
                y = y + page.height;
              }
              final selectedPages = await showDialog<List<int>>(
                  context: context,
                  builder: (context) => PagesDialog(
                      pages: elements.map((e) => e.pixels).toList()));
              if (selectedPages == null) return;
              final selectedElements = <ImageElement>[];
              y = widget.position.dy;
              for (var i = 0; i < elements.length; i++) {
                if (selectedPages.contains(i)) {
                  final current = elements[i];
                  selectedElements.add(current.copyWith(
                      position: Offset(widget.position.dx, y)));
                  y += current.height;
                }
              }
              _submit(selectedElements);
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
