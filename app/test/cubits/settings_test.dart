import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/persisted_document_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('uses the date placeholder as the default file name', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    expect(ButterflySettings.fromPrefs(prefs).defaultFileName, '{date}');
    expect(const ButterflySettings().defaultFileName, '{date}');
  });

  test('persists the default file name pattern', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final cubit = SettingsCubit(prefs);

    await cubit.changeDefaultFileName('  Notes {date}  ');

    expect(cubit.state.defaultFileName, 'Notes {date}');
    expect(prefs.getString('default_file_name'), 'Notes {date}');
    expect(ButterflySettings.fromPrefs(prefs).defaultFileName, 'Notes {date}');
  });

  test('an empty file name restores the default pattern', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final cubit = SettingsCubit(prefs);

    await cubit.changeDefaultFileName('Custom');
    await cubit.changeDefaultFileName('  ');

    expect(cubit.state.defaultFileName, kDefaultFileName);
    expect(prefs.getString('default_file_name'), kDefaultFileName);
  });

  test('normalizes an empty persisted file name to the default', () async {
    SharedPreferences.setMockInitialValues({'default_file_name': '  '});
    final prefs = await SharedPreferences.getInstance();

    expect(
      ButterflySettings.fromPrefs(prefs).defaultFileName,
      kDefaultFileName,
    );
  });

  test('enables document encryption for an existing connection', () async {
    const remote = DavRemoteStorage(
      name: 'Encrypted remote',
      username: 'user',
      url: 'https://example.com/dav',
    );
    SharedPreferences.setMockInitialValues({
      'connections': [remote.toJson()],
    });
    final prefs = await SharedPreferences.getInstance();
    final cubit = SettingsCubit(prefs);
    addTearDown(cubit.close);

    await cubit.enableConnectionEncryption(remote.identifier);

    final updated = cubit.state.getRemote(remote.identifier);
    expect(updated?.isConnectionEncryptionEnabled, isTrue);
    final restored = ButterflySettings.fromPrefs(prefs)
        .getRemote(remote.identifier);
    expect(restored?.isConnectionEncryptionEnabled, isTrue);
  });

  test('persists automatic backup settings', () async {
    const remote = DavRemoteStorage(
      name: 'Backup target',
      username: 'user',
      url: 'https://example.com/dav',
    );
    SharedPreferences.setMockInitialValues({
      'connections': [remote.toJson()],
    });
    final prefs = await SharedPreferences.getInstance();
    final cubit = SettingsCubit(prefs);
    addTearDown(cubit.close);

    await cubit.changeBackupRemote(remote.identifier);
    await cubit.changeBackupInterval(const Duration(hours: 6));
    await cubit.changeAutomaticBackup(true);
    await cubit.updateLastBackup(DateTime.utc(2026, 8, 12, 14));

    final restored = ButterflySettings.fromPrefs(prefs);
    expect(restored.backupRemote, remote.identifier);
    expect(restored.backupIntervalMinutes, 360);
    expect(restored.automaticBackup, isTrue);
    expect(restored.lastBackup, DateTime.utc(2026, 8, 12, 14));
  });

  test('persists default document locks', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final cubit = SettingsCubit(prefs);
    addTearDown(cubit.close);
    const persistence = DocumentStatePersistenceSettings(
      defaultLocks: PersistentLockState(
        lockZoom: true,
        lockHorizontal: true,
        lockVertical: true,
      ),
    );

    await cubit.changeDocumentStatePersistence(persistence);

    final restored = ButterflySettings.fromPrefs(prefs);
    expect(
      restored.documentStatePersistence.defaultLocks,
      persistence.defaultLocks,
    );
  });

  group('SettingsCubit resets', () {
    test(
      'resets selected settings while preserving unrelated values',
      () async {
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();
        final cubit = SettingsCubit(prefs);
        await cubit.changeTheme(ThemeMode.dark);
        await cubit.changeTouchSensitivity(2);

        await cubit.resetSettings(
          (current, defaults) =>
              current.copyWith(touchSensitivity: defaults.touchSensitivity),
        );

        expect(cubit.state.touchSensitivity, 1);
        expect(cubit.state.theme, ThemeMode.dark);
        expect(prefs.getDouble('touch_sensitivity'), 1);
        expect(prefs.getString('theme_mode'), ThemeMode.dark.name);
      },
    );

    test('resets all settings but preserves recent history', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final cubit = SettingsCubit(prefs);
      const location = AssetLocation(path: '/note.bfly');
      await cubit.addRecentHistory(location);
      await cubit.changeTheme(ThemeMode.dark);
      await cubit.changeTouchSensitivity(2);

      await cubit.resetAllSettings();

      expect(cubit.state.theme, ThemeMode.system);
      expect(cubit.state.touchSensitivity, 1);
      expect(cubit.state.history, [location]);
      expect(prefs.getString('theme_mode'), ThemeMode.system.name);
      expect(prefs.getDouble('touch_sensitivity'), 1);
    });
  });

  group('SettingsCubit recent history', () {
    test(
      'deduplicates matching locations with and without leading slash',
      () async {
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();
        final cubit = SettingsCubit(prefs);

        await cubit.addRecentHistory(const AssetLocation(path: 'note.bfly'));
        await cubit.addRecentHistory(const AssetLocation(path: '/note.bfly'));

        expect(cubit.state.history, [const AssetLocation(path: '/note.bfly')]);
      },
    );

    test('normalizes and deduplicates persisted recent history', () async {
      SharedPreferences.setMockInitialValues({
        'history': [
          const AssetLocation(path: 'note.bfly').toJson(),
          const AssetLocation(path: '/note.bfly').toJson(),
        ],
      });
      final prefs = await SharedPreferences.getInstance();

      final settings = ButterflySettings.fromPrefs(prefs);

      expect(settings.history, [const AssetLocation(path: '/note.bfly')]);
    });

    test('updates recent history when a file moves', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final cubit = SettingsCubit(prefs);

      await cubit.addRecentHistory(const AssetLocation(path: '/old.bfly'));
      await cubit.moveAssetReferences(
        const AssetLocation(path: '/old.bfly'),
        const AssetLocation(path: '/new.bfly'),
      );

      expect(cubit.state.history, [const AssetLocation(path: '/new.bfly')]);
    });

    test('does not emit or save when no asset references move', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final cubit = SettingsCubit(prefs);
      var emitted = 0;
      final subscription = cubit.stream.listen((_) => emitted++);

      await cubit.moveAssetReferences(
        const AssetLocation(path: '/missing.bfly'),
        const AssetLocation(path: '/new.bfly'),
      );
      await Future<void>.delayed(Duration.zero);

      expect(emitted, 0);
      await subscription.cancel();
    });

    test(
      'updates nested recent and starred references when a folder moves',
      () async {
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();
        final cubit = SettingsCubit(prefs);

        const oldLocation = AssetLocation(path: '/old/note.bfly');
        const newLocation = AssetLocation(path: '/new/note.bfly');
        await cubit.addRecentHistory(oldLocation);
        await cubit.toggleStarred(oldLocation);
        await cubit.moveAssetReferences(
          const AssetLocation(path: '/old'),
          const AssetLocation(path: '/new'),
          directory: true,
        );

        expect(cubit.state.history, [newLocation]);
        expect(cubit.state.isStarred(oldLocation), false);
        expect(cubit.state.isStarred(newLocation), true);
      },
    );
  });
}
