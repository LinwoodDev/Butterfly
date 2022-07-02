import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/file_system_remote.dart';
import 'package:butterfly/dialogs/sync.dart';
import 'package:collection/collection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

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

class RemoteSync {
  final BuildContext context;
  final RemoteStorage remoteStorage;
  final SettingsCubit settingsCubit;
  final StreamController<List<SyncFile>> _filesController =
      StreamController<List<SyncFile>>.broadcast();

  Stream<List<SyncFile>> get files => _filesController.stream;

  RemoteSync(this.context, this.settingsCubit, this.remoteStorage) {
    _filesController.onListen = _onListen;
  }

  Future<void> sync({bool sendNotifications = true}) async {
    final fileSystem = DocumentFileSystem.fromPlatform(remote: remoteStorage)
        as DavRemoteSystem;
    var files = await fileSystem.getSyncFiles();
    if (sendNotifications) {
      files
          .where((element) => element.status == SyncStatus.conflict)
          .forEach((element) => _sendNotifications());
    }

    _filesController.add(files);
  }

  Future<List<SyncFile>> getSyncFiles([SyncStatus? status]) async {
    // Get current files from stream or sync
    var currentFiles = await files.first;
    if (status != null) {
      currentFiles =
          currentFiles.where((file) => file.status == status).toList();
    }
    return currentFiles;
  }

  void _onListen() {
    sync();
  }

  void _sendNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context)!.conflict),
      action: SnackBarAction(
        label: AppLocalizations.of(context)!.showDetails,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => SyncDialog(remote: remoteStorage.identifier),
        ),
      ),
    ));
  }
}
