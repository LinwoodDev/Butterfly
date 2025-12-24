import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class PreviousIntent extends Intent {
  const PreviousIntent();
}

final previousShortcut = ShortcutDefinition(
  id: 'previous',
  intent: const PreviousIntent(),
  defaultActivator: const SingleActivator(LogicalKeyboardKey.arrowLeft),
);

class PreviousAction extends Action<PreviousIntent> {
  final BuildContext context;

  PreviousAction(this.context);

  @override
  void invoke(PreviousIntent intent) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentPresentationState) return;
    state.handler.playReverse(bloc);
  }
}
