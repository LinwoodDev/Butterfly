import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/services/logger.dart';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:rxdart/subjects.dart';

import '../cubits/settings.dart';

class SyncService {
  final BuildContext context;
  final List<RemoteSync> _syncs = [];
  final ButterflyFileSystem fileSystem;
  final BehaviorSubject<SyncStatus> _statusSubject =
      BehaviorSubject<SyncStatus>();
  Stream<SyncStatus> get statusStream => _statusSubject.stream;
  SyncStatus? get status => _statusSubject.valueOrNull;
  SettingsCubit get settingsCubit => fileSystem.settingsCubit;

  SyncService(this.context, this.fileSystem) {
    settingsCubit.stream.listen(_loadSettings);
    _loadSettings(settingsCubit.state);
  }

  RemoteSync? getSync(String remote) {
    if (kIsWeb) return null;
    var current = _syncs.firstWhereOrNull(
      (sync) => sync.remoteStorage.identifier == remote,
    );
    current ??= _createSync(remote);
    return current;
  }

  RemoteSync? _createSync(String remote) {
    if (kIsWeb) return null;
    final storage = settingsCubit.state.getRemote(remote);
    if (storage == null) {
      talker.warning('Remote storage not found: $remote');
      return null;
    }
    talker.info('Creating sync for remote: $remote');
    final current = RemoteSync(context, fileSystem, storage);
    current.statusStream.listen((status) => _refreshStatus());
    _syncs.add(current);
    current.autoSync();
    return current;
  }

  Future<void> sync() async {
    talker.info('Syncing all remotes');
    if (kIsWeb) return;
    for (final sync in _syncs) {
      await sync.sync();
    }
  }

  bool _hasSync(String remote) {
    if (kIsWeb) return false;
    return _syncs.any((sync) => sync.remoteStorage.identifier == remote);
  }

  void _loadSettings(ButterflySettings settings) {
    if (kIsWeb) return;
    for (final remote in settings.connections) {
      if (!_hasSync(remote.identifier)) _createSync(remote.identifier);
    }
    _refreshStatus();
  }

  void _refreshStatus() {
    if (kIsWeb) return;
    var syncStatus = SyncStatus.synced;
    for (final sync in _syncs) {
      if (sync.status == SyncStatus.error) {
        syncStatus = SyncStatus.error;
        break;
      } else if (sync.status == SyncStatus.syncing) {
        syncStatus = SyncStatus.syncing;
      }
    }
    _statusSubject.add(syncStatus);
  }

  List<RemoteSync> get syncs => List.unmodifiable(_syncs);
}

enum SyncStatus { synced, syncing, error }

class RemoteSync {
  final BuildContext context;
  final ExternalStorage remoteStorage;
  final ButterflyFileSystem fileSystem;
  final BehaviorSubject<List<SyncFile>> _filesSubject =
      BehaviorSubject<List<SyncFile>>();
  final BehaviorSubject<SyncStatus> _statusSubject =
      BehaviorSubject<SyncStatus>();

  SettingsCubit get settingsCubit => fileSystem.settingsCubit;

  Stream<List<SyncFile>> get filesStream => _filesSubject.stream;
  List<SyncFile>? get files => _filesSubject.valueOrNull;
  Stream<SyncStatus> get statusStream => _statusSubject.stream;
  SyncStatus? get status => _statusSubject.valueOrNull;

  RemoteSync(this.context, this.fileSystem, this.remoteStorage) {
    _filesSubject.onListen = _onListen;
  }

  RemoteDirectoryFileSystem? buildRemoteSystem() =>
      fileSystem.buildDocumentSystem(remoteStorage).remoteSystem;

  Future<void> _refreshSyncStatus() async {
    if (status == SyncStatus.syncing) {
      return;
    }
    final remoteSystem = buildRemoteSystem();
    if (remoteSystem == null) return;
    final currentFiles = await remoteSystem.getSyncFiles();
    _filesSubject.add(currentFiles);
  }

