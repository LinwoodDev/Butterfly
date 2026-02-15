import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keybinder/keybinder.dart';
import 'package:material_leap/material_leap.dart';

class FullScreenIntent extends Intent {
  const FullScreenIntent();
}

final fullScreenShortcut = ShortcutDefinition(
  id: 'full_screen',
  intent: const FullScreenIntent(),
  defaultActivator: const SingleActivator(LogicalKeyboardKey.f11),
);

class FullScreenAction extends Action<FullScreenIntent> {
  final BuildContext context;

  FullScreenAction(this.context);

  @override
  Future<void> invoke(FullScreenIntent intent) async {
    setFullScreen(!(await isFullScreen()));
  }
}
