import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../inspector.dart';
import 'edit.dart';
import 'object.dart';
import 'select.dart';
import 'view.dart';

@immutable
abstract class Tool extends Equatable with InspectorItem {
  IconData get icon;
  List<Widget> buildOptions(
      {BuildContext? context,
      DocumentBloc? bloc,
      bool? expanded,
      bool? isMobile,
      SplitWindow? window,
      SplitView? view});
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

enum ToolType { view, select, object, edit }

extension ToolTypeExtension on ToolType {
  Tool create() {
    switch (this) {
      case ToolType.edit:
        return EditTool();
      case ToolType.view:
        return ViewTool();
      case ToolType.select:
        return SelectTool();
      case ToolType.object:
        return ObjectTool();
    }
  }
}
