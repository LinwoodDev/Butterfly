// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js_util';

import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
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
  external LaunchQueue? get launchQueue;
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
  external Object getFile();
}

Database? _db;
Future<Database> _getDatabase() async {
  if (_db != null) return _db!;
  var idbFactory = getIdbFactory()!;
  _db = await idbFactory.open('butterfly.db', version: 4,
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
    if (event.oldVersion < 4) {
      var txn = event.transaction;
      var store = txn.objectStore('templates');
      var cursor = store.openCursor();
      await Future.wait(await cursor.map<Future<dynamic>>((cursor) async {
        final value = cursor.value;
        if (value is! Map) return value;
        var type = value['type'];
        if (type != 'document') return value;
        final data = utf8.encode(jsonEncode(value));
        return {'type': 'document', 'data': data};
      }).toList());
      db.createObjectStore('packs');
      db.createObjectStore('documents-data');
      var documentStore = txn.objectStore('documents');
      await Future.wait(
          await documentStore.openCursor().map<Future<dynamic>>((cursor) async {
        var doc = cursor.value as Map<dynamic, dynamic>;
        var data = doc['data'];
        if (data is! String) return;
        var path = cursor.key as String;
        var dataStore = txn.objectStore('documents-data');
        await dataStore.put(data, path);
        doc['data'] = null;
        await documentStore.put(doc, path);
      }).toList());
      await txn.completed;
    }
  });
  return _db!;
}

class WebDocumentFileSystem extends DocumentFileSystem {
  @override
  Future<void> deleteAsset(String path) async {
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readwrite');
    var store = txn.objectStore('documents');
    var data = await store.getObject(path) as Map<dynamic, dynamic>?;
    await store.delete(path);
    var dataStore = txn.objectStore('documents-data');
    await dataStore.delete(path);
    if (data?['type'] == 'directory') {
      // delete all where key starts with path
      var cursor = store.openCursor();
      await cursor.forEach((cursor) {
        if (cursor.key.toString().startsWith(path)) {
          deleteAsset(cursor.key.toString());
        }
      });
    }
    await txn.completed;
  }

