import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../inspector.dart';
import 'edit.dart';
import 'object.dart';
import 'project.dart';
import 'select.dart';
import 'view.dart';

@immutable
abstract class Tool extends Equatable with InspectorItem {
  IconData get icon;
  List<Widget> buildOptions(
      {required BuildContext context,
      required DocumentLoadSuccess state,
      required bool? expanded,
      required bool isMobile,
      required GlobalKey<NavigatorState> navigator,
      required SplitWindow? window,
      required SplitView? view});
  ToolType get type;
  String get name;

  @override
  List<Object> get props => [type];

  const Tool();
  @override
  Widget buildInspector(DocumentBloc bloc) {
    return ListView(children: []);
  }
}

enum ToolType { project, view, select, object, edit }

extension ToolTypeExtension on ToolType {
  Tool create() {
    switch (this) {
      case ToolType.project:
        return ProjectTool();
      case ToolType.view:
        return ViewTool();
      case ToolType.select:
        return SelectTool();
      case ToolType.object:
        return ObjectTool();
      case ToolType.edit:
        return EditTool();
    }
  }
}
