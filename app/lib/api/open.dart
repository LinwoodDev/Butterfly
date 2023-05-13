import 'dart:async';
import 'dart:io';

import 'package:butterfly/api/open_stub.dart'
    if (dart.library.io) 'package:butterfly/api/open_io.dart'
    if (dart.library.js) 'package:butterfly/api/open_html.dart' as open;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openHelp(List<String> pageLocation, [String? fragment]) {
  return launchUrl(
      Uri(
          scheme: 'https',
          host: 'docs.butterfly.linwood.dev',
          fragment: fragment,
          pathSegments: ['docs', '2.0', ...pageLocation]),
      mode: LaunchMode.externalApplication);
}

FutureOr<void> openImage(List<int> bytes) {
  return open.openImage(bytes);
}

FutureOr<void> openSvg(String svg) {
  return open.openSvg(svg);
}

FutureOr<void> openPdf(List<int> bytes) {
  return open.openPdf(bytes);
}

FutureOr<void> openZip(List<int> bytes) {
  return open.openZip(bytes);
}

Future<Uint8List?> openBfly() async {
  final isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  final files = await FilePicker.platform.pickFiles(
    type: isMobile ? FileType.any : FileType.custom,
    allowedExtensions: isMobile ? null : ['bfly'],
    allowMultiple: false,
    withData: true,
  );
  if (files?.files.isEmpty ?? true) return null;
  var e = files!.files.first;
  return e.bytes;
}
