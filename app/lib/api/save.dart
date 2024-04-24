import 'dart:io';

import 'package:butterfly/api/save_stub.dart'
    if (dart.library.io) 'package:butterfly/api/save_io.dart'
    if (dart.library.js) 'package:butterfly/api/save_html.dart' as save;
import 'package:butterfly/helpers/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:share_plus/share_plus.dart';
import 'package:super_clipboard/super_clipboard.dart';

bool supportsShare() => kIsWeb || !Platform.isLinux;

Future<void> exportFile(BuildContext context, List<int> bytes,
    String fileExtension, String mimeType, String uniformTypeIdentifier,
    [bool share = false]) async {
  if (share && supportsShare()) {
    return exportUsingShare(bytes, fileExtension, mimeType);
  }
  return save.exportFile(
      context, bytes, fileExtension, mimeType, uniformTypeIdentifier);
}

Future<void> exportUsingShare(
    List<int> bytes, String fileExtension, String mimeType) async {
  await Share.shareXFiles(
    [
      XFile.fromData(Uint8List.fromList(bytes),
          mimeType: mimeType, name: 'output.$fileExtension')
    ],
  );
}

Future<void> exportSvg(BuildContext context, String data,
        [bool share = false]) =>
    exportFile(
        context, data.codeUnits, 'svg', 'image/svg', 'public.svg-image', share);

Future<void> exportImage(BuildContext context, List<int> bytes,
        [bool share = false]) =>
    exportFile(context, bytes, 'png', 'image/png', 'public.image', share);

Future<void> exportPdf(BuildContext context, List<int> bytes,
        [bool share = false]) =>
    exportFile(
        context, bytes, 'pdf', 'application/pdf', 'com.adobe.pdf', share);

Future<void> exportZip(BuildContext context, List<int> bytes,
        [bool share = false]) =>
    exportFile(
        context, bytes, 'zip', 'application/zip', 'public.zip-archive', share);

Future<void> exportData(BuildContext context, List<int> bytes,
        [bool share = false]) =>
    exportFile(context, bytes, 'bfly', 'application/zip',
        'dev.linwood.butterfly.note', share);

void saveToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(AppLocalizations.of(context).copyTitle),
  ));
}

Future<void> writeClipboardData(ClipboardManager clipboardManager,
    AssetFileType type, Uint8List data) async {
  final clipboard = SystemClipboard.instance;
  if (clipboard != null &&
      !kIsWeb &&
      (!Platform.isAndroid ||
          (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 23)) {
    final item = DataWriterItem();
    final format = type.getClipboardFormats().first;
    item.add(format(data));
    clipboard.write([item]);
  } else {
    clipboardManager.setContent((data: data, type: type.name));
  }
}
