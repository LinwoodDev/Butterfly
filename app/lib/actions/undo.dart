import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UndoIntent extends Intent {
  final BuildContext context;

  const UndoIntent(this.context);
}

class UndoAction extends Action<UndoIntent> {
  UndoAction();

  @override
  void invoke(UndoIntent intent) {
    intent.context.read<DocumentBloc>().undo();
  }
}
