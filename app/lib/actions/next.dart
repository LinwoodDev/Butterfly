import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class NextIntent extends Intent {
  const NextIntent();
}

final nextShortcut = ShortcutDefinition(
  id: 'next',
  intent: const NextIntent(),
  defaultActivator: const SingleActivator(LogicalKeyboardKey.arrowRight),
);

class NextAction extends Action<NextIntent> {
  final BuildContext context;

  NextAction(this.context);

  @override
  void invoke(NextIntent intent) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentPresentationState) return;
    state.handler.play(bloc);
  }
}
