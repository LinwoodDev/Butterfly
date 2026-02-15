import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

import '../bloc/document_bloc.dart';

class RedoIntent extends Intent {
  const RedoIntent();
}

final redoShortcut = ShortcutDefinition(
  id: 'redo',
  intent: const RedoIntent(),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyY,
    control: true,
  ),
);

class RedoAction extends Action<RedoIntent> {
  final BuildContext context;

  RedoAction(this.context);

  @override
  Future<void> invoke(RedoIntent intent) async {
    final bloc = context.read<DocumentBloc>();
    bloc.sendRedo();
    bloc.reload();
  }
}
