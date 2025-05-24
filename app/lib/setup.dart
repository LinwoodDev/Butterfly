import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_leap/material_leap.dart';

Future<void> setup() async {
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