  @override
  Future<AppDocumentEntity?> getAsset(String path) async {
    // Add leading slash
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    if (path == '//') {
      path = '/';
    }
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readonly');

    Future<List<int>> getData(String path) async {
      final dataStore = txn.objectStore('documents-data');
      final data = await dataStore.getObject(path);
      return data as List<int>;
    }

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
      final file =
          AppDocumentFile(AssetLocation.local(path), await getData(path));
      await txn.completed;
      return file;
    } else if (map['type'] == 'directory') {
      var cursor = store.openCursor(autoAdvance: true);
      var assets = await Future.wait(
              await cursor.map<Future<AppDocumentEntity?>>((cursor) async {
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
                AssetLocation.local(key), await getData(key));
          } else if (data['type'] == 'directory') {
            return AppDocumentDirectory(AssetLocation.local(key), const []);
          }
          return null;
        }
        return null;
      }).toList())
          .then((value) => value.whereType<AppDocumentEntity>().toList());
      // Sort assets, AppDocumentDirectory should be first, AppDocumentFile should be sorted by name
      assets.sort((a, b) => a is AppDocumentDirectory
          ? -1
          : (a as AppDocumentFile).fileName.compareTo(b is AppDocumentDirectory
              ? ''
              : (b as AppDocumentFile).fileName));
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
  Future<AppDocumentFile> updateFile(String path, List<int> data) async {
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
    final db = await _getDatabase();
    final txn = db.transaction('documents', 'readwrite');
    final store = txn.objectStore('documents');
    await store.put({
      'type': 'file',
    }, path);
    final dataStore = txn.objectStore('documents-data');
    await dataStore.put(data, path);
    await txn.completed;
    return AppDocumentFile(AssetLocation.local(path), data);
  }

  @override
  Future<AppDocumentDirectory> createDirectory(String path) async {
    // Remove leading slash
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readwrite');
    var store = txn.objectStore('documents');
    final parents = path.split('/');
    String last = '/';
    if (parents.length <= 1) return await getRootDirectory();
    for (var current in parents.sublist(1)) {
      final data = {'type': 'directory'};
      final currentPath = '$last$current';
      await store.put(data, currentPath);
      last = '$currentPath/';
    }
    await txn.completed;
    return AppDocumentDirectory(AssetLocation.local(path), const []);
  }

  FileSystemHandle? _fs;

  @override
  Future<Uint8List?> loadAbsolute(String path) async {
    try {
      final fileWindow = html.window as FileHandlingWindow;
      final completer = Completer<Uint8List?>();
      void complete(LaunchParams launchParams) async {
        final files = launchParams.files.cast<FileSystemHandle>();
        if (files.isEmpty) {
          completer.complete(null);
          return;
        }
        _fs = files.first;
        final file = await promiseToFuture(_fs!.getFile());
        final reader = html.FileReader();
        reader.onLoad.listen((_) {
          try {
            final result = reader.result as Uint8List;
            completer.complete(Uint8List.fromList(result));
          } catch (e) {
            completer.completeError(e);
          }
        });
        reader.onError.listen((_) {
          final error = reader.error;
          if (error != null) {
            completer.completeError(error);
          } else {
            completer.complete(null);
          }
        });
        reader.readAsArrayBuffer(file);
      }

      fileWindow.launchQueue?.setConsumer(allowInterop(complete));
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
    return const TemplateJsonConverter().fromJson(map);
  }

  @override
  Future<void> updateTemplate(DocumentTemplate template) async {
    var db = await _getDatabase();
    var txn = db.transaction('templates', 'readwrite');
    var store = txn.objectStore('templates');
    var doc = const TemplateJsonConverter().toJson(template);
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
    var defaults = await DocumentDefaults.getDefaults(context);
    var prefs = await SharedPreferences.getInstance();
    if (!force) {
      force = !prefs.containsKey('defaultTemplate');
    }
    if (!force) return false;
    await Future.wait(defaults.map((e) => createTemplate(e)));
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
        templates.add(const TemplateJsonConverter()
            .fromJson(Map<String, dynamic>.from(map)));
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

class WebPackFileSystem extends PackFileSystem {
  @override
  Future<void> deletePack(String name) async {
    var db = await _getDatabase();
    var txn = db.transaction('packs', 'readwrite');
    var store = txn.objectStore('packs');
    await store.delete(name);
    await txn.completed;
  }

  @override
  Future<ButterflyPack?> getPack(String name) async {
    var db = await _getDatabase();
    var txn = db.transaction('packs', 'readonly');
    var store = txn.objectStore('packs');
    var data = await store.getObject(name);
    if (data == null) {
      await txn.completed;
      return null;
    }
    var map = Map<String, dynamic>.from(data as Map);
    await txn.completed;
    return const PackJsonConverter().fromJson(map);
  }

  @override
  Future<void> updatePack(ButterflyPack pack) async {
    var db = await _getDatabase();
    var txn = db.transaction('packs', 'readwrite');
    var store = txn.objectStore('packs');
    var doc = const PackJsonConverter().toJson(pack);
    await store.put(doc, pack.name);
  }

  @override
  Future<bool> hasPack(String name) async {
    var db = await _getDatabase();
    var txn = db.transaction('packs', 'readonly');
    var store = txn.objectStore('packs');
    var doc = await store.getObject(name);
    await txn.completed;
    return doc != null;
  }

  @override
  Future<List<ButterflyPack>> getPacks() async {
    var db = await _getDatabase();
    var txn = db.transaction('packs', 'readonly');
    var store = txn.objectStore('packs');
    var cursor = store.openCursor(autoAdvance: true);
    var packs = <ButterflyPack>[];
    await cursor.forEach((cursor) {
      try {
        var map = cursor.value as Map;
        packs.add(
            const PackJsonConverter().fromJson(Map<String, dynamic>.from(map)));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
    await txn.completed;
    return packs;
  }

  @override
  Future<bool> createDefault(BuildContext context, {bool force = false}) async {
    var prefs = await SharedPreferences.getInstance();
    if (!force) {
      force = !prefs.containsKey('defaultPack');
    }
    if (!force) return false;
    final pack = await DocumentDefaults.getCorePack();
    await createPack(pack);
    prefs.setBool('defaultPack', true);
    return true;
  }
}
