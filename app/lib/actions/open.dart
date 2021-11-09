import 'dart:convert';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/file_system.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenIntent extends Intent {
  final BuildContext context;

  const OpenIntent(this.context);
}

class OpenAction extends Action<OpenIntent> {
  final DocumentBloc bloc;

  OpenAction(this.bloc);

  @override
  Object? invoke(OpenIntent intent) {
    showDialog(
            context: intent.context,
            builder: (context) => FileSystemDialog(bloc: bloc))
        .then((value) => SharedPreferences.getInstance().then((prefs) {
              if (value == null) return;
              bloc.clearHistory();
              var documents = prefs.getStringList('documents') ?? [];
              bloc.emit(DocumentLoadSuccess(
                  documents.length <= value
                      ? AppDocument(
                          name: '',
                          palettes:
                              ColorPalette.getMaterialPalette(intent.context),
                          createdAt: DateTime.now())
                      : AppDocument.fromJson(jsonDecode(documents[value])),
                  documentIndex: value));
            }));
  }
}
