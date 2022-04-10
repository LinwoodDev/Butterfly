import 'dart:async';
import 'dart:convert';

import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/template.dart';
import 'package:flutter/widgets.dart';
import 'package:idb_shim/idb.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file_system.dart';

Future<Database> _getDatabase() async {
  var idbFactory = getIdbFactory()!;
  return await idbFactory.open('butterfly.db', version: 3,
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
    var filePath = '$path/${convertNameToFile(document.name)}';
    var counter = 2;
    while (await hasAsset(filePath)) {
      filePath = '$path/${convertNameToFile(document.name)}_$counter';
      counter++;
    }
    var db = await _getDatabase();
    var doc =
        Map<String, dynamic>.from(jsonDecode(jsonEncode(document.toJson())));
    doc['type'] = 'file';
    var txn = db.transaction('documents', 'readwrite');
    var store = txn.objectStore('documents');
    await store.put(doc, filePath);
    await txn.completed;
    return AppDocumentFile(filePath, doc);
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
      return AppDocumentFile(path, map);
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
            return AppDocumentFile(key, Map<String, dynamic>.from(data));
          } else if (data['type'] == 'directory') {
            return AppDocumentDirectory(key, const []);
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
      return AppDocumentDirectory(path, assets.toList());
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
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readwrite');
    var store = txn.objectStore('documents');
    var doc = jsonDecode(jsonEncode(document.toJson()));
    doc['type'] = 'file';
    await store.put(doc, path);
    await txn.completed;
    return AppDocumentFile(path, doc);
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
    store.add({'type': 'directory'}, name);
    await txn.completed;
    return AppDocumentDirectory(name, const []);
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
    var doc = jsonDecode(jsonEncode(template.toJson()));
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
    var prefs = await SharedPreferences.getInstance();
    if (!shouldCreate) {
      shouldCreate = !prefs.containsKey('defaultTemplate');
    }
    if (!shouldCreate) return false;
    var defaults = DocumentTemplate.getDefaults(context);
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
      var map = cursor.value as Map;
      templates.add(DocumentTemplate.fromJson(Map<String, dynamic>.from(map)));
    });
    await txn.completed;
    return templates;
  }
}
