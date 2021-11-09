import 'dart:convert';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/data_export.dart';
import 'package:flutter/material.dart';

class ExportIntent extends Intent {
  final BuildContext context;

  const ExportIntent(this.context);
}

class ExportAction extends Action<ExportIntent> {
  final DocumentBloc bloc;

  ExportAction(this.bloc);

  @override
  Future<void> invoke(ExportIntent intent) async {
    var data =
        json.encode((bloc.state as DocumentLoadSuccess).document.toJson());
    showDialog(
        context: intent.context,
        builder: (context) => ExportDialog(data: data));
  }
}
