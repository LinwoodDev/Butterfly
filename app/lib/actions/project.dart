import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectIntent extends Intent {
  final BuildContext context;

  const ProjectIntent(this.context);
}

class ProjectAction extends Action<ProjectIntent> {
  ProjectAction();

  @override
  Future<dynamic> invoke(ProjectIntent intent) {
    return showDialog(
        context: intent.context,
        builder: (context) => BlocProvider.value(
            value: intent.context.read<DocumentBloc>(),
            child: PadSettingsDialog()));
  }
}
