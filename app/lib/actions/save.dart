import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/document_bloc.dart';
import '../embed/action.dart';

class SaveIntent extends Intent {
  final BuildContext context;

  const SaveIntent(this.context);
}

class SaveAction extends Action<SaveIntent> {
  SaveAction();

  @override
  void invoke(SaveIntent intent) {
    final bloc = intent.context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    if (state.embedding?.save ?? false) {
      sendEmbedMessage('save', json.encode(state.document.toJson()));
    } else {
      if (state.path == null) return;
      state.save();
      bloc.add(const DocumentSaved());
    }
  }
}
