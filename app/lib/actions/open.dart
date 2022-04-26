import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/file_system/dialog.dart';

class OpenIntent extends Intent {
  final BuildContext context;

  const OpenIntent(this.context);
}

class OpenAction extends Action<OpenIntent> {
  OpenAction();

  @override
  void invoke(OpenIntent intent) {
    var bloc = intent.context.read<DocumentBloc>();
    showDialog(
        context: intent.context,
        builder: (context) => FileSystemDialog(bloc: bloc)).then((value) {
      if (value != null) {
        return DocumentFileSystem.fromPlatform()
            .getAsset(value)
            .then((document) async {
          if (document is! AppDocumentFile) return;
          GoRouter.of(intent.context)
              .goNamed('home', queryParams: {'path': document.path});
        });
      }
    });
  }
}
