import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/file_system.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
            .getAsset(value)
            .then((document) async {
          if (document is! AppDocumentFile) return;
          Modular.to.navigate(
              Uri(path: '/', queryParameters: {'path': document.path})
                  .toString());
        });
      }
    });
  }
}
