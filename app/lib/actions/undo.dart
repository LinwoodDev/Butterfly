import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

import '../bloc/document_bloc.dart';

class UndoIntent extends Intent {
  const UndoIntent();
}

const undoShortcut = ShortcutDefinition(
  id: 'undo',
  intent: UndoIntent(),
  defaultActivator: SingleActivator(LogicalKeyboardKey.keyZ, control: true),
);

class UndoAction extends Action<UndoIntent> {
  final BuildContext context;

  UndoAction(this.context);

  @override
  Future<void> invoke(UndoIntent intent) async {
    final bloc = context.read<DocumentBloc>();
    bloc.sendUndo();
    bloc.reload();
  }
}
