import 'dart:convert';
import 'dart:io';

import 'package:butterfly/helpers/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:super_clipboard/super_clipboard.dart';

Future<void> exportSvg(
  BuildContext context,
  String data, [
  bool share = false,
]) => exportFile(
  context: context,
  bytes: utf8.encode(data),
  fileExtension: 'svg',
  mimeType: 'image/svg+xml',
  uniformTypeIdentifier: 'public.svg-image',
  share: kIsWeb || !Platform.isWindows ? share : false,
  fileName: 'output',
  label: AppLocalizations.of(context).export,
);

Future<void> exportImage(
  BuildContext context,
  List<int> bytes, [
  bool share = false,
]) => exportFile(
  context: context,
  bytes: bytes,
  fileExtension: 'png',
  mimeType: 'image/png',
  uniformTypeIdentifier: 'public.image',
  share: share,
  fileName: 'output',
  label: AppLocalizations.of(context).export,
);

Future<void> exportPdf(
  BuildContext context,
  List<int> bytes, [
  bool share = false,
]) => exportFile(
  context: context,
  bytes: bytes,
  fileExtension: 'pdf',
  mimeType: 'application/pdf',
  uniformTypeIdentifier: 'com.adobe.pdf',
  share: share,
  fileName: 'output',
  label: AppLocalizations.of(context).export,
);

Future<void> exportZip(
  BuildContext context,
  List<int> bytes, [
  bool share = false,
]) => exportFile(
  context: context,
  bytes: bytes,
  fileExtension: 'zip',
  mimeType: 'application/zip',
  uniformTypeIdentifier: 'public.zip-archive',
  share: share,
  fileName: 'output',
  label: AppLocalizations.of(context).export,
);

Future<void> exportData(
  BuildContext context,
  List<int> bytes, [
  bool share = false,
]) => exportFile(
  context: context,
  bytes: bytes,
  fileExtension: 'bfly',
  mimeType: 'application/octet-stream',
  uniformTypeIdentifier: 'dev.linwood.butterfly.note',
  share: share,
  fileName: 'output',
  label: AppLocalizations.of(context).export,
);

Future<void> writeClipboardData(
  ClipboardManager clipboardManager,
  AssetFileType type,
  Uint8List data,
) async {
  final clipboard = SystemClipboard.instance;
  if (clipboard != null) {
    final item = DataWriterItem();
    final format = type.getClipboardFormats().first;
    item.add(format(data));
    clipboard.write([item]);
  } else {
    clipboardManager.setContent((data: data, type: type.name));
  }
}
