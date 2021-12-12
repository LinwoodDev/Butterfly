import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:butterfly/models/document.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file_system.dart';

class IODocumentFileSystem extends DocumentFileSystem {
  @override
  Future<AppDocumentFile> importDocument(AppDocument document,
      {String path = '/'}) async {
    // Add leading slash
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    var encodedName = convertNameToFile(document.name);
    var name = encodedName;
    var counter = 1;
    while (await hasAsset(name)) {
      name = convertNameToFile('${document.name}_${++counter}');
    }
    var file = File('${await getDirectory()}$path/$name');
    file = await file.create(recursive: true);
    await file.writeAsString(json.encode(document.toJson()));
    return AppDocumentFile(
        path == '/' ? '/$name' : '$path/$name', document.toJson());
  }

  @override
  Future<void> deleteAsset(String path) async {
    var absolutePath = await getAbsolutePath(path);
    var file = File(absolutePath);
    var dir = Directory(absolutePath);
    if (await file.exists()) {
      await file.delete();
    } else if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  @override
  Future<AppDocumentAsset?> getAsset(String path) async {
    // Add leading slash
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    var absolutePath = await getAbsolutePath(path);
    // Test if path is a file
    var file = File(absolutePath);
    // Test if path is a directory
    var directory = Directory(absolutePath);
    if (await file.exists()) {
      var json = await file.readAsString();
      return AppDocumentFile(path, jsonDecode(json));
    } else if (await directory.exists()) {
      var files = await directory.list().toList();
      var assets = <AppDocumentAsset>[];
      for (var file in files) {
        try {
          var currentPath =
              path + '/' + file.path.replaceAll('\\', '/').split('/').last;
          if (currentPath.startsWith('//')) {
            currentPath = currentPath.substring(1);
          }
          var asset = await getAsset(currentPath);
          if (asset != null) {
            assets.add(asset);
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
      // Sort assets, AppDocumentDirectory should be first, AppDocumentFile should be sorted by name
      assets.sort((a, b) => a is AppDocumentDirectory
          ? -1
          : (a as AppDocumentFile).name.compareTo(
              b is AppDocumentDirectory ? '' : (b as AppDocumentFile).name));

      return AppDocumentDirectory(path, assets);
    }
  }

  @override
  Future<bool> hasAsset(String path) async {
    return File(await getAbsolutePath(path)).exists();
  }

  @override
  Future<AppDocumentFile> updateDocument(
      String path, AppDocument document) async {
    var file = File(await getAbsolutePath(path));
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
    await file.writeAsString(jsonEncode(document.toJson()));

    return AppDocumentFile(path, document.toJson());
  }

  @override
  FutureOr<String> getDirectory() async {
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
    // Convert \ to /
    path = path.replaceAll('\\', '/');
    var directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create();
    }
    return directory.path;
  }

  @override
  Future<AppDocumentDirectory> createDirectory(String name) async {
    var dir = Directory(await getAbsolutePath(name));
    if (!(await dir.exists())) {
      await dir.create(recursive: true);
    }
    var assets = <AppDocumentAsset>[];
    var files = await dir.list().toList();
    for (var file in files) {
      var asset = await getAsset(
          name + '/' + file.path.replaceAll('\\', '/').split('/').last);
      if (asset != null) {
        assets.add(asset);
      }
    }
    return AppDocumentDirectory(name, assets);
  }
}
