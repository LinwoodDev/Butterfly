// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:flutter/material.dart';

Future<void> saveData(BuildContext context, String data) async {
  final a = document.createElement('a') as AnchorElement;
  // Create data URL
  final blob = Blob([data], 'text/plain');
  final url = Url.createObjectUrl(blob);
  a.href = url;
  a.download = 'butterfly.bfly';
  a.click();
}
