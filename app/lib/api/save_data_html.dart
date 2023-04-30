// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:flutter/material.dart';

Future<void> saveData(BuildContext context, List<int> data) async {
  final a = document.createElement('a') as AnchorElement;
  // Create data URL for zip
  final blob = Blob([data], 'application/zip');
  final url = Url.createObjectUrl(blob);
  a.href = url;
  a.download = 'butterfly.bfly';
  a.click();
}
