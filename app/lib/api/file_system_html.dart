// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:idb_shim/idb.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:js/js.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file_system.dart';

@JS()
@staticInterop
class FileHandlingWindow {}

extension FileHandlingWindowExtension on FileHandlingWindow {
  external LaunchQueue get launchQueue;
}

@JS()
class LaunchQueue {
  external void setConsumer(void Function(LaunchParams) f);
}

@JS()
class LaunchParams {
  @JS('files')
  external List get files;
}

@JS()
class FileSystemHandle {
  external Future getFile();
}

@JS()
class FileWithRead {
  external Future text();
}

Database? _db;
Future<Database> _getDatabase() async {
  if (_db != null) return _db!;
  var idbFactory = getIdbFactory()!;
  _db = await idbFactory.open('butterfly.db', version: 3,
      onUpgradeNeeded: (VersionChangeEvent event) async {
    Database db = event.database;
    if (event.oldVersion < 1) {
      db.createObjectStore('documents');
    }
    if (event.oldVersion < 2) {
      var txn = event.transaction;
      var store = txn.objectStore('documents');
      var cursor = store.openCursor();
      await Future.wait(await cursor.map<Future<dynamic>>((cursor) async {
        // Add type to each document
        var doc = cursor.value as Map<dynamic, dynamic>;
        doc['type'] = 'document';
        await store.put(doc);
      }).toList());
    }
    if (event.oldVersion < 3) {
      db.createObjectStore('templates');
    }
  });
  return _db!;
}

class WebDocumentFileSystem extends DocumentFileSystem {
  @override
  Future<AppDocumentFile> importDocument(AppDocument document,
      {String path = '/'}) async {
    // Add leading slash
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    if (path == '/' || path == '//') {
      path = '';
    }
    // Create directory if it doesn't exist
    await createDirectory(path);
    var filePath = '$path/${convertNameToFile(document.name)}';
    var counter = 2;
    while (await hasAsset(filePath)) {
      filePath = '$path/${convertNameToFile(document.name)}_$counter';
      counter++;
    }
    var doc = Map<String, dynamic>.from(document.toJson());
    doc['type'] = 'file';
    final db = await _getDatabase();
    var txn = db.transaction('documents', 'readwrite');
    var store = txn.objectStore('documents');
    await store.put(doc, filePath);
    await txn.completed;
    return AppDocumentFile(AssetLocation.local(filePath), doc);
  }

  @override
  Future<void> deleteAsset(String path) async {
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readwrite');
    var store = txn.objectStore('documents');
    var data = await store.getObject(path) as Map<dynamic, dynamic>?;
    if (data?['type'] == 'directory') {
      // delete all where key starts with path
      var cursor = store.openCursor();
      await cursor.forEach((cursor) {
        if (cursor.key.toString().startsWith(path)) {
          store.delete(cursor.key);
        }
      });
    }
    await store.delete(path);
    await txn.completed;
  }

  @override
  Future<AppDocumentAsset?> getAsset(String path) async {
    // Add leading slash
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    if (path == '//') {
      path = '/';
    }
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readonly');
    var store = txn.objectStore('documents');
    var data = await store.getObject(path);
    if (path == '/') {
      data = {'type': 'directory'};
    }
    if (data == null) {
      await txn.completed;
      return null;
    }
    var map = Map<String, dynamic>.from(data as Map);
    if (map['type'] == 'file') {
      await txn.completed;
      return AppDocumentFile(AssetLocation.local(path), map);
    } else if (map['type'] == 'directory') {
      var cursor = store.openCursor(autoAdvance: true);
      var assets = await Future.wait(
              await cursor.map<Future<AppDocumentAsset?>>((cursor) async {
        // Add leading slash
        var key = cursor.key.toString();
        if (!key.startsWith('/')) {
          key = '/$key';
        }
        // Is in current directory
        if (key.startsWith(path) &&
            key != path &&
            !key.substring(path.length + 1).contains('/')) {
          var data = cursor.value as Map<dynamic, dynamic>;
          if (data['type'] == 'file') {
            return AppDocumentFile(
                AssetLocation.local(key), Map<String, dynamic>.from(data));
          } else if (data['type'] == 'directory') {
            return AppDocumentDirectory(AssetLocation.local(key), const []);
          }
          return null;
        }
        return null;
      }).toList())
          .then((value) => value.whereType<AppDocumentAsset>().toList());
      // Sort assets, AppDocumentDirectory should be first, AppDocumentFile should be sorted by name
      assets.sort((a, b) => a is AppDocumentDirectory
          ? -1
          : (a as AppDocumentFile).name.compareTo(
              b is AppDocumentDirectory ? '' : (b as AppDocumentFile).name));
      await txn.completed;
      return AppDocumentDirectory(AssetLocation.local(path), assets.toList());
    }
    return null;
  }

  @override
  Future<bool> hasAsset(String path) async {
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readonly');
    var store = txn.objectStore('documents');
    var doc = await store.getObject(path);
    await txn.completed;
    return doc != null;
  }

