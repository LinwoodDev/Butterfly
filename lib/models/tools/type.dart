import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../inspector.dart';
import 'edit.dart';
import 'move.dart';
import 'select.dart';
import 'view.dart';

abstract class Tool extends Equatable with InspectorItem {
  IconData get icon;
  List<Widget> buildOptions(
      {BuildContext context,
      DocumentBloc bloc,
      bool expanded,
      bool isMobile,
      SplitWindow window,
      SplitView view});
  ToolType get type;
  String get name;

  @override
  List<Object> get props => [type];
}

enum ToolType { view, select, move, edit }

extension ToolTypeExtension on ToolType {
  Tool create() {
    switch (this) {
      case ToolType.edit:
        return EditTool();
      case ToolType.view:
        return ViewTool();
      case ToolType.select:
        return SelectTool();
      case ToolType.move:
        return MoveTool();
    }
    return null;
  }
}
