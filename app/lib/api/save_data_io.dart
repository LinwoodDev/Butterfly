import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> saveData(BuildContext context, List<int> data) async {
  if (Platform.isAndroid) {
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final tempFile = File('$tempPath/butterfly.bfly');
    await tempFile.writeAsBytes(data);
    await Share.shareXFiles([XFile(tempFile.path)]);
    return;
  }
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
