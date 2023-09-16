import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExitIntent extends Intent {
  final BuildContext context;

  const ExitIntent(this.context);
}

class ExitAction extends Action<ExitIntent> {
  ExitAction();

  @override
  void invoke(ExitIntent intent) {
    final bloc = intent.context.read<DocumentBloc>();
    bloc.add(const PresentationModeExited());
  }
}
