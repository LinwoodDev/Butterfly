
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/file_system.dart';
import 'package:flutter/material.dart';

class OpenIntent extends Intent {
  final BuildContext context;

  const OpenIntent(this.context);
}

class OpenAction extends Action<OpenIntent> {
  final DocumentBloc bloc;

  OpenAction(this.bloc);

  @override
  void invoke(OpenIntent intent) {
    showDialog(
        context: intent.context,
        builder: (context) => FileSystemDialog(bloc: bloc)).then((value) {
      if (value != null) {
        return DocumentFileSystem.fromPlatform()
            .getDocument(value)
            .then((document) async {
          if (document == null) return;
          bloc.emit(DocumentLoadSuccess(document.load(), path: document.path));
        });
      }
    });
  }
}
