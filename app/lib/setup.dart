import 'dart:convert';

import 'package:butterfly/api/file_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/full_screen.dart';
import 'models/converter.dart';

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
        .map((e) => const DocumentJsonConverter()
            .fromJson(Map<String, dynamic>.from(jsonDecode(e))))
        .map((element) => DocumentFileSystem.fromPlatform()
            .updateDocument(element.name, element)));
  }
  setupFullScreen();
}
