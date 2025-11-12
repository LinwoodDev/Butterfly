import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/import.dart';

class PasteIntent extends Intent {
  final BuildContext context;

  const PasteIntent(this.context);
}

class PasteAction extends Action<PasteIntent> {
  PasteAction();

  @override
  Future<void> invoke(PasteIntent intent) async {
    final bloc = intent.context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final importService = intent.context.read<ImportService>();
    try {
      importService.importClipboard(state.data).then((e) => e?.submit());
    } catch (_) {}
  }
}
