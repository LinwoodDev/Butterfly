import 'package:butterfly/pad/views/inspector.dart';
import 'package:butterfly/pad/views/layers.dart';
import 'package:butterfly/pad/views/project.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

import 'type.dart';

class MoveTool extends Tool {
  @override
  Widget buildInspector() {
    return ListView(children: [
      Row(children: [
        TextField(decoration: InputDecoration(labelText: "X")),
        TextField(decoration: InputDecoration(labelText: "Y")),
        TextField(decoration: InputDecoration(labelText: "Z"))
      ])
    ]);
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
      IconButton(icon: Icon(Mdi.crosshairs), tooltip: "Location", onPressed: () {}),
      IconButton(icon: Icon(Mdi.formatRotate90), tooltip: "Rotation", onPressed: () {}),
      IconButton(icon: Icon(Mdi.resize), tooltip: "Size", onPressed: () {})
    ];
  }

  @override
  IconData get icon => Mdi.cursorMove;

  @override
  ToolType get type => ToolType.move;

  @override
  String get name => "Move";
}
