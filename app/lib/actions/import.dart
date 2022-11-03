import 'package:butterfly/dialogs/import.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImportIntent extends Intent {
  final BuildContext context;

  const ImportIntent(this.context);
}

class ImportAction extends Action<ImportIntent> {
  ImportAction();

  @override
  Future<void> invoke(ImportIntent intent) async {
    final router = GoRouter.of(intent.context);
    final result = await showDialog<String>(
        builder: (context) => const ImportDialog(), context: intent.context);
    if (result == null) return;
    router.push('/native?name=document.bfly&type=note', extra: result);
  }
}
