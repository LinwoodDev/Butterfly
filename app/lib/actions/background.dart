import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/background.dart';
import 'package:flutter/material.dart';

class BackgroundIntent extends Intent {
  final BuildContext context;

  const BackgroundIntent(this.context);
}

class BackgroundAction extends Action<BackgroundIntent> {
  final DocumentBloc bloc;

  BackgroundAction(this.bloc);

  @override
  Object? invoke(BackgroundIntent intent) {
    showDialog(
      context: intent.context,
      builder: (context) => BackgroundDialog(bloc: bloc),
    );
  }
}
