import 'package:flutter/material.dart';

class UndoIntent extends Intent {
  final BuildContext context;

  const UndoIntent(this.context);
}

class UndoAction extends Action<UndoIntent> {
  UndoAction();

  @override
  void invoke(UndoIntent intent) {
    // reimplement undo
    //intent.context.read<DocumentBloc>().undo();
  }
}
