import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/camera.dart';
import 'package:butterfly/dialogs/pages.dart';
import 'package:butterfly/models/element.dart';
import 'package:butterfly/services/import.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/parser.dart';
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
  @override
  Widget build(BuildContext context) {
    final importService = context.read<ImportService>();
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
            importService.importImage(content);
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
                importService.importImage(content);
              }),
        ListTile(
          title: Text(AppLocalizations.of(context)!.svg),
          leading: const Icon(PhosphorIcons.sunLight),
          onTap: () async {
            var files = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['svg'],
                allowMultiple: false,
                withData: true);
            if (files?.files.isEmpty ?? true) return;
            var e = files!.files.first;
            var content = e.bytes ?? Uint8List(0);
            if (!kIsWeb) {
              content = await File(e.path ?? '').readAsBytes();
            }
            importService.importSvg(content);
          },
        ),
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
              importService.importSvg(content);
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
