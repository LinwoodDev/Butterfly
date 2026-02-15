import 'package:butterfly/cubits/current_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class HideUIIntent extends Intent {
  const HideUIIntent();
}

final hideUIShortcut = ShortcutDefinition(
  id: 'hide_ui',
  intent: const HideUIIntent(),
  defaultActivator: const SingleActivator(LogicalKeyboardKey.f12),
);

class HideUIAction extends Action<HideUIIntent> {
  final BuildContext context;

  HideUIAction(this.context);

  @override
  void invoke(HideUIIntent intent) {
    context.read<CurrentIndexCubit>().toggleKeyboardHideUI();
  }
}
