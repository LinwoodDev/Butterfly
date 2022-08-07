import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/pdf_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PdfExportIntent extends Intent {
  final BuildContext context;

  const PdfExportIntent(this.context);
}

class PdfExportAction extends Action<PdfExportIntent> {
  PdfExportAction();

  @override
  Future<void> invoke(PdfExportIntent intent) async {
    var bloc = intent.context.read<DocumentBloc>();
    showDialog(
        builder: (context) => BlocProvider.value(
              value: bloc,
              child: const PdfExportDialog(),
            ),
        context: intent.context);
  }
}
