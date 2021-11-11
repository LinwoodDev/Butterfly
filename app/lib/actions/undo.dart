import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';

class UndoIntent extends Intent {
  const UndoIntent();
}

class UndoAction extends Action<UndoIntent> {
  final DocumentBloc bloc;

  UndoAction(this.bloc);

  @override
  void invoke(UndoIntent intent) {
    bloc.undo();
  }
}
