import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SelectTool extends Tool {
  @override
  List<Widget> buildOptions(
      {BuildContext? context,
      DocumentBloc? bloc,
      bool? expanded,
      bool? isMobile,
      SplitWindow? window,
      SplitView? view}) {
    return [
      IconButton(icon: Icon(MdiIcons.selectAll), tooltip: "Select all", onPressed: () {}),
      IconButton(icon: Icon(MdiIcons.selectOff), tooltip: "Deselect", onPressed: () {}),
      IconButton(icon: Icon(MdiIcons.selectInverse), tooltip: "Select inverse", onPressed: () {}),
      VerticalDivider(),
      IconButton(icon: Icon(MdiIcons.plus), tooltip: "Add to selection", onPressed: () {}),
      IconButton(icon: Icon(MdiIcons.selection), tooltip: "Replace selection", onPressed: () {}),
      IconButton(icon: Icon(MdiIcons.minus), tooltip: "Remove from selection", onPressed: () {})
    ];
  }

  @override
  IconData get icon => MdiIcons.select;

  @override
  ToolType get type => ToolType.select;

  @override
  String get name => "Select";
}
