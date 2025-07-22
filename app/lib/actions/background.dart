import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/background/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackgroundIntent extends Intent {
  final BuildContext context;

  const BackgroundIntent(this.context);
}

class BackgroundAction extends Action<BackgroundIntent> {
  BackgroundAction();

  @override
  Future<void> invoke(BackgroundIntent intent) {
    return showDialog<void>(
      context: intent.context,
      builder: (context) => BlocProvider.value(
        value: intent.context.read<DocumentBloc>(),
        child: const BackgroundDialog(),
      ),
    );
  }
}
