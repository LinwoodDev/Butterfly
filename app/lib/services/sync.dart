import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/services/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:rxdart/rxdart.dart';

import '../cubits/settings.dart';

/// Represents a file system type that can be synced.
///
/// Each type corresponds to a different data category in the application:
/// - [documents]: User-created documents and notes
/// - [templates]: Reusable document templates
/// - [packs]: Asset packs and resources
enum SyncFileSystemType { documents, templates, packs }

/// Aggregate status for all sync operations.
///
/// Used to indicate the overall state of synchronization across
/// one or more remote connections.
enum SyncStatus {
  /// All file systems are synced and up to date.
  synced,

  /// At least one file system is currently syncing.
  syncing,

  /// At least one file system encountered an error during sync.
  error,
}

/// Represents the sync state for a single remote connection.
///
/// This immutable class holds all state related to synchronization
/// including progress, pending files, conflicts, and error information.
@immutable
class RemoteSyncState {
  /// The remote storage configuration this state belongs to.
  final ExternalStorage storage;

  /// Current sync progress for each file system type.
  final Map<SyncFileSystemType, SyncProgress> progress;

  /// Files pending synchronization for each file system type.
  final Map<SyncFileSystemType, List<SyncFile>> files;

  /// Unresolved conflicts for each file system type.
  final Map<SyncFileSystemType, List<SyncConflict>> conflicts;

  /// Whether any sync operation is currently in progress.
  final bool isSyncing;

  /// The last error message, if any sync operation failed.
  final String? lastError;

  /// Creates a new [RemoteSyncState].
  const RemoteSyncState({
    required this.storage,
    this.progress = const {},
    this.files = const {},
    this.conflicts = const {},
    this.isSyncing = false,
    this.lastError,
  });

  /// Creates a copy of this state with the given fields replaced.
  ///
  /// Note: [lastError] is always replaced (not merged) to allow clearing errors.
  RemoteSyncState copyWith({
    ExternalStorage? storage,
    Map<SyncFileSystemType, SyncProgress>? progress,
    Map<SyncFileSystemType, List<SyncFile>>? files,
    Map<SyncFileSystemType, List<SyncConflict>>? conflicts,
    bool? isSyncing,
    String? lastError,
  }) {
    return RemoteSyncState(
      storage: storage ?? this.storage,
      progress: progress ?? this.progress,
      files: files ?? this.files,
      conflicts: conflicts ?? this.conflicts,
      isSyncing: isSyncing ?? this.isSyncing,
      lastError: lastError,
    );
  }

  /// Computes the aggregate sync status based on current state.
  SyncStatus get status => switch (lastError) {
    != null => SyncStatus.error,
    _ when isSyncing => SyncStatus.syncing,
    _ => SyncStatus.synced,
  };

  /// Returns `true` if there are any unresolved conflicts.
  bool get hasConflicts => conflicts.values.any((c) => c.isNotEmpty);

  /// Returns the total number of files pending synchronization.
  int get totalPendingFiles =>
      files.values.fold(0, (sum, list) => sum + list.length);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemoteSyncState &&
          runtimeType == other.runtimeType &&
          storage.identifier == other.storage.identifier &&
          isSyncing == other.isSyncing &&
          lastError == other.lastError;

  @override
  int get hashCode => Object.hash(storage.identifier, isSyncing, lastError);
}

/// Manages synchronization for a single remote storage.
///
/// This class handles all sync operations for a specific remote connection,
/// including:
/// - Monitoring sync progress across document, template, and pack file systems
/// - Detecting and tracking conflicts
/// - Providing streams for UI updates
/// - Managing online/offline status
class RemoteSync {
  final ButterflyFileSystem fileSystem;
  final ExternalStorage storage;

  final BehaviorSubject<RemoteSyncState> _stateSubject;
  final List<StreamSubscription<dynamic>> _subscriptions = [];

  final DocumentFileSystem documentSystem;
  final TemplateFileSystem templateSystem;
  final PackFileSystem packSystem;

