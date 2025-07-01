import 'dart:io';
import 'dart:ui';

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //step 1 Initialize
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final sizes = {
    'phoneScreenshots': const Size(360, 800),
    'sevenInchTabletScreenshots': const Size(600, 1024),
    'tenInchTabletScreenshots': const Size(800, 1280),
  };
  for (final size in sizes.entries) {
    final sizeName = size.key;
    //final screenSize = size.value;

    takeScreenShot(WidgetTester tester, String name) async {
      final screenShotName = '$sizeName/$name';
      if (!kIsWeb && Platform.isAndroid) {
        await binding.convertFlutterSurfaceToImage();
        await tester.pumpAndSettle();
      }
      await binding.takeScreenshot(screenShotName);
    }

    group('screenshot-$sizeName', () {
      //await binding.setSurfaceSize(screenSize);
      testWidgets('main', (WidgetTester tester) async {
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();
        final settingsCubit = SettingsCubit(prefs);
        await tester.pumpWidget(ButterflyApp(settingsCubit: settingsCubit));
        await tester.pumpAndSettle();

        await takeScreenShot(tester, 'main');
        await tester.pumpAndSettle();
      });
    });
  }
}
