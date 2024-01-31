import 'dart:io';
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart' as fs;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

Future<void> exportFile(
  BuildContext context,
  List<int> bytes,
  String fileExtension,
  String mimeType,
) async {
  final file = fs.XFile.fromData(Uint8List.fromList(bytes),
      mimeType: mimeType, name: 'output.$fileExtension');
  if (Platform.isAndroid || Platform.isIOS) {
    Share.shareXFiles([file]);
    return;
  }
  final result = await fs.getSaveLocation(
    acceptedTypeGroups: [
      fs.XTypeGroup(
        label: AppLocalizations.of(context).export,
        extensions: [fileExtension],
        mimeTypes: [mimeType],
      ),
    ],
  );
  if (result == null) return;
  await file.saveTo(result.path);
}
