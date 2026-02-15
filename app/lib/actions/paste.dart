import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

import '../services/import.dart';

class PasteIntent extends Intent {
  const PasteIntent();
}

final pasteShortcut = ShortcutDefinition(
  id: 'paste',
  intent: const PasteIntent(),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyV,
    control: true,
  ),
);

class PasteAction extends Action<PasteIntent> {
  final BuildContext context;

  PasteAction(this.context);

  @override
  Future<void> invoke(PasteIntent intent) async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final importService = context.read<ImportService>();
    try {
      importService.importClipboard(state.data).then((e) => e?.submit());
    } catch (_) {}
  }
}
