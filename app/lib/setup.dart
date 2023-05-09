import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'api/full_screen.dart';

Future<void> setup() async {
  setupFullScreen();
  await setupLicenses();
}

Future<void> setupLicenses() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['Roboto'], license);
  });
}
