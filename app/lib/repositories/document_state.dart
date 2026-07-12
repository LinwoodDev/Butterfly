import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/persisted_document_state.dart';
import 'package:butterfly/services/logger.dart';
import 'package:lw_file_system/lw_file_system.dart';
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
    try {
      await fileSystem.initialize();
      if (pathKey != null) {
        final byPath = await _getFileOrNull(pathKey);
        if (byPath != null) return _applySettings(byPath, settings);
      }
      if (allowContentHash && contentHash != null) {
        final byContent = await _getFileOrNull(
          documentStateContentKey(contentHash),
        );
        if (byContent != null) return _applySettings(byContent, settings);
      }
    } on NetworkException catch (e, stackTrace) {
      // Document state is optional. A cached remote document must still open
      // when its separate state record is unavailable offline.
      talker.warning('Failed to load document state', e, stackTrace);
    }
    return null;
  });

  Future<void> save(
    PersistedDocumentState state, {
    String? contentKey,
    String? pathKey,
    String? previousContentKey,
    String? previousPathKey,
    required bool persistentChanged,
  }) => _lock.synchronized(() async {
    final settings = _settings;
    if (!settings.enabled) return;
    await fileSystem.initialize();
    await _updateFile(previousPathKey, pathKey, state, persistentChanged);
    await _updateFile(previousContentKey, contentKey, state, persistentChanged);
    _scheduleCleanupAfterSave(
      contentHash: state.contentHash,
      pathKey: state.pathKey,
    );
  });

  Future<int> cleanup({String? contentHash, String? pathKey, DateTime? now}) =>
      _lock.synchronized(() async {
        final settings = _settings;
        await fileSystem.initialize();
        final keys = await fileSystem.getKeys();
        final protectedKeys = <String>{};
        final deletedKeys = <String>{};
        if (contentHash != null) {
          protectedKeys.add(documentStateContentKey(contentHash));
        }
        if (pathKey != null) {
          protectedKeys.add(pathKey);
        }

        // Load all records once
        final records = <({String key, PersistedDocumentState state})>[];
        for (final key in keys) {
          final state = await _getFileOrNull(key);
          if (state == null) continue;
          records.add((key: key, state: state));
        }

        // Delete expired records
        final cutoff = (now ?? DateTime.now().toUtc()).subtract(
          Duration(days: settings.maxAgeDays),
        );
        for (final record in records) {
          final updatedAt = record.state.updatedAt;
          if (protectedKeys.contains(record.key) || updatedAt == null) continue;
          if (updatedAt.isBefore(cutoff)) {
            await fileSystem.deleteFile(record.key);
            deletedKeys.add(record.key);
          }
        }

        // Delete overflow records (oldest first)
        final remaining = records
            .where(
              (r) =>
                  !protectedKeys.contains(r.key) &&
                  !deletedKeys.contains(r.key),
            )
            .toList();
        if (remaining.length > settings.maxEntries) {
          remaining.sort((a, b) {
            final aTime =
                a.state.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final bTime =
                b.state.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return aTime.compareTo(bTime);
          });
          final overflow = remaining.length - settings.maxEntries;
          for (final record in remaining.take(overflow)) {
            await fileSystem.deleteFile(record.key);
            deletedKeys.add(record.key);
          }
        }
        return deletedKeys.length;
      });

  Future<int> cleanupAll() => _lock.synchronized(() async {
    await fileSystem.initialize();
    final keys = await fileSystem.getKeys();
    for (final key in keys) {
      await fileSystem.deleteFile(key);
    }
    return keys.length;
  });

  Future<void> _updateFile(
    String? oldKey,
    String? newKey,
    PersistedDocumentState state,
    bool persistentChanged,
  ) async {
    // No keys to update
    if (oldKey == null && newKey == null) return;

    // Same key and no changes to persist
    if (oldKey == newKey && !persistentChanged) return;

    final key = (newKey ?? oldKey)!;
    final keyChanged = oldKey != newKey;

    final nextState = await _mergeDisabledSettings(oldKey ?? key, state);

    if (!keyChanged) {
      // Same key, only update if persistent data changed
      if (persistentChanged) {
        await fileSystem.updateFile(key, nextState);
      }
    } else if (persistentChanged || oldKey == null) {
      // Key changed or new key: delete old and create new
      if (oldKey != null) {
        await fileSystem.deleteFile(oldKey);
        await fileSystem.createFile(key, nextState);
      } else {
        await fileSystem.updateFile(key, nextState);
      }
    } else {
      // Key changed but persisted data did not.
      await fileSystem.renameFile(oldKey, key);
    }
  }

  Future<PersistedDocumentState> _mergeDisabledSettings(
    String key,
    PersistedDocumentState state,
  ) async {
    final settings = _settings;
    if (settings.page &&
        settings.camera &&
        settings.locks &&
        settings.tool &&
        settings.navigator &&
        settings.layers &&
        settings.areas) {
      return state;
    }
    final existing = await _getFileOrNull(key);
    if (existing == null) return state;
    return state.copyWith(
      pageName: settings.page ? state.pageName : existing.pageName,
      camera: settings.camera ? state.camera : existing.camera,
      locks: settings.locks ? state.locks : existing.locks,
      selectedTool: settings.tool ? state.selectedTool : existing.selectedTool,
      navigator: settings.navigator ? state.navigator : existing.navigator,
      layers: settings.layers ? state.layers : existing.layers,
      areaNavigator: settings.areas
          ? state.areaNavigator
          : existing.areaNavigator,
    );
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

  Future<PersistedDocumentState?> _getFileOrNull(String key) async {
    try {
      return await fileSystem.getFile(key);
    } on FormatException catch (e, stackTrace) {
      talker.warning('Failed to parse document state at $key', e, stackTrace);
      return null;
    }
  }

  static const _minCleanupInterval = Duration(hours: 1);

  void _scheduleCleanupAfterSave({String? contentHash, String? pathKey}) {
    // Skip if cleanup already scheduled or running
    if (_scheduledCleanup != null || _cleanupStarted) return;

    // Skip if cleanup ran recently
    final last = _lastCleanupAt;
    if (last != null &&
        DateTime.now().toUtc().difference(last) < _minCleanupInterval) {
      return;
    }

    _scheduledCleanup =
        Future<void>.microtask(() {
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
