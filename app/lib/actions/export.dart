import 'dart:convert';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/data_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExportIntent extends Intent {
  final BuildContext context;

  const ExportIntent(this.context);
}

class ExportAction extends Action<ExportIntent> {
  ExportAction();

  @override
  Future<void> invoke(ExportIntent intent) async {
    var bloc = intent.context.read<DocumentBloc>();
    var data =
        json.encode((bloc.state as DocumentLoadSuccess).document.toJson());
    showDialog(
        context: intent.context,
        builder: (context) => ExportDialog(data: data));
  }
}
