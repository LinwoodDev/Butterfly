import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  try {
    await integrationDriver(
      onScreenshot: (screenshotName, screenshotBytes, [args]) async {
        final File image = await File(
          '../metadata/en-US/images/$screenshotName.png',
        ).create(recursive: true);
        await image.writeAsBytes(screenshotBytes);
        return true;
      },
    );
  } catch (e) {
    // ignore: avoid_print
    print('Error occured: $e');
  }
}
