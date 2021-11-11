import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';

class RedoIntent extends Intent {
  const RedoIntent();
}

class RedoAction extends Action<RedoIntent> {
  final DocumentBloc bloc;

  RedoAction(this.bloc);

  @override
  void invoke(RedoIntent intent) {
    bloc.redo();
  }
}
