import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
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
    final cubit = intent.context.read<CurrentIndexCubit>();
    final bloc = intent.context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    cubit.reset(state.document);
  }
}
