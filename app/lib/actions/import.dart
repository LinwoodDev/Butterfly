import 'dart:convert';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/import.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImportIntent extends Intent {
  final BuildContext context;

  const ImportIntent(this.context);
}

class ImportAction extends Action<ImportIntent> {
  final DocumentBloc bloc;

  ImportAction(this.bloc);

  @override
  Future<void> invoke(ImportIntent intent) async {
    showDialog(
            builder: (context) => const ImportDialog(), context: intent.context)
        .then((content) {
      if (content == null) return;
      SharedPreferences.getInstance().then((prefs) {
        var documents =
            List<String>.from(prefs.getStringList('documents') ?? []);
        documents.add(jsonEncode(content));
        prefs.setStringList('documents', documents);
        bloc.clearHistory();
        bloc.emit(DocumentLoadSuccess(AppDocument.fromJson(content),
            documentIndex: documents.length - 1));
      });
    });
  }
}
