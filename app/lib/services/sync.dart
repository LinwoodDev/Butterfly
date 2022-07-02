import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/file_system_remote.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../cubits/settings.dart';

class SyncService {
  final BuildContext context;
  final List<RemoteSync> _syncs = [];
  final SettingsCubit settingsCubit;

  SyncService(this.context, this.settingsCubit) {
    settingsCubit.stream.listen(_onSettingsChanged);
  }

  RemoteSync? getSync(String remote) {
    var sync = _syncs
        .firstWhereOrNull((sync) => sync.remoteStorage.identifier == remote);
    if (sync == null) {
      final storage = settingsCubit.state.getRemote(remote);
      if (storage != null) {
        sync = RemoteSync(context, settingsCubit, storage);
        _syncs.add(sync);
      }
    }
    return sync;
  }

  void _onSettingsChanged(ButterflySettings settings) {}
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
        as DavRemoteSystem;
    var files = await fileSystem.getSyncFiles();

    _filesSubject.add(files);
    _statusSubject.add(SyncStatus.synced);
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
    sync();
  }
}
