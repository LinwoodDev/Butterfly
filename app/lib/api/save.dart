import 'package:butterfly/api/save_stub.dart'
    if (dart.library.io) 'package:butterfly/api/save_io.dart'
    if (dart.library.js) 'package:butterfly/api/save_html.dart' as save;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> exportFile(
  BuildContext context,
  List<int> bytes,
  String fileExtension,
  String mimeType,
  String uniformTypeIdentifier,
) =>
    save.exportFile(
        context, bytes, fileExtension, mimeType, uniformTypeIdentifier);

Future<void> exportSvg(BuildContext context, String data) =>
    exportFile(context, data.codeUnits, 'svg', 'image/svg', 'public.svg-image');

Future<void> exportImage(BuildContext context, List<int> bytes) =>
    exportFile(context, bytes, 'png', 'image/png', 'public.image');

Future<void> exportPdf(BuildContext context, List<int> bytes) =>
    exportFile(context, bytes, 'pdf', 'application/pdf', 'com.adobe.pdf');

Future<void> exportZip(BuildContext context, List<int> bytes) =>
    exportFile(context, bytes, 'zip', 'application/zip', 'public.zip-archive');

Future<void> exportData(BuildContext context, List<int> bytes) => exportFile(
    context, bytes, 'bfly', 'application/zip', 'dev.linwood.butterfly.note');

void saveToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(AppLocalizations.of(context).copyTitle),
    ),
  );
}
