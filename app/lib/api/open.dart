import 'dart:async';
import 'dart:io';

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
