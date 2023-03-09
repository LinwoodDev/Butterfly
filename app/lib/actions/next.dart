import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextIntent extends Intent {
  final BuildContext context;

  const NextIntent(this.context);
}

class NextAction extends Action<NextIntent> {
  NextAction();

  @override
  void invoke(NextIntent intent) {
    final bloc = intent.context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentPresentationState) return;
    state.handler.play(bloc);
  }
}
