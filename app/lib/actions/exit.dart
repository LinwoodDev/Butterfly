import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class ExitIntent extends Intent {
  const ExitIntent();
}

final exitShortcut = ShortcutDefinition(
  id: 'exit',
  intent: const ExitIntent(),
  defaultActivator: const SingleActivator(LogicalKeyboardKey.escape),
);

class ExitAction extends Action<ExitIntent> {
  final BuildContext context;

  ExitAction(this.context);

  @override
  void invoke(ExitIntent intent) {
    final bloc = context.read<DocumentBloc>();
    bloc.add(const PresentationModeExited());
  }
}
