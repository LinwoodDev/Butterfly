import 'dart:io';
import 'dart:typed_data';

import 'package:butterfly/api/save.dart';
import 'package:butterfly/main.dart';
import 'package:file_selector/file_selector.dart' as fs;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> exportFile(
  BuildContext context,
  List<int> bytes,
  String fileExtension,
  String mimeType,
  String uniformTypeIdentifier,
) async {
  if (Platform.isIOS) {
    return exportUsingShare(bytes, fileExtension, mimeType);
  }
  if (Platform.isAndroid) {
    await platform.invokeMethod('saveFile', {
      'mime': mimeType,
      'data': Uint8List.fromList(bytes),
      'name': 'output.$fileExtension',
    });
    return;
  }
  final file = fs.XFile.fromData(Uint8List.fromList(bytes),
      mimeType: mimeType, name: 'output.$fileExtension');
  final result = await fs.getSaveLocation(
    acceptedTypeGroups: [
      fs.XTypeGroup(
        label: AppLocalizations.of(context).export,
        uniformTypeIdentifiers: [uniformTypeIdentifier],
        extensions: [fileExtension],
        mimeTypes: [mimeType],
      ),
    ],
  );
  if (result == null) return;
  await file.saveTo(result.path);
}
