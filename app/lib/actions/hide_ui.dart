import 'package:butterfly/cubits/editor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class HideUIIntent extends Intent {
  const HideUIIntent();
}

const hideUIShortcut = ShortcutDefinition(
  id: 'hide_ui',
  intent: HideUIIntent(),
  defaultActivator: SingleActivator(LogicalKeyboardKey.f12),
);

class HideUIAction extends Action<HideUIIntent> {
  final BuildContext context;

  HideUIAction(this.context);

  @override
  void invoke(HideUIIntent intent) {
    context.read<EditorInputCubit>().toggleKeyboardHideUI();
  }
}
