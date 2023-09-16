// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:flutter/material.dart';

void exportFile(
  BuildContext context,
  List<int> bytes,
  String fileExtension,
  String mimeType,
) {
  final a = document.createElement('a') as AnchorElement;
  // Create data URL for zip
  final blob = Blob([bytes], mimeType);
  final url = Url.createObjectUrl(blob);
  a.href = url;
  a.download = 'export.$fileExtension';
  a.click();
}
