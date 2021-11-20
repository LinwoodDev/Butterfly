import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:idb_shim/idb_browser.dart';

import 'file_system.dart';

class WebDocumentFileSystem extends DocumentFileSystem {
  @override
  Future<AppDocumentFile> createDocument(String name,
      {List<ColorPalette> palettes = const []}) async {
    var idbFactory = getIdbFactory();
    var db = await idbFactory?.open('butterfly');
    var txn = db?.transaction('documents', 'readwrite');
    var store = txn?.objectStore('documents');
    var doc =
        AppDocument(name: name, createdAt: DateTime.now(), palettes: palettes)
            .toJson();
    await store?.add(doc, name);
    await txn?.completed;
    return AppDocumentFile(name, doc);
  }

  @override
  Future<void> deleteDocument(String path) async {
    var idbFactory = getIdbFactory();
    var db = await idbFactory?.open('butterfly');
    var txn = db?.transaction('documents', 'readwrite');
    var store = txn?.objectStore('documents');
    var deleted = await store?.delete(path);
    await txn?.completed;
    return deleted;
  }

  @override
  Future<AppDocumentFile?> getDocument(String path) async {
    var idbFactory = getIdbFactory();
    var db = await idbFactory?.open('butterfly');
    var txn = db?.transaction('documents', 'readonly');
    var store = txn?.objectStore('documents');
    var doc = await store?.getObject(path);
    await txn?.completed;
    return AppDocumentFile(path, doc as Map<String, dynamic>);
  }

  @override
  Future<List<AppDocumentFile>> getDocuments() async {
    var idbFactory = getIdbFactory();
    var db = await idbFactory?.open('butterfly');
    var txn = db?.transaction('documents', 'readonly');
    var store = txn?.objectStore('documents');
    var docs = await store?.getAll();
    await txn?.completed;
    return docs?.map((doc) {
          return AppDocumentFile((doc as Map<String, dynamic>)['name'], doc);
        }).toList() ??
        [];
  }

  @override
  Future<bool> hasDocument(String name) async {
    var idbFactory = getIdbFactory();
    var db = await idbFactory?.open('butterfly');
    var txn = db?.transaction('documents', 'readonly');
    var store = txn?.objectStore('documents');
    var doc = await store?.getObject(name);
    await txn?.completed;
    return doc != null;
  }

  @override
  Future<AppDocumentFile> updateDocument(
      String path, AppDocument document) async {
    var idbFactory = getIdbFactory();
    var db = await idbFactory?.open('butterfly');
    var txn = db?.transaction('documents', 'readwrite');
    var store = txn?.objectStore('documents');
    var doc = await store?.put(document.toJson(), path);
    await txn?.completed;
    return AppDocumentFile(path, doc as Map<String, dynamic>);
  }
}
