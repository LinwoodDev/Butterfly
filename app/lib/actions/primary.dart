import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryIntent extends Intent {
  final BuildContext context;

  const PrimaryIntent(this.context);
}

class PrimaryAction extends Action<PrimaryIntent> {
  PrimaryAction();

  @override
  void invoke(PrimaryIntent intent) {
    final bloc = intent.context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentPresentationState) return;
    state.handler.toggle(bloc);
  }
}
