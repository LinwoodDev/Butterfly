// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:flutter/material.dart';

Future<void> exportFile(
  BuildContext context,
  List<int> bytes,
  String fileExtension,
  String mimeType,
) async {
  final a = document.createElement('a') as AnchorElement;
  // Create data URL
  final blob = Blob([bytes], 'text/plain');
  final url = Url.createObjectUrl(blob);
  a.href = url;
  a.download = 'output.$fileExtension';
  a.click();
}