  @override
  Future<AppDocumentFile> updateDocument(
      String path, AppDocument document) async {
    // Add leading slash
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    // Remove trailing slash
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    final pathWithoutSlash = path.substring(1);
    // Create directory if it doesn't exist
    if (pathWithoutSlash.contains('/')) {
      await createDirectory(
          pathWithoutSlash.substring(0, pathWithoutSlash.lastIndexOf('/')));
    }
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readwrite');
    var store = txn.objectStore('documents');
    var doc = document.toJson();
    doc['type'] = 'file';
    await store.put(doc, path);
    await txn.completed;
    return AppDocumentFile(AssetLocation.local(path), doc);
  }

  @override
  Future<AppDocumentDirectory> createDirectory(String name) async {
    // Remove leading slash
    if (!name.startsWith('/')) {
      name = '/$name';
    }
    if (name.endsWith('/')) {
      name = name.substring(0, name.length - 1);
    }
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readwrite');
    var store = txn.objectStore('documents');
    final parents = name.split('/');
    String last = '/';
    if (parents.length <= 1) return await getRootDirectory();
    for (var current in parents.sublist(1)) {
      final data = {'type': 'directory'};
      final path = '$last$current';
      await store.put(data, path);
      last = '$path/';
    }
    await txn.completed;
    return AppDocumentDirectory(AssetLocation.local(name), const []);
  }

  FileSystemHandle? _fs;

  @override
  Future<Uint8List?> loadAbsolute(String path) async {
    try {
      final fileWindow = html.window as FileHandlingWindow;
      final completer = Completer<Uint8List?>();
      void _complete(LaunchParams launchParams) async {
        final files = launchParams.files.cast<FileSystemHandle>();
        if (files.isEmpty) {
          completer.complete(null);
          return;
        }
        _fs = files.first;
        final file = await _fs?.getFile() as html.File;
        final reader = html.FileReader();
        reader.onLoad.listen((_) {
          completer.complete(reader.result as Uint8List);
        });
        reader.readAsArrayBuffer(file);
      }

      fileWindow.launchQueue.setConsumer(allowInterop(_complete));
      return completer.future;
    } on NoSuchMethodError catch (e) {
      if (kDebugMode) {
        print('File handling feature not supported: $e');
      }

      return null;
    }
  }

  @override
  Future<void> saveAbsolute(String path, Uint8List bytes) async {
    final a = html.document.createElement('a') as html.AnchorElement;
    // Create data URL
    final blob = html.Blob([bytes], 'text/plain');
    final url = html.Url.createObjectUrl(blob);
    a.href = url;
    a.download = path;
    a.click();
  }
}

class WebTemplateFileSystem extends TemplateFileSystem {
  @override
  Future<void> deleteTemplate(String name) async {
    var db = await _getDatabase();
    var txn = db.transaction('templates', 'readwrite');
    var store = txn.objectStore('templates');
    await store.delete(name);
    await txn.completed;
  }

  @override
  Future<DocumentTemplate?> getTemplate(String name) async {
    var db = await _getDatabase();
    var txn = db.transaction('templates', 'readonly');
    var store = txn.objectStore('templates');
    var data = await store.getObject(name);
    if (data == null) {
      await txn.completed;
      return null;
    }
    var map = Map<String, dynamic>.from(data as Map);
    await txn.completed;
    return DocumentTemplate.fromJson(map);
  }

  @override
  Future<void> updateTemplate(DocumentTemplate template) async {
    var db = await _getDatabase();
    var txn = db.transaction('templates', 'readwrite');
    var store = txn.objectStore('templates');
    var doc = template.toJson();
    await store.put(doc, template.name);
  }

  @override
  Future<bool> hasTemplate(String name) async {
    var db = await _getDatabase();
    var txn = db.transaction('templates', 'readonly');
    var store = txn.objectStore('templates');
    var doc = await store.getObject(name);
    await txn.completed;
    return doc != null;
  }

  @override
  Future<bool> createDefault(BuildContext context, {bool force = false}) async {
    var shouldCreate = force;
    var defaults = DocumentTemplate.getDefaults(context);
    var prefs = await SharedPreferences.getInstance();
    if (!shouldCreate) {
      shouldCreate = !prefs.containsKey('defaultTemplate');
    }
    if (!shouldCreate) return false;
    await Future.wait(defaults.map((e) => updateTemplate(e)));
    prefs.setBool('defaultTemplate', true);
    return true;
  }

  @override
  Future<List<DocumentTemplate>> getTemplates() async {
    var db = await _getDatabase();
    var txn = db.transaction('templates', 'readonly');
    var store = txn.objectStore('templates');
    var cursor = store.openCursor(autoAdvance: true);
    var templates = <DocumentTemplate>[];
    await cursor.forEach((cursor) {
      try {
        var map = cursor.value as Map;
        templates
            .add(DocumentTemplate.fromJson(Map<String, dynamic>.from(map)));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
    await txn.completed;
    return templates;
  }
}
