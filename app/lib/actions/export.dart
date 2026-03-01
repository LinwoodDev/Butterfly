import 'package:butterfly/api/save.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class ExportIntent extends Intent {
  final bool isText;

  const ExportIntent({this.isText = false});
}

const exportShortcut = ShortcutDefinition(
  id: 'export',
  intent: ExportIntent(),
  defaultActivator: SingleActivator(LogicalKeyboardKey.keyE, control: true),
);

const exportTextShortcut = ShortcutDefinition(
  id: 'export_text',
  intent: ExportIntent(isText: true),
  defaultActivator: SingleActivator(
    LogicalKeyboardKey.keyE,
    control: true,
    shift: true,
  ),
);

class ExportAction extends Action<ExportIntent> {
  final BuildContext context;

  ExportAction(this.context);

  @override
  Future<void> invoke(ExportIntent intent) async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final data = (await state.saveData());
    exportData(context, data, isTextBased: intent.isText);
  }
}