  RemoteSync(this.fileSystem, this.storage)
    : _stateSubject = BehaviorSubject.seeded(RemoteSyncState(storage: storage)),
      documentSystem = fileSystem.buildDocumentSystem(storage),
      templateSystem = fileSystem.buildTemplateSystem(storage),
      packSystem = fileSystem.buildPackSystem(storage) {
    _initFileSystems();
  }

  void _initFileSystems() {
    // Subscribe to progress streams from remote file systems
    _subscribeToRemoteSystem(SyncFileSystemType.documents);
    _subscribeToRemoteSystem(SyncFileSystemType.templates);
    _subscribeToRemoteSystem(SyncFileSystemType.packs);
  }

  void _subscribeToRemoteSystem(SyncFileSystemType type) {
    final remoteSystem = _getRemoteSystem(type);
    if (remoteSystem == null) return;

    _subscriptions.add(
      remoteSystem.progressStream.listen((progress) {
        final currentState = _stateSubject.value;
        _stateSubject.add(
          currentState.copyWith(
            progress: {...currentState.progress, type: progress},
            isSyncing: progress.isRunning || _isAnySyncing(exclude: type),
          ),
        );
      }),
    );

    _subscriptions.add(
      remoteSystem.conflictStream.listen((conflict) {
        final currentState = _stateSubject.value;
        final currentConflicts = List<SyncConflict>.from(
          currentState.conflicts[type] ?? [],
        );
        if (!currentConflicts.any((c) => c.path == conflict.path)) {
          currentConflicts.add(conflict);
          _stateSubject.add(
            currentState.copyWith(
              conflicts: {...currentState.conflicts, type: currentConflicts},
            ),
          );
        }
      }),
    );
  }

  bool _isAnySyncing({SyncFileSystemType? exclude}) {
    return SyncFileSystemType.values
        .where((type) => type != exclude)
        .any((type) => _stateSubject.value.progress[type]?.isRunning ?? false);
  }

  RemoteFileSystem? _getRemoteSystem(SyncFileSystemType type) {
    final system = switch (type) {
      SyncFileSystemType.documents => documentSystem.remoteSystem,
      SyncFileSystemType.templates => templateSystem.remoteSystem,
      SyncFileSystemType.packs => packSystem.remoteSystem,
    };
    return system;
  }

  /// Stream of sync state changes
  Stream<RemoteSyncState> get stateStream => _stateSubject.stream;

  /// Current sync state
  RemoteSyncState get state => _stateSubject.value;

  /// Current sync status
  SyncStatus get status => state.status;

  /// Stream of sync status changes (for backward compatibility)
  Stream<SyncStatus> get statusStream =>
      stateStream.map((state) => state.status).distinct();

  /// Stream of all sync files across all file systems
  Stream<List<SyncFile>> get filesStream => stateStream.map(
    (state) => state.files.values.expand((files) => files).toList(),
  );

  /// Synchronizes all file systems with the remote storage.
  ///
  /// Returns a map of results for each [SyncFileSystemType].
  /// Individual file system failures are caught and logged, allowing
  /// other file systems to continue syncing.
  ///
  /// [conflictResolution] determines how conflicts are handled.
  Future<Map<SyncFileSystemType, FullSyncResult?>> sync({
    ConflictResolution conflictResolution = ConflictResolution.skip,
  }) async {
    talker.info('Syncing remote: ${storage.identifier}');

    _stateSubject.add(state.copyWith(isSyncing: true, lastError: null));

    final results = <SyncFileSystemType, FullSyncResult?>{};
    String? firstError;

    for (final type in SyncFileSystemType.values) {
      try {
        results[type] = await syncFileSystem(
          type,
          conflictResolution: conflictResolution,
        );
      } catch (e, stackTrace) {
        talker.error(
          'Failed to sync $type for ${storage.identifier}',
          e,
          stackTrace,
        );
        firstError ??= e.toString();
        results[type] = null;
      }
    }

    _stateSubject.add(state.copyWith(isSyncing: false, lastError: firstError));

    if (firstError == null) {
      talker.info('Sync completed for remote: ${storage.identifier}');
    } else {
      talker.warning(
        'Sync completed with errors for remote: ${storage.identifier}',
      );
    }

    return results;
  }

