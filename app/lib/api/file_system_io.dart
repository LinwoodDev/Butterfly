import 'dart:convert';
import 'dart:io';

import 'package:butterfly/models/document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file_system.dart';

class IODocumentFileSystem extends DocumentFileSystem {
  @override
  Future<AppDocumentFile> importDocument(AppDocument document) async {
    var dir = await getDirectory();
    var name = encodeFileName(document.name);
    var counter = 1;
    while (await hasDocument(name)) {
      name = '${document.name}_${++counter}';
    }
    var file = File('${dir.path}/$name.json');
    file = await file.create();
    await file.writeAsString(json.encode(document.toJson()));
    return AppDocumentFile(file.path, document.toJson());
  }

  @override
  Future<void> deleteDocument(String path) {
    return File(path).delete();
  }

  @override
  Future<AppDocumentFile?> getDocument(String path) async {
    var file = File('$path.json');
    if (!await file.exists()) return null;

    var json = jsonDecode(await file.readAsString());
    return AppDocumentFile(path, AppDocument.fromJson(json).toJson());
  }

  @override
  Future<List<AppDocumentFile>> getDocuments() async {
    var dir = await getDirectory();
    var files = await dir
        .list()
        .where((event) => event is File)
        .where((event) => event.path.endsWith('.json'))
        .map((event) {
          // Ignore FormatException on decode
          try {
            var json = jsonDecode((event as File).readAsStringSync());
            return AppDocumentFile(event.path, json);
          } catch (e) {
            return null;
          }
        })
        .where((event) => event != null)
        .map((event) => event!)
        .toList();

    return files;
  }

  @override
  Future<bool> hasDocument(String name) async {
    return File('${(await getDirectory()).path}/$name.json').exists();
  }

  @override
  Future<AppDocumentFile> updateDocument(
      String path, AppDocument document) async {
    var file = File(path);
    if (!(await file.exists())) {
      file.create(recursive: true);
    }
    await file.writeAsString(jsonEncode(document.toJson()));

    return AppDocumentFile(path, document.toJson());
  }

  Future<Directory> getDirectory() async {
    var prefs = await SharedPreferences.getInstance();
    String? path;
    if (prefs.containsKey('document_path')) {
      path = prefs.getString('document_path');
    }
    if (path == '') {
      path = null;
    }
    path ??= (await getApplicationDocumentsDirectory()).path +
        '/Butterfly-Documents';
    var directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create();
    }
    return directory;
  }
}
