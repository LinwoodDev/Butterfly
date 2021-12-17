import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditModeIntent extends Intent {
  final BuildContext context;

  const EditModeIntent(this.context);
}

class EditModeAction extends Action<EditModeIntent> {
  EditModeAction();

  @override
  void invoke(EditModeIntent intent) {
    var bloc = intent.context.read<DocumentBloc>();
    if (bloc.state is DocumentLoadSuccess) {
      bloc.add(const CurrentPainterChanged(null));
    }
  }
}