  /// Synchronizes a specific file system type with the remote storage.
  ///
  /// Returns `null` if no remote system is configured for the given [type].
  /// Throws if the sync operation fails.
  Future<FullSyncResult?> syncFileSystem(
    SyncFileSystemType type, {
    ConflictResolution conflictResolution = ConflictResolution.skip,
  }) async {
    final remoteSystem = _getRemoteSystem(type);
    if (remoteSystem == null) {
      talker.warning('No remote system for type: $type');
      return null;
    }

    return remoteSystem.fullSync(conflictResolution: conflictResolution);
  }

  /// Gets all files pending synchronization for a specific file system type.
  ///
  /// Returns an empty list if no remote system is configured for [type].
  Future<List<SyncFile>> getSyncFiles(SyncFileSystemType type) async {
    return _getRemoteSystem(type)?.getAllSyncFiles() ?? [];
  }

  /// Refreshes the list of files needing synchronization.
  ///
  /// Errors for individual file system types are logged but do not
  /// prevent other types from being refreshed.
  Future<void> refreshFiles() async {
    final files = <SyncFileSystemType, List<SyncFile>>{};

    await Future.wait(
      SyncFileSystemType.values.map((type) async {
        try {
          files[type] = await getSyncFiles(type);
        } catch (e, stackTrace) {
          talker.warning('Failed to get sync files for $type', e, stackTrace);
          files[type] = [];
        }
      }),
    );

    _stateSubject.add(state.copyWith(files: files));
  }

  /// Resolves a conflict for a specific path and file system type.
  ///
  /// Throws [StateError] if no remote system is configured for [type].
  Future<SyncResult> resolveConflict(
    SyncFileSystemType type,
    String path,
    ConflictResolution resolution,
  ) async {
    final remoteSystem = _getRemoteSystem(type);
    if (remoteSystem == null) {
      throw StateError('No remote system for type: $type');
    }

    final result = await remoteSystem.resolveConflict(path, resolution);

    // Remove resolved conflict from state
    final updatedConflicts = (state.conflicts[type] ?? [])
        .where((c) => c.path != path)
        .toList();

    _stateSubject.add(
      state.copyWith(conflicts: {...state.conflicts, type: updatedConflicts}),
    );

    return result;
  }

  /// Updates the online status for all file systems.
  ///
  /// When [online] is `false`, sync operations will be paused.
  void setOnlineStatus(bool online) {
    for (final type in SyncFileSystemType.values) {
      _getRemoteSystem(type)?.setOnlineStatus(online);
    }
  }

  /// Performs automatic synchronization based on the given [mode].
  ///
  /// Behavior:
  /// - [SyncMode.manual]: No automatic sync is performed.
  /// - [SyncMode.noMobile]: Sync is skipped when on mobile data.
  /// - Other modes: Sync is performed immediately.
  Future<void> autoSync(SyncMode mode) async {
    if (mode == SyncMode.manual) return;

    if (mode == SyncMode.noMobile) {
      final connectivity = await Connectivity().checkConnectivity();
      final isMobile = connectivity.contains(ConnectivityResult.mobile);

      if (isMobile) {
        talker.info('Skipping auto-sync on mobile for: ${storage.identifier}');
        return;
      }
    }

    await sync();
  }

  bool _isDisposed = false;

  /// Whether this sync manager has been disposed.
  bool get isDisposed => _isDisposed;

  /// Disposes of all resources.
  ///
  /// After calling this method, the sync manager should not be used.
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;

    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
    _stateSubject.close();
  }
}

/// Service that manages synchronization across all remote connections.
///
/// This is the main entry point for sync functionality in the application.
/// It automatically:
/// - Creates sync managers for each configured remote storage
/// - Monitors connectivity changes and updates online status
/// - Aggregates sync status from all remotes
/// - Handles settings changes (adding/removing remotes)
class SyncService {
  final BuildContext context;
  final ButterflyFileSystem fileSystem;

