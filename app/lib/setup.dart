import 'package:butterfly/api/window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_leap/material_leap.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:window_manager/window_manager.dart';

import 'main.dart';

Future<void> setup({required bool nativeTitleBar}) async {
  pdfrxFlutterInitialize();
  if (!kIsWeb && isWindow) {
    await windowManager.ensureInitialized();
    const windowOptions = WindowOptions(
      minimumSize: Size(410, 300),
      title: applicationName,
      backgroundColor: Colors.transparent,
    );

    await windowManager.waitUntilReadyToShow(windowOptions);

    await windowManager.setResizable(true);
    await windowManager.setPreventClose(false);
    await applyNativeTitleBar(nativeTitleBar);
  }
  setupFullScreen();
  setupLicenses();
}

void setupLicenses() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks([
      'Comfortaa',
    ], await rootBundle.loadString('fonts/Comfortaa-LICENSE.txt'));
    yield LicenseEntryWithLineBreaks([
      'Roboto',
    ], await rootBundle.loadString('fonts/Roboto-LICENSE.txt'));
    yield LicenseEntryWithLineBreaks([
      'Noto Sans Arabic',
    ], await rootBundle.loadString('fonts/NotoSansArabic-LICENSE.txt'));
  });
}
