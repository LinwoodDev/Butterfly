import 'dart:convert';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/document.dart';

class ImportIntent extends Intent {
  final BuildContext context;

  const ImportIntent(this.context);
}

class ImportAction extends Action<ImportIntent> {
  ImportAction();

  @override
  Future<void> invoke(ImportIntent intent) async {
    var bloc = intent.context.read<DocumentBloc>();
    showDialog(
            builder: (context) => const ImportDialog(), context: intent.context)
        .then((content) {
      if (content == null) return;
      var document =
          AppDocument.fromJson(Map<String, dynamic>.from(jsonDecode(content)));
      DocumentFileSystem.fromPlatform().importDocument(document).then((file) {
        bloc.emit(DocumentLoadSuccess(document, path: file.path));
      });
    });
  }
}
