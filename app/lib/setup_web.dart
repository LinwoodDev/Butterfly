// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'setup.dart' as generalSetup;

Future<void> setup() async {
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
  await generalSetup.setup();
}
