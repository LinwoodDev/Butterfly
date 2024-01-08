import 'dart:io';

import 'package:file_selector/file_selector.dart' as fs;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
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

Future<void> exportSvg(BuildContext context, String data) =>
    exportFile(context, data.codeUnits, 'svg', 'image/svg');

Future<void> exportImage(BuildContext context, List<int> bytes) =>
    exportFile(context, bytes, 'png', 'image/png');

Future<void> exportPdf(BuildContext context, List<int> bytes) =>
    exportFile(context, bytes, 'pdf', 'application/pdf');

Future<void> exportZip(BuildContext context, List<int> bytes) =>
    exportFile(context, bytes, 'zip', 'application/zip');

Future<void> saveData(BuildContext context, List<int> bytes) =>
    exportFile(context, bytes, 'bfly', 'application/zip');

void saveToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(AppLocalizations.of(context).copyTitle),
    ),
  );
}
