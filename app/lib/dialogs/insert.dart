import 'dart:io';
import 'dart:typed_data';

import 'package:butterfly/dialogs/camera.dart';
import 'package:butterfly/services/import.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsertDialog extends StatelessWidget {
  final Offset position;

  const InsertDialog({super.key, required this.position});

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
            Navigator.of(context).pop();
            var files = await FilePicker.platform.pickFiles(
                type: FileType.image, allowMultiple: false, withData: true);
            if (files?.files.isEmpty ?? true) return;
            var e = files!.files.first;
            var content = e.bytes ?? Uint8List(0);
            if (!kIsWeb) {
              content = await File(e.path ?? '').readAsBytes();
            }
            importService.importImage(content, position);
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
                Navigator.of(context).pop();
                var content = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CameraDialog()),
                ) as Uint8List?;
                if (content == null) return;
                importService.importImage(content, position);
              }),
        ListTile(
          title: Text(AppLocalizations.of(context)!.svg),
          leading: const Icon(PhosphorIcons.sunLight),
          onTap: () async {
            Navigator.of(context).pop();
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
            importService.importSvg(content, position);
          },
        ),
        ListTile(
            title: Text(AppLocalizations.of(context)!.pdf),
            leading: const Icon(PhosphorIcons.filePdfLight),
            onTap: () async {
              Navigator.of(context).pop();
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
              importService.importSvg(content, position);
            }),
        ListTile(
            title: Text(AppLocalizations.of(context)!.document),
            leading: const Icon(PhosphorIcons.fileTextLight),
            onTap: () async {
              Navigator.of(context).pop();
              final files = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['bfly', 'json'],
                  allowMultiple: false,
                  withData: true);
              if (files?.files.isEmpty ?? true) return;
              var e = files!.files.first;
              var content = e.bytes ?? Uint8List(0);
              if (!kIsWeb) {
                content = await File(e.path ?? '').readAsBytes();
              }
              importService.importNote(content, position, false);
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
