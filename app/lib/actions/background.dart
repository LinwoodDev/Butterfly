import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/background/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class BackgroundIntent extends Intent {
  const BackgroundIntent();
}

final backgroundShortcut = ShortcutDefinition(
  id: 'background',
  intent: const BackgroundIntent(),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyB,
    control: true,
  ),
);

class BackgroundAction extends Action<BackgroundIntent> {
  final BuildContext context;

  BackgroundAction(this.context);

  @override
  Future<void> invoke(BackgroundIntent intent) {
    return showDialog<void>(
      context: context,
      builder: (context) => BlocProvider.value(
        value: this.context.read<DocumentBloc>(),
        child: const BackgroundDialog(),
      ),
    );
  }
}
