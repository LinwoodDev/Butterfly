import 'dart:convert';
import 'dart:io';

import 'package:butterfly/api/file_system.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/file_system_io.dart';
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
  // Moving to external storage on Android
  if (!kIsWeb && Platform.isAndroid) {
    if (prefs.containsKey('document_path')) {
      prefs.remove('document_path');
    }
    if (!prefs.containsKey('android_storage_application')) {
      try {
        var dir = await getApplicationDocumentsDirectory();
        final oldPath = '${dir.path}/Linwood/Butterfly';
        final newPath = await getButterflyDirectory();
        await _moveDirectory(oldPath, newPath);
        prefs.setBool('android_storage_application', true);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
  setupFullScreen();
}

Future<void> _moveDirectory(String oldPath, String newPath) async {
  var oldDirectory = Directory(oldPath);
  if (await oldDirectory.exists()) {
    var files = await oldDirectory.list().toList();
    for (final file in files) {
      if (file is File) {
        var newFile = File('$newPath/${file.path.split('/').last}');
        final content = await file.readAsBytes();
        await newFile.create(recursive: true);
        await newFile.writeAsBytes(content);
        await file.delete();
      } else if (file is Directory) {
        await _moveDirectory(
            file.path, '$newPath/${file.path.split('/').last}');
      }
    }
  }
}
