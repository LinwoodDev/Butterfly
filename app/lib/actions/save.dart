import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

import '../bloc/document_bloc.dart';
import '../cubits/current_index.dart';
import '../embed/action.dart';

class SaveIntent extends Intent {
  const SaveIntent();
}

final saveShortcut = ShortcutDefinition(
  id: 'save',
  intent: const SaveIntent(),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyS,
    control: true,
  ),
);

class SaveAction extends Action<SaveIntent> {
  final BuildContext context;

  SaveAction(this.context);

  @override
  Future<void> invoke(SaveIntent intent) async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    if (state.embedding?.save ?? false) {
      sendEmbedMessage('save', (await state.saveData()).exportAsBytes());
      state.currentIndexCubit.setSaveState(saved: SaveState.saved);
    } else {
      await bloc.save(force: true);
    }
  }
}
