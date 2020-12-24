import 'package:butterfly/models/tools/type.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:mdi/mdi.dart';

class EditTool extends Tool {
  @override
  Widget buildInspector() {
    return ListView(children: []);
  }

  @override
  List<Widget> buildOptions(
      {BuildContext context,
      DocumentBloc bloc,
      bool expanded,
      bool isMobile,
      SplitWindow window,
      SplitView view}) {
    return [
      IconButton(icon: Icon(Mdi.pencilOutline), tooltip: "Pencil", onPressed: () {}),
      IconButton(icon: Icon(Mdi.marker), tooltip: "Marker", onPressed: () {}),
      VerticalDivider(),
      IconButton(icon: Icon(Mdi.hexagonOutline), tooltip: "Size", onPressed: () {}),
      IconButton(icon: Icon(Mdi.palette), tooltip: "Color", onPressed: () {})
    ];
  }

  @override
  IconData get icon => Mdi.pencilOutline;

  @override
  ToolType get type => ToolType.edit;

  @override
  String get name => "Edit";
}