  final Map<String, RemoteSync> _syncs = {};
  final BehaviorSubject<SyncStatus> _statusSubject = BehaviorSubject.seeded(
    SyncStatus.synced,
  );
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  SyncService(this.context, this.fileSystem) {
    _init();
  }

  SettingsCubit get settingsCubit => fileSystem.settingsCubit;

  void _init() {
    // Listen to settings changes
    _subscriptions.add(settingsCubit.stream.listen(_loadSettings));
    _loadSettings(settingsCubit.state);

    // Listen to connectivity changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      _onConnectivityChanged,
    );
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    final isOnline =
        results.isNotEmpty && !results.contains(ConnectivityResult.none);

    for (var sync in _syncs.values) {
      sync.setOnlineStatus(isOnline);
    }
  }

  /// Stream of overall sync status
  Stream<SyncStatus> get statusStream => _statusSubject.stream;

  /// Current overall sync status
  SyncStatus get status => _statusSubject.value;

  /// Get sync manager for a specific remote
  RemoteSync? getSync(String remote) {
    if (kIsWeb) return null;
    return _syncs[remote] ?? _createSync(remote);
  }

  RemoteSync? _createSync(String remote) {
    final storage = settingsCubit.state.getRemote(remote);
    if (storage == null) {
      talker.warning('Remote storage not found: $remote');
      return null;
    }

    talker.info('Creating sync for remote: $remote');
    final sync = RemoteSync(fileSystem, storage);

    _subscriptions.add(sync.statusStream.listen((_) => _refreshStatus()));
    _syncs[remote] = sync;

    // Trigger auto-sync based on settings
    unawaited(sync.autoSync(settingsCubit.state.syncMode));

    return sync;
  }

  void _removeSync(String remote) {
    final sync = _syncs.remove(remote);
    sync?.dispose();
  }

  /// Sync all remotes
  Future<void> sync({
    ConflictResolution conflictResolution = ConflictResolution.skip,
  }) async {
    talker.info('Syncing all remotes');
    if (kIsWeb) return;

    for (final sync in _syncs.values) {
      await sync.sync(conflictResolution: conflictResolution);
    }
  }

  /// Sync a specific remote
  Future<void> syncRemote(
    String remote, {
    ConflictResolution conflictResolution = ConflictResolution.skip,
  }) async {
    final sync = getSync(remote);
    if (sync != null) {
      await sync.sync(conflictResolution: conflictResolution);
    }
  }

  void _loadSettings(ButterflySettings settings) {
    if (kIsWeb) return;

    final currentRemotes = _syncs.keys.toSet();
    final newRemotes = settings.connections
        .whereType<RemoteStorage>()
        .map((c) => c.identifier)
        .toSet();

    // Remove syncs for removed remotes
    for (final remote in currentRemotes.difference(newRemotes)) {
      _removeSync(remote);
    }

    // Create syncs for new remotes
    for (final remote in newRemotes.difference(currentRemotes)) {
      _createSync(remote);
    }

    _refreshStatus();
  }

  void _refreshStatus() {
    if (kIsWeb) return;

    final statuses = _syncs.values.map((s) => s.status);

    final syncStatus = statuses.contains(SyncStatus.error)
        ? SyncStatus.error
        : statuses.contains(SyncStatus.syncing)
        ? SyncStatus.syncing
        : SyncStatus.synced;

    _statusSubject.add(syncStatus);
  }

  /// Gets all active sync managers.
  List<RemoteSync> get syncs => List.unmodifiable(_syncs.values);

  bool _isDisposed = false;

  /// Whether this service has been disposed.
  bool get isDisposed => _isDisposed;

  /// Disposes of all resources.
  ///
  /// After calling this method, the service should not be used.
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;

    for (var sync in _syncs.values) {
      sync.dispose();
    }
    _syncs.clear();

    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();

    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    _statusSubject.close();
  }
}
