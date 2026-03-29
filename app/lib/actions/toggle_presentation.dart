import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class TogglePresentationIntent extends Intent {
  const TogglePresentationIntent();
}

const togglePresentationShortcut = ShortcutDefinition(
  id: 'toggle_presentation',
  intent: TogglePresentationIntent(),
  defaultActivator: SingleActivator(LogicalKeyboardKey.space, control: true),
);

class TogglePresentationAction extends Action<TogglePresentationIntent> {
  final BuildContext context;

  TogglePresentationAction(this.context);

  @override
  void invoke(TogglePresentationIntent intent) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentPresentationState) return;
    state.handler.toggle(bloc);
  }
}
