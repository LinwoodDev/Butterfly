import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../inspector.dart';
import 'edit.dart';
import 'insert.dart';
import 'object.dart';
import 'select.dart';
import 'view.dart';

@immutable
abstract class Tool extends Equatable with InspectorItem {
  IconData get icon;
  IconData? get activeIcon;
  List<Widget> buildOptions({required BuildContext context, required DocumentLoadSuccess state});
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

enum ToolType { view, select, object, edit, insert }

extension ToolTypeExtension on ToolType {
  Tool create() {
    switch (this) {
      case ToolType.view:
        return ViewTool();
      case ToolType.select:
        return SelectTool();
      case ToolType.object:
        return ObjectTool();
      case ToolType.edit:
        return EditTool();
      case ToolType.insert:
        return InsertTool();
    }
  }
}
