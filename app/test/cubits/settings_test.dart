import 'package:butterfly/cubits/settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
  });
}
