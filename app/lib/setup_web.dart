// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'setup.dart' as general_setup;
import 'embed/action_web.dart' as action;

Future<void> setup() async {
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
  action.setup();
  await general_setup.setup();
}
