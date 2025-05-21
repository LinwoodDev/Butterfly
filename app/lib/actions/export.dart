import 'package:butterfly/api/save.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExportIntent extends Intent {
  final BuildContext context;
  final bool isText;

  const ExportIntent(this.context, {this.isText = false});
}

class ExportAction extends Action<ExportIntent> {
  ExportAction();

  @override
  Future<void> invoke(ExportIntent intent) async {
    final bloc = intent.context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final data = (await state.saveData());
    if (intent.isText) {
      exportTextData(intent.context, data.exportAsText());
    } else {
      exportData(intent.context, data.exportAsBytes());
    }
  }
}
