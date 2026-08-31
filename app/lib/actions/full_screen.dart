import 'package:butterfly/cubits/editor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';
import 'package:material_leap/material_leap.dart';

class FullScreenIntent extends Intent {
  const FullScreenIntent();
}

const fullScreenShortcut = ShortcutDefinition(
  id: 'full_screen',
  intent: FullScreenIntent(),
  defaultActivator: SingleActivator(LogicalKeyboardKey.f11),
);

Future<void> toggleFullScreen(
  EditorController editorController,
  WindowCubit windowCubit,
) {
  final saveCubit = editorController.saveCubit;
  final embedding = saveCubit.state.embedding;
  if (embedding != null) {
    if (!embedding.fullScreen.canToggle) return Future.value();
    final value = !saveCubit.state.fullScreen;
    saveCubit.changeFullScreen(value);
    if (!embedding.fullScreen.usesNativeFullScreen) {
      return Future.value();
    }
    return windowCubit.changeFullScreen(value);
  }
  return windowCubit.toggleFullScreen();
}

class FullScreenAction extends Action<FullScreenIntent> {
  final EditorController editorController;
  final WindowCubit windowCubit;

  FullScreenAction(BuildContext context)
    : editorController = context.read<EditorController>(),
      windowCubit = context.read<WindowCubit>();

  @override
  Future<void> invoke(FullScreenIntent intent) async {
    await toggleFullScreen(editorController, windowCubit);
  }
}
