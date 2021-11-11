import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/settings.dart';
import 'package:flutter/material.dart';

class ProjectIntent extends Intent {
  final BuildContext context;

  const ProjectIntent(this.context);
}

class ProjectAction extends Action<ProjectIntent> {
  final DocumentBloc bloc;

  ProjectAction(this.bloc);

  @override
  Object? invoke(ProjectIntent intent) {
    showDialog(
        context: intent.context,
        builder: (context) => PadSettingsDialog(bloc: bloc));
  }
}
