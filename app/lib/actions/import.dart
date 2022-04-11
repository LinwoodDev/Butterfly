import 'dart:convert';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/import.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/converter.dart';
import '../renderers/renderer.dart';

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
      var document = const DocumentJsonConverter()
          .fromJson(Map<String, dynamic>.from(jsonDecode(content)));
      DocumentFileSystem.fromPlatform().importDocument(document).then((file) {
        final renderers =
            document.content.map((e) => Renderer.fromElement(e)).toList();
        Future.wait(renderers.map((e) async => await e.setup(document)));
        bloc.emit(DocumentLoadSuccess(document,
            path: file.path,
            cameraViewport: CameraViewport.unbaked(renderers)));
      });
    });
  }
}
