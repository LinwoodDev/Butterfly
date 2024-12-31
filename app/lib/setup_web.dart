import 'package:flutter/services.dart';

import 'setup.dart' as general_setup;
import 'embed/action_web.dart' as action;

Future<void> setup() async {
  await BrowserContextMenu.disableContextMenu();
  action.setup();
  await general_setup.setup();
}
