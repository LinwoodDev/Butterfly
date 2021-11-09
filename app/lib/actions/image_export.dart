import 'dart:convert';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/image_export.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageExportIntent extends Intent {
  final BuildContext context;

  const ImageExportIntent(this.context);
}

class ImageExportAction extends Action<ImageExportIntent> {
  final DocumentBloc bloc;

  ImageExportAction(this.bloc);

  @override
  Future<void> invoke(ImageExportIntent intent) async {
    showDialog(
            builder: (context) => ImageExportDialog(
                  bloc: bloc,
                ),
            context: intent.context)
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
