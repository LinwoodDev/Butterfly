import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/persisted_document_state.dart';
import 'package:synchronized/synchronized.dart';

class DocumentStateRepository {
  DocumentStateRepository(this.fileSystem, {this.settingsProvider});

  final DocumentStateFileSystem fileSystem;
  final DocumentStatePersistenceSettings Function()? settingsProvider;
  final _lock = Lock();
  var _cleanupStarted = false;
  DateTime? _lastCleanupAt;
  Future<void>? _scheduledCleanup;

  DocumentStatePersistenceSettings get _settings =>
      settingsProvider?.call() ?? const DocumentStatePersistenceSettings();

  Future<PersistedDocumentState?> load({
    String? contentHash,
    String? pathKey,
    bool allowContentHash = true,
  }) => _lock.synchronized(() async {
    final settings = _settings;
    if (!settings.enabled) return null;
    await fileSystem.initialize();
    if (allowContentHash && contentHash != null) {
      final byContent = await _getFileOrNull(
        documentStateContentKey(contentHash),
      );
      if (byContent != null) return _applySettings(byContent, settings);
    }
    if (pathKey != null) {
      final byPath = await _getFileOrNull(pathKey);
      return byPath == null ? null : _applySettings(byPath, settings);
    }
    return null;
  });

  Future<void> save(
    PersistedDocumentState state, {
    String? contentHash,
    String? pathKey,
  }) => _lock.synchronized(() async {
    final settings = _settings;
    if (!settings.enabled) return;
    await fileSystem.initialize();
    if (contentHash != null) {
      await _put(documentStateContentKey(contentHash), state, settings);
    }
    if (pathKey != null) {
      await _put(pathKey, state, settings);
    }
    _scheduleCleanupAfterSave(contentHash: contentHash, pathKey: pathKey);
  });

  Future<void> cleanup({
    String? contentHash,
    String? pathKey,
    DateTime? now,
  }) => _lock.synchronized(() async {
    final settings = _settings;
    await fileSystem.initialize();
    final keys = await fileSystem.getKeys();
    final protectedKeys = <String>{};
    if (contentHash != null) {
      protectedKeys.add(documentStateContentKey(contentHash));
    }
    if (pathKey != null) {
      protectedKeys.add(pathKey);
    }
    final records = <({String key, PersistedDocumentState state})>[];
    for (final key in keys) {
      final state = await _getFileOrNull(key);
      if (state == null) continue;
      records.add((key: key, state: state));
    }
    final cutoff = (now ?? DateTime.now().toUtc()).subtract(
      Duration(days: settings.maxAgeDays),
    );
    for (final record in records) {
      final updatedAt = record.state.updatedAt;
      if (protectedKeys.contains(record.key) || updatedAt == null) continue;
      if (updatedAt.isBefore(cutoff)) {
        await fileSystem.deleteFile(record.key);
      }
    }
    final remaining = <({String key, PersistedDocumentState state})>[];
    for (final key in await fileSystem.getKeys()) {
      final state = await _getFileOrNull(key);
      if (state != null) remaining.add((key: key, state: state));
    }
    remaining.sort((a, b) {
      final aTime = a.state.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.state.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return aTime.compareTo(bTime);
    });
    final removable = remaining
        .where((record) => !protectedKeys.contains(record.key))
        .toList();
    final overflow = (remaining.length - settings.maxEntries).clamp(
      0,
      removable.length,
    );
    for (final record in removable.take(overflow)) {
      await fileSystem.deleteFile(record.key);
    }
  });

  Future<void> _put(
    String key,
    PersistedDocumentState state,
    DocumentStatePersistenceSettings settings,
  ) async {
    final existing = await _getFileOrNull(key);
    final next = _mergeEnabled(existing, state, settings);
    if (existing != null || await fileSystem.hasKey(key)) {
      await fileSystem.updateFile(key, next);
    } else {
      await fileSystem.createFile(key, next);
    }
  }

  PersistedDocumentState _applySettings(
    PersistedDocumentState state,
    DocumentStatePersistenceSettings settings,
  ) => state.copyWith(
    pageName: settings.page ? state.pageName : null,
    camera: settings.camera ? state.camera : const PersistedCameraState(),
    locks: settings.locks ? state.locks : const PersistentLockState(),
    selectedTool: settings.tool
        ? state.selectedTool
        : const PersistedToolSelection(),
    navigator: settings.navigator
        ? state.navigator
        : const PersistedNavigatorState(),
    layers: settings.layers ? state.layers : const PersistedLayerState(),
    areaNavigator: settings.areas
        ? state.areaNavigator
        : const PersistedAreaNavigatorState(),
  );

  PersistedDocumentState _mergeEnabled(
    PersistedDocumentState? existing,
    PersistedDocumentState state,
    DocumentStatePersistenceSettings settings,
  ) {
    final fallback = existing ?? const PersistedDocumentState();
    return state.copyWith(
      pageName: settings.page ? state.pageName : fallback.pageName,
      camera: settings.camera ? state.camera : fallback.camera,
      locks: settings.locks ? state.locks : fallback.locks,
      selectedTool: settings.tool ? state.selectedTool : fallback.selectedTool,
      navigator: settings.navigator ? state.navigator : fallback.navigator,
      layers: settings.layers ? state.layers : fallback.layers,
      areaNavigator: settings.areas
          ? state.areaNavigator
          : fallback.areaNavigator,
    );
  }

  Future<PersistedDocumentState?> _getFileOrNull(String key) async {
    try {
      return await fileSystem.getFile(key);
    } on FormatException {
      return null;
    }
  }

  void _scheduleCleanupAfterSave({String? contentHash, String? pathKey}) {
    final now = DateTime.now().toUtc();
    final last = _lastCleanupAt;
    if (last != null && now.difference(last) < const Duration(minutes: 10)) {
      return;
    }
    if (_scheduledCleanup != null) return;
    _scheduledCleanup =
        Future<void>(() {
          return _cleanupAfterSave(contentHash: contentHash, pathKey: pathKey);
        }).whenComplete(() {
          _scheduledCleanup = null;
        });
  }

  Future<void> _cleanupAfterSave({String? contentHash, String? pathKey}) async {
    if (_cleanupStarted) return;
    _cleanupStarted = true;
    try {
      await cleanup(contentHash: contentHash, pathKey: pathKey);
      _lastCleanupAt = DateTime.now().toUtc();
    } finally {
      _cleanupStarted = false;
    }
  }
}
