import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_sysapi/lw_sysapi.dart';

import '../services/import.dart';

class PasteIntent extends Intent {
  final BuildContext context;

  const PasteIntent(this.context);
}

class PasteAction extends Action<PasteIntent> {
  PasteAction();

  @override
  void invoke(PasteIntent intent) {
    final bloc = intent.context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final clipboard = intent.context.read<ClipboardManager>().getContent();
    if (clipboard == null) return;
    final importService = intent.context.read<ImportService>();
    try {
      importService.import(AssetFileType.values.byName(clipboard.type),
          clipboard.data, state.data);
    } catch (_) {}
  }
}
