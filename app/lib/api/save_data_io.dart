import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

Future<void> saveData(BuildContext context, String data) async {
  if (Platform.isAndroid || Platform.isIOS) {
    await Share.share(data);
    return;
  }
  var fileName = await FilePicker.platform.saveFile(
      fileName: 'butterfly.bfly',
      type: FileType.custom,
      allowedExtensions: ['json', 'bfly']);

  if (fileName == null) {
    return;
  }
  if (!fileName.endsWith('.bfly') && !fileName.endsWith('.json')) {
    fileName += '.bfly';
  }
  var file = File(fileName);
  Future<void> write() async {
    await file.writeAsString(data);
  }

  if (!file.existsSync()) {
    write();
  } else {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.areYouSure),
              content: Text(AppLocalizations.of(context)!.existOverride),
              actions: [
                TextButton(
                    child: Text(AppLocalizations.of(context)!.no),
                    onPressed: () => Navigator.of(context).pop()),
                ElevatedButton(
                    child: Text(AppLocalizations.of(context)!.yes),
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      await write();
                      navigator.pop();
                    })
              ],
            ));
  }
}
