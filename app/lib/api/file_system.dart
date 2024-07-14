import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/visualizer/connection.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:idb_shim/idb.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Uint8List _encode(NoteData data) => Uint8List.fromList(data.save());
NoteData _decode(Uint8List data) => NoteData.fromData(data);

const butterflySubDirectory = '/Linwood/Butterfly';

String? overrideButterflyDirectory;

Future<String> getButterflyDirectory({bool root = false}) async {
  var directory = overrideButterflyDirectory;
  if (directory != null) return directory;
  var prefs = await SharedPreferences.getInstance();
  String? path;
  if (prefs.containsKey('document_path')) {
    path = prefs.getString('document_path');
  }
  if (path == '') {
    path = null;
  }
  if (path != null) {
    return path;
  }
  if (Platform.isAndroid) {
    if (path != null) {
      path = Uri.tryParse(path)?.toFilePath();
    }
    path ??= (await getExternalStorageDirectory())?.path;
  }
  path ??= (await getApplicationDocumentsDirectory()).path;
  if (!root) path += butterflySubDirectory;
  return path;
}

Future<String> Function(ExternalStorage? storage) _getRemoteDirectory(
        String subDirectory) =>
    (storage) async {
      var path = await getButterflyDirectory();
      if (storage != null) {
        final bytes = utf8.encode(storage.identifier);
        final directory = base64.encode(bytes);
        path += '/Remotes/$directory';
      }
      path += subDirectory;
      return path;
    };

Future<String> getButterflyDocumentsDirectory([ExternalStorage? storage]) =>
    _getRemoteDirectory('Documents')(storage);

class ButterflyFileSystem {
  final BuildContext context;

  ButterflyFileSystem(this.context);

  static final _passwordStorage = SecureStoragePasswordStorage();
  static const _database = 'butterfly.db';
  static const _databaseVersion = 4;

  static Future<void> _upgradeDatabase(VersionChangeEvent event) async {
    final db = event.database;
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
      db.createObjectStore('packs');
      db.createObjectStore('documents-data');
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
  }

  static final _documentConfig = FileSystemConfig(
    passwordStorage: _passwordStorage,
    storeName: 'documents',
    variant: '',
    getDirectory: getButterflyDocumentsDirectory,
    database: _database,
    databaseVersion: _databaseVersion,
    onDatabaseUpgrade: _upgradeDatabase,
  );
  static final _templateConfig = FileSystemConfig(
    passwordStorage: _passwordStorage,
    storeName: 'templates',
    variant: '',
    getDirectory: _getRemoteDirectory('Templates'),
    database: _database,
    databaseVersion: _databaseVersion,
    onDatabaseUpgrade: _upgradeDatabase,
  );
  static final _packConfig = FileSystemConfig(
    passwordStorage: _passwordStorage,
    storeName: 'packs',
    variant: '',
    getDirectory: _getRemoteDirectory('Packs'),
    database: _database,
    databaseVersion: _databaseVersion,
    onDatabaseUpgrade: _upgradeDatabase,
  );

  void _createDefaultTemplates(TypedKeyFileSystem<NoteData> fs) async =>
      Future.wait((await DocumentDefaults.getDefaults(context))
          .map((e) => fs.createFile(e.getMetadata()?.name ?? '', e)));

  void _createDefaultPacks(TypedKeyFileSystem<NoteData> fs) async {
    final pack = await DocumentDefaults.getCorePack();
    fs.createFile(fs.getLocalizedName(context), pack);
  }

  TypedDirectoryFileSystem<NoteData> buildDocumentsSystem(
          [ExternalStorage? storage]) =>
      TypedDirectoryFileSystem.build(
        _documentConfig,
        onEncode: _encode,
        onDecode: _decode,
        storage: storage,
      );
  TypedKeyFileSystem<NoteData> buildTemplatesSystem(
          [ExternalStorage? storage]) =>
      TypedKeyFileSystem.build(
        _templateConfig,
        onEncode: _encode,
        onDecode: _decode,
        storage: storage,
        createDefault: _createDefaultTemplates,
      );
  TypedKeyFileSystem<NoteData> buildPacksSystem([ExternalStorage? storage]) =>
      TypedKeyFileSystem.build(
        _packConfig,
        onEncode: _encode,
        onDecode: _decode,
        storage: storage,
        createDefault: _createDefaultPacks,
      );
}
