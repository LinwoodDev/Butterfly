import 'dart:convert';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/svg_export.dart';

class SvgExportIntent extends Intent {
  final BuildContext context;

  const SvgExportIntent(this.context);
}

class SvgExportAction extends Action<SvgExportIntent> {
  SvgExportAction();

  @override
  Future<void> invoke(SvgExportIntent intent) async {
    var bloc = intent.context.read<DocumentBloc>();
    var data =
        json.encode((bloc.state as DocumentLoadSuccess).document.toJson());
    showDialog(
        context: intent.context,
        builder: (context) => SvgExportDialog(data: data));
  }
}
