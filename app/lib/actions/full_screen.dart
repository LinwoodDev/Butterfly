import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';

class FullScreenIntent extends Intent {
  final BuildContext context;

  const FullScreenIntent(this.context);
}

class FullScreenAction extends Action<FullScreenIntent> {
  FullScreenAction();

  @override
  Future<void> invoke(FullScreenIntent intent) async {
    setFullScreen(!(await isFullScreen()));
  }
}
