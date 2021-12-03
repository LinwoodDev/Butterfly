import 'package:butterfly/models/document.dart';
import 'package:idb_shim/idb.dart';
import 'package:idb_shim/idb_browser.dart';

import 'file_system.dart';

class WebDocumentFileSystem extends DocumentFileSystem {
  Future<Database> _getDatabase() async {
    var idbFactory = getIdbFactory()!;
    return await idbFactory.open('butterfly.db', version: 2,
        onUpgradeNeeded: (VersionChangeEvent event) async {
      Database db = event.database;
      if (event.oldVersion < 1) {
        db.createObjectStore('documents');
      }
      if (event.oldVersion < 2) {
        var txn = db.transaction('documents', 'readwrite');
        var store = txn.objectStore('documents');
        var cursor = store.openCursor();
        await Future.wait(await cursor.map<Future<dynamic>>((cursor) async {
          // Add type to each document
          var doc = cursor.value as Map<dynamic, dynamic>;
          doc['type'] = 'document';
          await store.put(doc);
        }).toList());
      }
    });
  }

  @override
  Future<AppDocumentFile> importDocument(AppDocument document,
      {String path = '/'}) async {
    // Remove leading slash
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    var filePath = '$path/${convertNameToFile(document.name)}';
    var counter = 1;
    while (await hasAsset(filePath)) {
      filePath = '${document.name}_${++counter}';
    }
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readwrite');
    var doc = document.toJson();
    doc['type'] = 'file';
    var store = txn.objectStore('documents');
    await store.add(doc, filePath);
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
    // Remove leading slash
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readonly');
    var store = txn.objectStore('documents');
    var data = await store.getObject(path);
    await txn.completed;
    if (data == null) {
      return null;
    }
    var map = Map<String, dynamic>.from(data as Map<dynamic, dynamic>);
    if (map['type'] == 'directory') {
      var assets = <AppDocumentAsset>[];
      // Test if keys starts with path
      var keys = await store.getAllKeys();
      for (var key in keys) {
        if (key.toString().startsWith(path)) {
          var asset = await getAsset(key.toString());
          if (asset != null) {
            assets.add(asset);
          }
        }
      }
      // Sort assets, AppDocumentDirectory should be first, AppDocumentFile should be sorted by name
      assets.sort((a, b) => a is AppDocumentDirectory
          ? -1
          : (a as AppDocumentFile).name.compareTo(
              b is AppDocumentDirectory ? '' : (b as AppDocumentFile).name));
      return AppDocumentDirectory(path, assets);
    } else if (map['type'] == 'file') {
      return AppDocumentFile(path, map);
    }
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
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readwrite');
    var store = txn.objectStore('documents');
    var doc = document.toJson();
    doc['type'] = 'file';
    await store.put(doc, path);
    await txn.completed;
    return AppDocumentFile(path, doc);
  }

  @override
  Future<AppDocumentDirectory> createDirectory(String name) async {
    var db = await _getDatabase();
    var txn = db.transaction('documents', 'readwrite');
    var store = txn.objectStore('documents');
    store.add({'type': 'directory'}, name);
    await txn.completed;
    return AppDocumentDirectory(name, const []);
  }
}