  Future<void> autoSync() async {
    final syncMode = settingsCubit.state.syncMode;
    if (syncMode == SyncMode.manual) {
      return;
    }
    if (syncMode == SyncMode.noMobile &&
        !(await Connectivity().checkConnectivity()).contains(
          ConnectivityResult.mobile,
        )) {
      return;
    }
    await sync();
  }

  Future<void> sync() async {
    if (status == SyncStatus.syncing) {
      return;
    }
    _statusSubject.add(SyncStatus.syncing);
    final remoteSystem = buildRemoteSystem();
    if (remoteSystem == null) return;
    var files = <SyncFile>[];
    _filesSubject.add([]);
    final currentFiles = await remoteSystem.getAllSyncFiles();
    _filesSubject.add(currentFiles);
    final now = DateTime.now().toUtc();

    final hasError = status == SyncStatus.error;

    for (final file in currentFiles) {
      switch (file.status) {
        case FileSyncStatus.localLatest:
          await remoteSystem.uploadCachedContent(file.location.path);
          final syncedFile = SyncFile(
            isDirectory: file.isDirectory,
            location: file.location,
            syncedLastModified: now,
            localLastModified: file.localLastModified,
            remoteLastModified: file.localLastModified,
          );
          files.add(syncedFile);
          break;
        case FileSyncStatus.remoteLatest:
          if (!hasError) {
            await remoteSystem.cache(file.location.path);
            final syncedFile = SyncFile(
              isDirectory: file.isDirectory,
              location: file.location,
              syncedLastModified: now,
              localLastModified: file.remoteLastModified,
              remoteLastModified: file.remoteLastModified,
            );
            files.add(syncedFile);
          }
          break;
        case FileSyncStatus.synced:
          files.add(file);
          break;
        case FileSyncStatus.conflict:
          _statusSubject.add(SyncStatus.error);
          files.add(file);
          break;
        case FileSyncStatus.offline:
          files.add(file);
          break;
      }
    }
    _filesSubject.add(files);
    if (status != SyncStatus.error) {
      await _updateLastSynced();
      _statusSubject.add(SyncStatus.synced);
    }
    _filesSubject.add(files);
  }

  Future<List<SyncFile>> getSyncFiles([FileSyncStatus? status]) async {
    // Get current files from stream or sync
    var currentFiles = await filesStream.first;
    if (status != null) {
      currentFiles = currentFiles
          .where((file) => file.status == status)
          .toList();
    }
    return currentFiles;
  }

  void _onListen() {
    if (files == null) sync();
    _refreshSyncStatus();
  }

  Future<void> _updateLastSynced() {
    return settingsCubit.updateLastSynced(remoteStorage.identifier);
  }

  Future<void> resolve(String path, FileSyncStatus status) async {
    if (this.status == SyncStatus.syncing) {
      return;
    }
    _statusSubject.add(SyncStatus.syncing);
    final last = List<SyncFile>.from(files ?? []);
    final remoteSystem = buildRemoteSystem();
    if (remoteSystem == null) return;
    last.removeWhere((element) => element.location.path == path);
    _filesSubject.add(last);
    switch (status) {
      case FileSyncStatus.localLatest:
        // Upload local file to remote
        await remoteSystem.uploadCachedContent(path);
        await remoteSystem.deleteCachedContent(path);
        break;
      case FileSyncStatus.remoteLatest:
        return remoteSystem.deleteCachedContent(path);
      case FileSyncStatus.conflict:
        await remoteSystem.cache(path);
        final remoteAsset = await remoteSystem
            .fetchAsset(path, readData: true, forceRemote: true)
            .last;
        if (remoteAsset is RawFileSystemFile) {
          final doc = remoteAsset.data;
          if (doc == null) return;
          await remoteSystem.createFile(remoteAsset.path, doc, forceSync: true);
          await remoteSystem.uploadCachedContent(path);
        }
        break;
      default:
        _statusSubject.add(SyncStatus.error);
        throw Exception('Unknown status $status');
    }
    _statusSubject.add(SyncStatus.synced);

    await sync();
  }
}
