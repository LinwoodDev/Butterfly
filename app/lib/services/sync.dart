import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/file_system_remote.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../cubits/settings.dart';

class SyncService {
  final BuildContext context;
  final List<RemoteSync> _syncs = [];
  final SettingsCubit settingsCubit;
  final BehaviorSubject<SyncStatus> _statusSubject =
      BehaviorSubject<SyncStatus>();
  Stream<SyncStatus> get statusStream => _statusSubject.stream;
  SyncStatus? get status => _statusSubject.valueOrNull;

  SyncService(this.context, this.settingsCubit) {
    settingsCubit.stream.listen(_loadSettings);
    _loadSettings(settingsCubit.state);
  }

  RemoteSync? getSync(String remote) {
    if (kIsWeb) return null;
    var sync = _syncs
        .firstWhereOrNull((sync) => sync.remoteStorage.identifier == remote);
    sync ??= _createSync(remote);
    return sync;
  }

  RemoteSync? _createSync(String remote) {
    if (kIsWeb) return null;
    final storage = settingsCubit.state.getRemote(remote);
    if (storage == null) {
      return null;
    }
    final sync = RemoteSync(context, settingsCubit, storage);
    sync.statusStream.listen((status) => _refreshStatus());
    _syncs.add(sync);
    sync.sync();
    return sync;
  }

  Future<void> sync() async {
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
    for (final remote in settings.remotes) {
      if (!_hasSync(remote.identifier)) _createSync(remote.identifier);
    }
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

enum SyncStatus {
  synced,
  syncing,
  error,
}

class RemoteSync {
  final BuildContext context;
  final RemoteStorage remoteStorage;
  final SettingsCubit settingsCubit;
  final BehaviorSubject<List<SyncFile>> _filesSubject =
      BehaviorSubject<List<SyncFile>>();
  final BehaviorSubject<SyncStatus> _statusSubject =
      BehaviorSubject<SyncStatus>();

  Stream<List<SyncFile>> get filesStream => _filesSubject.stream;
  List<SyncFile>? get files => _filesSubject.valueOrNull;
  Stream<SyncStatus> get statusStream => _statusSubject.stream;
  SyncStatus? get status => _statusSubject.valueOrNull;

  RemoteSync(this.context, this.settingsCubit, this.remoteStorage) {
    _filesSubject.onListen = _onListen;
  }

  Future<void> sync() async {
    if (status == SyncStatus.syncing) {
      return;
    }
    _statusSubject.add(SyncStatus.syncing);
    final fileSystem = DocumentFileSystem.fromPlatform(remote: remoteStorage)
        as DavRemoteDocumentFileSystem;
    var files = <SyncFile>[];
    final currentFiles = await fileSystem.getAllSyncFiles();
    _filesSubject.add(currentFiles);

    for (final file in currentFiles) {
      switch (file.status) {
        case FileSyncStatus.localLatest:
          await fileSystem.uploadCachedContent(file.location.remote);
          break;
        case FileSyncStatus.remoteLatest:
          await fileSystem.cache(file.location.pathWithLeadingSlash);
          break;
        case FileSyncStatus.synced:
          break;
        case FileSyncStatus.conflict:
          _statusSubject.add(SyncStatus.error);
          files.add(file);
          break;
        case FileSyncStatus.offline:
          files.add(file);
          break;
      }
      _filesSubject.add(files);
    }
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
      currentFiles =
          currentFiles.where((file) => file.status == status).toList();
    }
    return currentFiles;
  }

  void _onListen() {
    if (files == null) sync();
  }

  Future<void> _updateLastSynced() {
    return settingsCubit.updateLastSynced(remoteStorage.identifier);
  }
}
