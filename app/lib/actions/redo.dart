import 'package:flutter/material.dart';

class RedoIntent extends Intent {
  final BuildContext context;

  const RedoIntent(this.context);
}

class RedoAction extends Action<RedoIntent> {
  RedoAction();

  @override
  void invoke(RedoIntent intent) {
    // reimplement undo
    // intent.context.read<DocumentBloc>().redo();
  }
}
