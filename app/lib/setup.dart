import 'dart:convert';

import 'package:butterfly/api/file_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/document.dart';

Future<void> setup() async {
  // Convert old file system to new file system
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('documents')) {
    var documents = prefs.getStringList('documents')!;
    prefs.remove('documents');
    await Future.wait(documents
        .map((e) => AppDocument.fromJson(jsonDecode(e)))
        .map((element) => DocumentFileSystem.fromPlatform()
            .updateDocument(element.name, element)));
  }
}
