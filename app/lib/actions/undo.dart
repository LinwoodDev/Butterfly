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
    bloc.sendUndo();
    await bloc.load();
    bloc.save();
  }
}
