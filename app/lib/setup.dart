import 'dart:convert';

import 'package:butterfly/api/file_system.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:butterfly/api/full_screen_stub.dart'
    if (dart.library.io) 'package:butterfly/api/full_screen_io.dart'
    if (dart.library.js) 'package:butterfly/api/full_screen_html.dart'
    as full_screen;

import 'models/document.dart';

Future<void> setup() async {
  // Convert old file system to new file system
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('date_format')) {
    prefs.setString('date_format', 'dd/MM/yyyy HH:mm');
  }
  if (prefs.containsKey('documents')) {
    var documents = prefs.getStringList('documents')!;
    prefs.remove('documents');
    await Future.wait(documents
        .map((e) => AppDocument.fromJson(jsonDecode(e)))
        .map((element) => DocumentFileSystem.fromPlatform()
            .updateDocument(element.name, element)));
  }
  full_screen.setup();
}
