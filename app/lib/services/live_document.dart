import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/logger.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/scheduler.dart';
import 'package:lw_file_system/lw_file_system.dart';

/// Shows the changes that other devices save to an open note in a remote
/// storage, while the note stays open.
///
/// The note on the server is checked with a conditional request every
/// [interval], or every [activeInterval] for [activeTime] after the note
/// changed on any device. A newer version replaces the open document only if
/// this device has no changes that are not uploaded yet; those win when they
/// are uploaded.
class LiveDocumentWatcher {
  static const interval = Duration(seconds: 3);
  static const activeInterval = Duration(seconds: 1);
  static const activeTime = Duration(minutes: 2);

  final ButterflyFileSystem fileSystem;
  final SettingsCubit settingsCubit;
  final DocumentBloc bloc;
  Timer? _timer;
  bool _disposed = false;
  StreamSubscription<DocumentSaveState>? _saveSubscription;
  bool _checking = false;
  AssetLocation? _location;
  String? _etag;
  // The version of the note that the editor shows.
  Uint8List? _shown;
  DateTime? _lastChange;

  LiveDocumentWatcher({
    required this.fileSystem,
    required this.settingsCubit,
    required this.bloc,
    Uint8List? shown,
  }) {
    _shown = shown;
    var saved = bloc.editorController.saveCubit.state.saved;
    _saveSubscription = bloc.editorController.saveCubit.stream.listen((state) {
      if (saved == SaveState.saving && state.saved == SaveState.saved) {
        _lastChange = DateTime.now();
        unawaited(_readSavedVersion());
      }
      saved = state.saved;
    });
    _schedule();
  }

  void _schedule() {
    final lastChange = _lastChange;
    final active =
        lastChange != null &&
        DateTime.now().difference(lastChange) < activeTime;
    _timer = Timer(active ? activeInterval : interval, () async {
      await check();
      if (!_disposed) _schedule();
    });
  }

  bool get _isVisible => switch (SchedulerBinding.instance.lifecycleState) {
    AppLifecycleState.paused ||
    AppLifecycleState.hidden ||
    AppLifecycleState.detached => false,
    _ => true,
  };

  RemoteFileSystem? _getRemote(AssetLocation location) {
    final storage = settingsCubit.getRemote(location.remote);
    if (location.absolute ||
        location.path.isEmpty ||
        storage is! RemoteStorage ||
        !(location.fileType?.isNote() ?? false)) {
      return null;
    }
    return fileSystem.buildDocumentSystem(storage).remoteSystem;
  }

  // Saving writes the note to the local copy before uploading it.
  Future<void> _readSavedVersion() async {
    final location = bloc.editorController.saveCubit.state.location;
    final remote = _getRemote(location);
    if (remote == null) return;
    final cached = await remote.getCachedContent(location.path);
    if (cached is RawFileSystemFile && cached.data != null) {
      _shown = cached.data;
    }
  }

  Future<void> check() async {
    if (_checking || _disposed || bloc.isClosed || !_isVisible) return;
    _checking = true;
    try {
      await _check();
    } on NetworkException catch (error) {
      talker.debug('Could not check the open note: $error');
    } catch (error, stackTrace) {
      talker.warning('Could not check the open note', error, stackTrace);
    } finally {
      _checking = false;
    }
  }

  Future<void> _check() async {
    final controller = bloc.editorController;
    if (controller.networkingService.isActive) return;
    final location = controller.saveCubit.state.location;
    final remote = _getRemote(location);
    if (remote == null) return;
    if (location != _location) {
      _location = location;
      _etag = null;
    }
    final path = remote.normalizePath(location.path);
    final response = await remote.createRequest(
      path.split('/'),
      headers: {'If-None-Match': ?_etag},
      timeout: RemoteFileSystem.transferTimeout,
    );
    if (response == null) return;
    if (response.statusCode != HttpStatus.ok) {
      await response.drain<void>();
      return;
    }
    final data = await remote.getBodyBytes(response);
    final etag = response.headers.value(HttpHeaders.etagHeader);
    final shown = _shown;
    if (shown == null || const ListEquality<int>().equals(data, shown)) {
      _etag = etag;
      _shown ??= data;
      return;
    }
    // Changes that are not uploaded yet replace this version once uploaded.
    if (controller.saveCubit.state.saved != SaveState.saved ||
        remote.pendingOperationsCount > 0) {
      return;
    }
    final file = NoteFile(data);
    if (file.isEncrypted() || file.load() == null) {
      _etag = etag;
      return;
    }
    if (_location != location || bloc.isClosed) return;
    final cached = await remote.getCachedContent(path, readData: false);
    if (cached is RawFileSystemFile) {
      await remote.cacheContent(
        path,
        data,
        modified: _parseDate(
          response.headers.value(HttpHeaders.lastModifiedHeader),
        ),
      );
    }
    _etag = etag;
    _shown = data;
    _lastChange = DateTime.now();
    talker.info('Showing the version of $path saved by another device');
    bloc.rebuildFromStorage(data);
  }

  DateTime? _parseDate(String? value) {
    if (value == null) return null;
    try {
      return HttpDate.parse(value);
    } on HttpException {
      return null;
    }
  }

  void dispose() {
    _disposed = true;
    _timer?.cancel();
    _timer = null;
    _saveSubscription?.cancel();
    _saveSubscription = null;
  }
}
