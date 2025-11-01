import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/document_bloc.dart';
import '../cubits/current_index.dart';
import '../embed/action.dart';

class SaveIntent extends Intent {
  final BuildContext context;

  const SaveIntent(this.context);
}

class SaveAction extends Action<SaveIntent> {
  SaveAction();

  @override
  Future<void> invoke(SaveIntent intent) async {
    final bloc = intent.context.read<DocumentBloc>();
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
