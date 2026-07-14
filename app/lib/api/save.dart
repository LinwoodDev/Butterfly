import 'dart:convert';
import 'dart:io';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:intl/intl.dart';

const templateDateFormatExample = '{date}';
const templateTimeFormatExample = '{time}';
final _templateDateTimePattern = RegExp(r'\{(?:date|time):([^{}]+)\}');

String resolveTemplateFileName(String pattern, DateTime dateTime) {
  final simple = pattern
      .replaceAll('{date}', DateFormat('yyyy-MM-dd').format(dateTime))
      .replaceAll('{time}', DateFormat('HH-mm').format(dateTime));
  final resolved = simple.replaceAllMapped(_templateDateTimePattern, (match) {
    return DateFormat(match.group(1)!).format(dateTime);
  });
  if (resolved.contains('{date:') || resolved.contains('{time:')) {
    throw FormatException('Invalid template date or time formatter', pattern);
  }
  return resolved.trim();
}

String? previewTemplateFileName(String pattern, [DateTime? dateTime]) {
  if (pattern.trim().isEmpty) return null;
  try {
    return resolveTemplateFileName(pattern, dateTime ?? DateTime.now());
  } on FormatException {
    return null;
  }
}

String sanitizeExportFileName(String? name) => convertNameToFile(
  name: name?.trim(),
  getUnnamed: () => 'output',
).replaceAll(RegExp(invalidFileName), '_');

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
  Uint8List bytes, [
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
  Uint8List bytes, [
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

Future<void> exportXopp(
  BuildContext context,
  Uint8List bytes, {
  String? fileName,
  bool share = false,
}) => exportFile(
  context: context,
  bytes: bytes,
  fileExtension: 'xopp',
  mimeType: 'application/x-xojpp',
  uniformTypeIdentifier: 'dev.linwood.butterfly.xopp',
  share: share,
  fileName: sanitizeExportFileName(fileName),
  label: AppLocalizations.of(context).export,
);

Future<void> exportZip(
  BuildContext context,
  Uint8List bytes, [
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
  NoteData data, {
  bool share = false,
  bool isTextBased = false,
}) => exportFile(
  context: context,
  bytes: isTextBased ? data.exportAsTextBytes() : data.exportAsBytes(),
  fileExtension: isTextBased ? 'tbfly' : 'bfly',
  mimeType: isTextBased ? 'application/json' : 'application/octet-stream',
  uniformTypeIdentifier: isTextBased
      ? 'dev.linwood.butterfly.textnote'
      : 'dev.linwood.butterfly.note',
  share: share,
  fileName: 'output',
  label: AppLocalizations.of(context).export,
);

Future<void> writeClipboardData(
  ClipboardManager clipboardManager,
  AssetFileType type,
  Uint8List data,
) async {
  clipboardManager.setContent((data: data, type: type.getMimeTypes().first));
}
