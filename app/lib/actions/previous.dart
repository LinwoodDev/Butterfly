import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviousIntent extends Intent {
  final BuildContext context;

  const PreviousIntent(this.context);
}

class PreviousAction extends Action<PreviousIntent> {
  PreviousAction();

  @override
  void invoke(PreviousIntent intent) {
    final bloc = intent.context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentPresentationState) return;
    state.handler.playReverse(bloc);
  }
}
