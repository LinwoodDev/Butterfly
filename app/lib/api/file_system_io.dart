import 'dart:convert';
import 'dart:io';

import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:path_provider/path_provider.dart';

import 'file_system.dart';

class IODocumentFileSystem extends DocumentFileSystem {
  @override
  Future<AppDocumentFile> createDocument(String name,
      {List<ColorPalette> palettes = const []}) async {
    var dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/$name.json');
    file = await file.create();

    return AppDocumentFile(
        file.path,
        AppDocument(name: name, createdAt: DateTime.now(), palettes: palettes)
            .toJson());
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
    var dir = await getApplicationDocumentsDirectory();
    var files = await dir
        .list()
        .where((event) => event is File)
        .where((event) => event.path.endsWith('.json'))
        .map((event) {
      var json = jsonDecode((event as File).readAsStringSync());
      return AppDocumentFile(event.path, AppDocument.fromJson(json).toJson());
    }).toList();

    return files;
  }

  @override
  Future<bool> hasDocument(String name) async {
    return File('${(await getApplicationDocumentsDirectory()).path}/$name.json')
        .exists();
  }

  @override
  Future<AppDocumentFile> updateDocument(
      String path, AppDocument document) async {
    var file = File(path);
    await file.writeAsString(jsonEncode(document.toJson()));

    return AppDocumentFile(path, document.toJson());
  }
}
