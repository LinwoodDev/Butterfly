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

  test('manual backup writes a ZIP to the selected connection', () async {
    const remote = DavRemoteStorage(
      name: 'Backup target',
      username: 'user',
      url: 'https://example.com/dav',
    );
    SharedPreferences.setMockInitialValues({
      'connections': [remote.toJson()],
      'backup_remote': remote.identifier,
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
        .buildBackupSystem(remote)
        .getAsset(fileName, listLevel: noListLevel);
    expect(backup, isA<RawFileSystemFile>());
    final bytes = (backup as RawFileSystemFile).data;
    expect(bytes, isNotNull);
    expect(ZipDecoder().decodeBytes(bytes!), isNotEmpty);
    expect(settingsCubit.state.lastBackup, createdAt.toUtc());
  });
}
