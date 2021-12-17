import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/file_system.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenIntent extends Intent {
  final BuildContext context;

  const OpenIntent(this.context);
}

class OpenAction extends Action<OpenIntent> {
  OpenAction();

  @override
  void invoke(OpenIntent intent) {
    showDialog(
            context: intent.context,
            builder: (context) =>
                FileSystemDialog(bloc: intent.context.read<DocumentBloc>()))
        .then((value) {
      if (value != null) {
        return DocumentFileSystem.fromPlatform()
            .getAsset(value)
            .then((document) async {
          if (document is! AppDocumentFile) return;
          GoRouter.of(intent.context).go(
              Uri(path: '/', queryParameters: {'path': document.path})
                  .toString());
        });
      }
    });
  }
}
