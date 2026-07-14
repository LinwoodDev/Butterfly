import 'package:butterfly/cubits/settings.dart';
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
