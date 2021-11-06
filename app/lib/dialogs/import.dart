import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ImportDialog extends StatefulWidget {
  const ImportDialog({Key? key}) : super(key: key);

  @override
  _ImportDialogState createState() => _ImportDialogState();
}

class _ImportDialogState extends State<ImportDialog> {
  @override
  Widget build(BuildContext context) {
    var isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    return AlertDialog(
      title: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(PhosphorIcons.arrowSquareInLight),
          ),
          Text(AppLocalizations.of(context)!.import),
        ],
      ),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
            onTap: () => Clipboard.getData('text/plain')
                .then((value) => Navigator.of(context).pop(value?.text)),
            title: Text(AppLocalizations.of(context)!.clipboard)),
        ListTile(
            onTap: () {
              FilePicker.platform
                  .pickFiles(
                      type: isMobile ? FileType.any : FileType.custom,
                      allowedExtensions: isMobile ? null : ['json'])
                  .then((files) {
                if (files?.files.isEmpty ?? true) return;
                var e = files!.files.first;
                var content = String.fromCharCodes(e.bytes ?? Uint8List(0));
                if (!kIsWeb) content = File(e.path ?? '').readAsStringSync();
                Navigator.of(context).pop(content);
              });
            },
            title: Text(AppLocalizations.of(context)!.file)),
      ]),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel)),
      ],
    );
  }
}
