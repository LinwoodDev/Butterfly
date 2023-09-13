import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> exportFile(
  BuildContext context,
  List<int> bytes,
  String fileExtension,
  String mimeType,
) async {
  if (Platform.isAndroid) {
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final tempFile = File('$tempPath/export.$fileExtension');
    await tempFile.writeAsBytes(bytes);
    await Share.shareXFiles([XFile(tempFile.path)]);
    return;
  }
  final loc = AppLocalizations.of(context);
  var fileName = await FilePicker.platform.saveFile(
    fileName: 'export.$fileExtension',
    type: FileType.custom,
    allowedExtensions: [fileExtension],
    dialogTitle: loc.export,
  );

  if (fileName == null) {
    return;
  }
  if (!fileName.endsWith('.$fileExtension')) {
    fileName += '.$fileExtension';
  }
  var file = File(fileName);
  if (file.existsSync() && context.mounted) {
    final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(loc.areYouSure),
              content: Text(loc.existOverride),
              actions: [
                TextButton(
                    child: Text(loc.no),
                    onPressed: () => Navigator.of(context).pop(false)),
                ElevatedButton(
                    child: Text(loc.yes),
                    onPressed: () async {
                      Navigator.of(context).pop(true);
                    })
              ],
            ));
    if (result != true) {
      return;
    }
  }
  await file.writeAsBytes(bytes);
}
