import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idb_shim/idb.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Uint8List _encode(NoteData data) => Uint8List.fromList(data.exportAsBytes());
NoteData _decode(Uint8List data) => NoteData.fromData(data);

Uint8List _encodeFile(NoteFile file) => file.data;
NoteFile _decodeFile(Uint8List data) => NoteFile(data);

const butterflySubDirectory = '/Linwood/Butterfly';

String? overrideButterflyDirectory;

Future<String> getButterflyDirectory({bool usePrefs = true}) async {
  var directory = overrideButterflyDirectory;
  if (directory != null) return directory;
  String? path;
  if (usePrefs) {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('document_path')) {
      path = prefs.getString('document_path');
    }
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
  path += butterflySubDirectory;
  return path;
}

Future<String> Function(ExternalStorage? storage) _getRemoteDirectory(
  String subDirectory,
) => (storage) async {
  var path = await getButterflyDirectory();
  if (storage != null) {
    final bytes = utf8.encode(storage.identifier);
    final directory = base64.encode(bytes);
    path += '/Remotes/$directory';
  }
  path += '/$subDirectory';
  return path;
};

Future<String> getButterflyDocumentsDirectory([ExternalStorage? storage]) =>
    _getRemoteDirectory('Documents')(storage);
typedef DocumentFileSystem = TypedDirectoryFileSystem<NoteFile>;
typedef TemplateFileSystem = TypedKeyFileSystem<NoteData>;
typedef PackFileSystem = TypedKeyFileSystem<NoteData>;

final PasswordStorage passwordStorage = SecureStoragePasswordStorage();

class ButterflyFileSystem {
  final BuildContext context;
  final SettingsCubit settingsCubit;
  final FileSystemConfig _documentConfig, _templateConfig, _packConfig;

  ButterflyFileSystem(this.context, this.settingsCubit)
    : _documentConfig = FileSystemConfig(
        passwordStorage: passwordStorage,
        storeName: 'documents',
        variant: 'documents',
        getDirectory: getButterflyDocumentsDirectory,
        database: _database,
        databaseVersion: _databaseVersion,
        onDatabaseUpgrade: _upgradeDatabase,
      ),
      _templateConfig = FileSystemConfig(
        passwordStorage: passwordStorage,
        storeName: 'templates',
        variant: 'templates',
        getDirectory: _getRemoteDirectory('Templates'),
        database: _database,
        databaseVersion: _databaseVersion,
        onDatabaseUpgrade: _upgradeDatabase,
        defaultStorageKey: 'defaultTemplate',
      ),
      _packConfig = FileSystemConfig(
        passwordStorage: passwordStorage,
        storeName: 'packs',
        variant: 'packs',
        getDirectory: _getRemoteDirectory('Packs'),
        database: _database,
        databaseVersion: _databaseVersion,
        onDatabaseUpgrade: _upgradeDatabase,
        defaultStorageKey: 'defaultPack',
      );

  factory ButterflyFileSystem.build(BuildContext context) =>
      ButterflyFileSystem(context, context.read<SettingsCubit>());

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
      await Future.wait(
        await cursor.map<Future<dynamic>>((cursor) async {
          // Add type to each document
          var doc = cursor.value as Map<dynamic, dynamic>;
          doc['type'] = 'document';
          await store.put(doc);
        }).toList(),
      );
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
      await Future.wait(
        await cursor.map<Future<dynamic>>((cursor) async {
          final value = cursor.value;
          if (value is! Map) return value;
          var type = value['type'];
          if (type != 'document') return value;
          final data = utf8.encode(jsonEncode(value));
          return {'type': 'document', 'data': data};
        }).toList(),
      );
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
        }).toList(),
      );
      await txn.completed;
    }
  }

  Future<void> _createDefaultTemplates(TemplateFileSystem fs) async =>
      Future.wait(
        (await DocumentDefaults.getDefaults(
          context,
        )).map((e) => fs.createFile('${e.name}.bfly', e)),
      );

  Future<void> _createDefaultPacks(PackFileSystem fs) async {
    final pack = await DocumentDefaults.getCorePack();
    await fs.createFile('${pack.name}.bfly', pack);
  }

  TypedDirectoryFileSystem<NoteFile> buildDocumentSystem([
    ExternalStorage? storage,
  ]) => TypedDirectoryFileSystem.build(
    _documentConfig,
    onEncode: _encodeFile,
    onDecode: _decodeFile,
    storage: storage,
    useIsolates: true,
  );
  TypedKeyFileSystem<NoteData> buildTemplateSystem([
    ExternalStorage? storage,
  ]) => TypedKeyFileSystem.build(
    _templateConfig,
    onEncode: _encode,
    onDecode: _decode,
    storage: storage,
    createDefault: _createDefaultTemplates,
  );
  TypedKeyFileSystem<NoteData> buildPackSystem([ExternalStorage? storage]) =>
      TypedKeyFileSystem.build(
        _packConfig,
        onEncode: _encode,
        onDecode: _decode,
        storage: storage,
        createDefault: _createDefaultPacks,
      );

  DocumentFileSystem buildDefaultDocumentSystem() =>
      buildDocumentSystem(settingsCubit.state.getDefaultRemote());

  Map<String, DocumentFileSystem> buildAllDocumentSystems({
    bool includeLocal = true,
  }) {
    final map = <String, DocumentFileSystem>{};
    if (includeLocal) {
      map[''] = buildDocumentSystem();
    }
    for (final remote in settingsCubit.state.connections) {
      map[remote.identifier] = buildDocumentSystem(remote);
    }
    return map;
  }

  TemplateFileSystem buildDefaultTemplateSystem() =>
      buildTemplateSystem(settingsCubit.state.getDefaultRemote());

  PackFileSystem buildDefaultPackSystem() =>
      buildPackSystem(settingsCubit.state.getDefaultRemote());

  Future<PackItem<T>?> findPack<T extends PackAsset>(
    NamedItem<T>? Function(NoteData) test, [
    ExternalStorage? storage,
  ]) async {
    final files = await buildPackSystem(storage).getFiles();
    for (final file in files) {
      final pack = file.data!;
      final palette = test(pack);
      if (palette == null) continue;
      final name = file.pathWithoutLeadingSlash;
      return palette.toPack(pack, name);
    }
    return null;
  }

  Future<PackItem<text.TextStyleSheet>?> findDefaultStyleSheet([
    ExternalStorage? storage,
  ]) => findPack((pack) => pack.getNamedStyles().firstOrNull, storage);
  Future<PackItem<ColorPalette>?> findDefaultPalette([
    ExternalStorage? storage,
  ]) => findPack((pack) => pack.getNamedPalettes().firstOrNull, storage);

  Future<void> updatePack(PackAssetLocation location, NoteData newPack) =>
      buildPackSystem(
        location.namespace.isEmpty
            ? null
            : settingsCubit.state.getRemote(location.namespace),
      ).updateFile(location.key, newPack);
}
