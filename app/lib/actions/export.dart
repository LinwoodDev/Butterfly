import 'package:butterfly/api/save_data.dart';
import 'package:butterfly/bloc/document_bloc.dart';
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
    final bloc = intent.context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    saveData(intent.context, state.saveData().save());
  }
}
