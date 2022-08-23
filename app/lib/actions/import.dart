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
    showDialog(
            builder: (context) => const ImportDialog(), context: intent.context)
        .then((content) {
      if (content == null) return;
      GoRouter.of(intent.context)
          .push('/native?name=document.bfly&type=note', extra: content);
    });
  }
}
