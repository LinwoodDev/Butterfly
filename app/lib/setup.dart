import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_leap/material_leap.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:window_manager/window_manager.dart';

import 'main.dart';

Future<void> setup() async {
  pdfrxFlutterInitialize();
  if (!kIsWeb && isWindow) {
    await windowManager.ensureInitialized();
    const kWindowOptions = WindowOptions(
      minimumSize: Size(410, 300),
      title: applicationName,
      backgroundColor: Colors.transparent,
    );

    // Use it only after calling `hiddenWindowAtLaunch`
    await windowManager.waitUntilReadyToShow(kWindowOptions).then((_) async {
      await windowManager.setResizable(true);
      await windowManager.setPreventClose(false);
    });
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
  });
}
