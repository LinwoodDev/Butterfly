import 'dart:math';

import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class RotateIntent extends Intent {
  final bool clockwise;

  const RotateIntent({required this.clockwise});
}

/// Reserves the binding while it is held; pointer movement applies rotation.
class RotateDragIntent extends Intent {
  const RotateDragIntent();
}

const rotateDragShortcut = ShortcutDefinition(
  id: 'rotate_drag',
  intent: RotateDragIntent(),
  defaultActivator: SingleActivator(LogicalKeyboardKey.space, shift: true),
);

const rotateLeftShortcut = ShortcutDefinition(
  id: 'rotate_left',
  intent: RotateIntent(clockwise: false),
  defaultActivator: SingleActivator(
    LogicalKeyboardKey.arrowLeft,
    control: true,
    shift: true,
  ),
);

const rotateRightShortcut = ShortcutDefinition(
  id: 'rotate_right',
  intent: RotateIntent(clockwise: true),
  defaultActivator: SingleActivator(
    LogicalKeyboardKey.arrowRight,
    control: true,
    shift: true,
  ),
);

class RotateAction extends Action<RotateIntent> {
  final BuildContext context;

  RotateAction(this.context);

  static double step(ButterflySettings settings) =>
      settings.rotationStep * pi / 180;

  @override
  void invoke(RotateIntent intent) {
    final cubit = context.read<EditorController>();
    final viewport = cubit.rendererCubit.state.cameraViewport;
    final center = (viewport.viewportSize ?? viewport.toRealSize()).center(
      Offset.zero,
    );
    final step = RotateAction.step(cubit.settingsCubit.state);
    cubit.transformCubit.rotateConstrained(
      intent.clockwise ? step : -step,
      cursor: center,
      runtime: cubit,
    );
  }
}
