import 'package:butterfly/cubits/current_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

import '../bloc/document_bloc.dart';

class ChangeToolIntent extends Intent {
  final int index;

  const ChangeToolIntent(this.index);
}

final changeToolShortcuts = List.generate(10, (index) {
  final key = [
    LogicalKeyboardKey.digit1,
    LogicalKeyboardKey.digit2,
    LogicalKeyboardKey.digit3,
    LogicalKeyboardKey.digit4,
    LogicalKeyboardKey.digit5,
    LogicalKeyboardKey.digit6,
    LogicalKeyboardKey.digit7,
    LogicalKeyboardKey.digit8,
    LogicalKeyboardKey.digit9,
    LogicalKeyboardKey.digit0,
  ][index];
  return ShortcutDefinition(
    id: 'tool_$index',
    intent: ChangeToolIntent(index),
    defaultActivator: SingleActivator(key, control: true),
  );
});

class ChangeToolAction extends Action<ChangeToolIntent> {
  final BuildContext context;

  ChangeToolAction(this.context);

  @override
  Future<void> invoke(ChangeToolIntent intent) async {
    final bloc = context.read<DocumentBloc>();
    context.read<CurrentIndexCubit>().changeTool(
      bloc,
      context: context,
      index: intent.index,
    );
  }
}
