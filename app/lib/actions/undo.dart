import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/document_bloc.dart';

class UndoIntent extends Intent {
  final BuildContext context;

  const UndoIntent(this.context);
}

class UndoAction extends Action<UndoIntent> {
  UndoAction();

  @override
  Future<void> invoke(UndoIntent intent) async {
    final bloc = intent.context.read<DocumentBloc>();
    bloc.undo();
    await bloc.load();
    bloc.bake();
  }
}
