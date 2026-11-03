import 'package:butterfly/api/window.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:material_leap/material_leap.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:window_manager/window_manager.dart';

import 'main.dart';

Future<void> setup({required bool nativeTitleBar}) async {
  await pdfrxFlutterInitialize();
  if (!kIsWeb && isWindow) {
    final window = WindowManager.instance.getCurrent();
    if (window != null) {
      window.minimumSize = const Size(410, 300).toNative();
      window.title = applicationName;
      window.backgroundColor = Colors.transparent.toNative();
      window.isResizable = true;
      window.dispose();
    }
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
