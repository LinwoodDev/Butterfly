import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> saveData(BuildContext context, List<int> data) async {
  var fileName = await FilePicker.platform.saveFile(
      fileName: 'butterfly.bfly',
      type: FileType.custom,
      allowedExtensions: ['bfly']);

  if (fileName == null) {
    return;
  }
  if (!fileName.endsWith('.bfly')) {
    fileName += '.bfly';
  }
  var file = File(fileName);
  Future<void> write() async {
    await file.writeAsBytes(data);
  }

  if (!file.existsSync()) {
    write();
  } else if (context.mounted) {
    await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context).areYouSure),
              content: Text(AppLocalizations.of(context).existOverride),
              actions: [
                TextButton(
                    child: Text(AppLocalizations.of(context).no),
                    onPressed: () => Navigator.of(context).pop()),
                ElevatedButton(
                    child: Text(AppLocalizations.of(context).yes),
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      await write();
                      navigator.pop();
                    })
              ],
            ));
  }
}
