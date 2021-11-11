import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';

class EditModeIntent extends Intent {
  const EditModeIntent();
}

class EditModeAction extends Action<EditModeIntent> {
  final DocumentBloc bloc;

  EditModeAction(this.bloc);

  @override
  void invoke(EditModeIntent intent) {
    if (bloc.state is DocumentLoadSuccess) {
      bloc.add(ToolChanged(!(bloc.state as DocumentLoadSuccess).editMode));
    }
  }
}
