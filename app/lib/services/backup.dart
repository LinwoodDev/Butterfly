import 'dart:async';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/logger.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:lw_file_system/lw_file_system.dart';

typedef BackupProgressCallback = void Function(double progress);

bool isBackupDue(DateTime? lastBackup, DateTime now, Duration interval) {
  if (lastBackup == null) return true;
  return !lastBackup.add(interval).isAfter(now);
}

String backupFileName(DateTime date) {
  final localDate = date.toLocal();
  final month = localDate.month.toString().padLeft(2, '0');
  final day = localDate.day.toString().padLeft(2, '0');
  final hour = localDate.hour.toString().padLeft(2, '0');
  final minute = localDate.minute.toString().padLeft(2, '0');
  final second = localDate.second.toString().padLeft(2, '0');
  return 'Butterfly-${localDate.year}-$month-${day}_$hour-$minute-$second.zip';
}

Future<Uint8List> createButterflyDataArchive(
  ButterflyFileSystem fileSystem, {
  bool documents = true,
  bool packs = true,
  bool templates = true,
  BackupProgressCallback? onProgress,
}) async {
  if (!documents && !packs && !templates) {
    throw ArgumentError('At least one data category must be selected');
  }

  final output = OutputMemoryStream();
  final encoder = ZipEncoder()..startEncode(output);
  final selectedCategories = [documents, packs, templates].where((e) => e);
  final useCategoryDirectories = selectedCategories.length > 1;
  final packKeys = packs
      ? await fileSystem.buildPackSystem().getKeys()
      : const <String>[];
  final templateKeys = templates
      ? await fileSystem.buildTemplateSystem().getKeys()
      : const <String>[];
  final totalTasks =
      (documents ? 1 : 0) + packKeys.length + templateKeys.length + 1;
  var completedTasks = 0;

  void reportProgress() {
    onProgress?.call(completedTasks / totalTasks);
  }

  reportProgress();

  if (documents) {
    final documentSystem = fileSystem.buildDocumentSystem();
    final directory = await documentSystem.getAsset(
      '',
      listLevel: oneListLevel,
      readData: false,
    );
    if (directory is FileSystemDirectory<NoteFile>) {
      await _addDirectoryToArchive(
        documentSystem,
        encoder,
        directory,
        useCategoryDirectories ? 'Documents' : '',
      );
    }
    completedTasks++;
    reportProgress();
  }

  if (packs) {
    final packSystem = fileSystem.buildPackSystem();
    for (final key in packKeys) {
      final data = await packSystem.fileSystem.getFile(key);
      if (data != null) {
        encoder.add(
          ArchiveFile.bytes(useCategoryDirectories ? 'Packs/$key' : key, data),
        );
      }
      completedTasks++;
      reportProgress();
    }
  }

  if (templates) {
    final templateSystem = fileSystem.buildTemplateSystem();
    for (final key in templateKeys) {
      final data = await templateSystem.fileSystem.getFile(key);
      if (data != null) {
        encoder.add(
          ArchiveFile.bytes(
            useCategoryDirectories ? 'Templates/$key' : key,
            data,
          ),
        );
      }
      completedTasks++;
      reportProgress();
    }
  }

  encoder.endEncode();
  completedTasks++;
  reportProgress();
  return Uint8List.fromList(output.getBytes());
}

Future<void> _addDirectoryToArchive(
  GeneralDirectoryFileSystem<NoteFile> fileSystem,
  ZipEncoder encoder,
  FileSystemDirectory<NoteFile> directory,
  String archivePath,
) async {
  final resolvedDirectory = await fileSystem.getAsset(
    directory.path,
    listLevel: oneListLevel,
    readData: false,
  );
  if (resolvedDirectory is! FileSystemDirectory<NoteFile>) return;

  final directoryPath = archivePath.isEmpty
      ? ''
      : archivePath.endsWith('/')
      ? archivePath
      : '$archivePath/';
  if (directoryPath.isNotEmpty) {
    encoder.add(ArchiveFile.directory(directoryPath));
  }

  for (final entity in resolvedDirectory.assets) {
    final childPath = '$directoryPath${entity.fileName}';
    if (entity is FileSystemDirectory<NoteFile>) {
      await _addDirectoryToArchive(fileSystem, encoder, entity, childPath);
      continue;
    }
    if (entity is! FileSystemFile<NoteFile>) continue;

    final file = entity.hasData
        ? entity
        : await fileSystem.getAsset(
            entity.path,
            listLevel: noListLevel,
            readData: true,
          );
    if (file is FileSystemFile<NoteFile>) {
      final data = file.data?.data;
      if (data != null) encoder.add(ArchiveFile.bytes(childPath, data));
    }
  }
}

class BackupService {
  final ButterflyFileSystem fileSystem;
  final DateTime Function() _now;

  Timer? _timer;
  StreamSubscription<ButterflySettings>? _settingsSubscription;
  Future<String>? _activeBackup;
  bool _disposed = false;

  BackupService(this.fileSystem, {DateTime Function()? now})
    : _now = now ?? DateTime.now {
    _settingsSubscription = fileSystem.settingsCubit.stream.listen(
      _configureSchedule,
    );
    _configureSchedule(fileSystem.settingsCubit.state);
  }

  bool get isRunning => _activeBackup != null;

  Future<String> backupNow() {
    final activeBackup = _activeBackup;
    if (activeBackup != null) return activeBackup;

    final backup = _createBackup();
    _activeBackup = backup;
    return backup.whenComplete(() {
      if (identical(_activeBackup, backup)) _activeBackup = null;
    });
  }

  Future<String> _createBackup() async {
    if (kIsWeb) {
      throw UnsupportedError('Remote backups are not supported on the web');
    }
    final settings = fileSystem.settingsCubit.state;
    final storage = settings.getRemote(settings.backupRemote);
    if (storage is! RemoteStorage) {
      throw StateError('No backup connection selected');
    }

    final createdAt = _now();
    final bytes = await createButterflyDataArchive(fileSystem);
    final fileName = backupFileName(createdAt);
    final backupSystem = fileSystem.buildBackupSystem(storage);
    await backupSystem.updateFile(fileName, bytes, forceSync: true);
    await fileSystem.settingsCubit.updateLastBackup(createdAt.toUtc());
    talker.info('Created backup $fileName on ${storage.identifier}');
    return fileName;
  }

  void _configureSchedule(ButterflySettings settings) {
    _timer?.cancel();
    _timer = null;
    if (_disposed || kIsWeb || !settings.automaticBackup) return;
    if (settings.getRemote(settings.backupRemote) is! RemoteStorage) return;

    final now = _now();
    final interval = Duration(minutes: settings.backupIntervalMinutes);
    if (isBackupDue(settings.lastBackup, now, interval)) {
      if (_activeBackup == null) unawaited(_runScheduledBackup());
      return;
    }

    final nextBackup = settings.lastBackup!.add(interval);
    _timer = Timer(nextBackup.difference(now), () {
      if (!_disposed) unawaited(_runScheduledBackup());
    });
  }

  Future<void> _runScheduledBackup() async {
    try {
      await backupNow();
    } catch (error, stackTrace) {
      talker.error('Failed to create scheduled backup', error, stackTrace);
      if (!_disposed) {
        _timer?.cancel();
        _timer = Timer(const Duration(hours: 1), () {
          if (!_disposed) unawaited(_runScheduledBackup());
        });
      }
    }
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _timer?.cancel();
    _timer = null;
    _settingsSubscription?.cancel();
    _settingsSubscription = null;
  }
}
