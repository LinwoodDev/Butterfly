import 'package:archive/archive.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/services/backup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/mocks.dart';

void main() {
  group('backup scheduling', () {
    test('is due after the configured interval', () {
      final lastBackup = DateTime.utc(2026, 8, 12, 8);

      expect(
        isBackupDue(
          lastBackup,
          DateTime.utc(2026, 8, 12, 13, 59),
          const Duration(hours: 6),
        ),
        isFalse,
      );
      expect(
        isBackupDue(
          lastBackup,
          DateTime.utc(2026, 8, 12, 14),
          const Duration(hours: 6),
        ),
        isTrue,
      );
      expect(
        isBackupDue(null, DateTime.utc(2026, 8, 12), const Duration(days: 7)),
        isTrue,
      );
    });
  });

  for (final storage in <ExternalStorage>[
    const DavRemoteStorage(
      name: 'Backup target',
      username: 'user',
      url: 'https://example.com/dav',
    ),
    const LocalStorage(name: 'Local backup target', paths: {'': '/backups'}),
  ]) {
    test('manual backup writes a ZIP to ${storage.label}', () async {
      SharedPreferences.setMockInitialValues({
        'connections': [storage.toJson()],
        'backup_remote': storage.identifier,
      });
      final prefs = await SharedPreferences.getInstance();
      final settingsCubit = SettingsCubit(prefs);
      final fileSystem = MockButterflyFileSystem(settingsCubit: settingsCubit);
      final createdAt = DateTime(2026, 8, 12, 14, 5, 9);
      final service = BackupService(fileSystem, now: () => createdAt);
      addTearDown(service.dispose);
      addTearDown(settingsCubit.close);

      await fileSystem.buildDocumentSystem().createFile(
        'Test.bfly',
        DocumentDefaults.createDocument(name: 'Test').toFile(),
      );
      await fileSystem.buildPackSystem().createFile(
        'Test pack.bfly',
        DocumentDefaults.createPack(),
      );
      final fileName = await service.backupNow();

      expect(fileName, 'Butterfly-2026-08-12_14-05-09.zip');
      final backup = await fileSystem
          .buildBackupSystem(storage)
          .getAsset(fileName, listLevel: noListLevel);
      expect(backup, isA<RawFileSystemFile>());
      final bytes = (backup as RawFileSystemFile).data;
      expect(bytes, isNotNull);
      expect(ZipDecoder().decodeBytes(bytes!), isNotEmpty);
      expect(settingsCubit.state.lastBackup, createdAt.toUtc());
    });
  }

  test('automatic backup runs for a local connection', () async {
    const storage = LocalStorage(
      name: 'Local backup target',
      paths: {'': '/backups'},
    );
    SharedPreferences.setMockInitialValues({
      'connections': [storage.toJson()],
      'backup_remote': storage.identifier,
      'automatic_backup': true,
    });
    final settingsCubit = SettingsCubit(await SharedPreferences.getInstance());
    addTearDown(settingsCubit.close);
    final fileSystem = MockButterflyFileSystem(settingsCubit: settingsCubit);
    final createdAt = DateTime(2026, 10, 18, 14);
    final completed = settingsCubit.stream.firstWhere(
      (settings) => settings.lastBackup != null,
    );
    final service = BackupService(fileSystem, now: () => createdAt);
    addTearDown(service.dispose);

    await completed.timeout(const Duration(seconds: 5));

    final backup = await fileSystem
        .buildBackupSystem(storage)
        .getAsset(backupFileName(createdAt), listLevel: noListLevel);
    expect(backup, isA<RawFileSystemFile>());
    expect(settingsCubit.state.lastBackup, createdAt.toUtc());
  });
}
