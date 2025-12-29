import 'dart:async';
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
  path = path.replaceAll('\\', '/');
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

  final _documentCache = <String, DocumentFileSystem>{};
  final _templateCache = <String, TemplateFileSystem>{};
  final _packCache = <String, PackFileSystem>{};

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
      ) {
    _listenSettings();
  }

  void _listenSettings() {
    var previousState = settingsCubit.state;
    settingsCubit.stream.listen((state) {
      if (state == previousState) return;
      final previousRemotes = previousState.connections.toSet();
      final currentRemotes = state.connections.toSet();
      final removedRemotes = previousRemotes.difference(currentRemotes);
      for (final remote in removedRemotes) {
        removeCachedFileSystem(remote);
      }
      if (previousState.documentPath != state.documentPath) {
        removeCachedFileSystem(null);
      }
      previousState = state;
    });
  }

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

  Future<void> _createDefaultPacks(PackFileSystem fs) async {
    final pack = await DocumentDefaults.getCorePack();
    await fs.createFile('${pack.name}.bfly', pack);
  }

  String _cacheKey(ExternalStorage? storage) => storage?.identifier ?? 'local';

  TypedDirectoryFileSystem<NoteFile> buildDocumentSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) {
    final key = _cacheKey(storage);
    if (!forceRecreate) {
      final cached = _documentCache[key];
      if (cached != null) return cached;
    }
    final system = TypedDirectoryFileSystem.build(
      _documentConfig,
      onEncode: _encodeFile,
      onDecode: _decodeFile,
      storage: storage,
      useIsolates: true,
    );
    _documentCache[key] = system;
    return system;
  }

  TypedKeyFileSystem<NoteData> buildTemplateSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) {
    final key = _cacheKey(storage);
    if (!forceRecreate) {
      final cached = _templateCache[key];
      if (cached != null) return cached;
    }
    final system = TypedKeyFileSystem.build(
      _templateConfig,
      onEncode: _encode,
      onDecode: _decode,
      storage: storage,
    );
    _templateCache[key] = system;
    return system;
  }

  TypedKeyFileSystem<NoteData> buildPackSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) {
    final key = _cacheKey(storage);
    if (!forceRecreate) {
      final cached = _packCache[key];
      if (cached != null) return cached;
    }
    final system = TypedKeyFileSystem.build(
      _packConfig,
      onEncode: _encode,
      onDecode: _decode,
      storage: storage,
      createDefault: _createDefaultPacks,
    );
    _packCache[key] = system;
    return system;
  }

  DocumentFileSystem buildDefaultDocumentSystem({bool forceRecreate = false}) =>
      buildDocumentSystem(
        settingsCubit.state.getDefaultRemote(),
        forceRecreate,
      );

  Map<String, DocumentFileSystem> buildAllDocumentSystems({
    bool includeLocal = true,
    bool forceRecreate = false,
  }) {
    final map = <String, DocumentFileSystem>{};
    if (includeLocal) {
      map[''] = buildDocumentSystem(null, forceRecreate);
    }
    for (final remote in settingsCubit.state.connections) {
      map[remote.identifier] = buildDocumentSystem(remote, forceRecreate);
    }
    return map;
  }

  TemplateFileSystem buildDefaultTemplateSystem({bool forceRecreate = false}) =>
      buildTemplateSystem(
        settingsCubit.state.getDefaultRemote(),
        forceRecreate,
      );

  PackFileSystem buildDefaultPackSystem({bool forceRecreate = false}) =>
      buildPackSystem(settingsCubit.state.getDefaultRemote(), forceRecreate);

  Future<PackItem<T>?> findPack<T extends PackAsset>(
    NamedItem<T>? Function(NoteData) test, [
    ExternalStorage? storage,
  ]) async {
    final system = buildPackSystem(storage);
    await system.initialize();
    final files = await system.getFiles();
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

  void removeCachedDocumentSystem(ExternalStorage? storage) {
    final key = _cacheKey(storage);
    _documentCache.remove(key);
  }

  void removeCachedTemplateSystem(ExternalStorage? storage) {
    final key = _cacheKey(storage);
    _templateCache.remove(key);
  }

  void removeCachedPackSystem(ExternalStorage? storage) {
    final key = _cacheKey(storage);
    _packCache.remove(key);
  }

  void removeCachedFileSystem(ExternalStorage? storage) {
    removeCachedDocumentSystem(storage);
    removeCachedTemplateSystem(storage);
    removeCachedPackSystem(storage);
  }
}
