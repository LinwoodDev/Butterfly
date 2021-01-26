import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

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
      IconButton(icon: Icon(Mdi.selectAll), tooltip: "Select all", onPressed: () {}),
      IconButton(icon: Icon(Mdi.selectOff), tooltip: "Deselect", onPressed: () {}),
      IconButton(icon: Icon(Mdi.selectInverse), tooltip: "Select inverse", onPressed: () {}),
      VerticalDivider(),
      IconButton(icon: Icon(Mdi.plus), tooltip: "Add to selection", onPressed: () {}),
      IconButton(icon: Icon(Mdi.selection), tooltip: "Replace selection", onPressed: () {}),
      IconButton(icon: Icon(Mdi.minus), tooltip: "Remove from selection", onPressed: () {})
    ];
  }

  @override
  IconData get icon => Mdi.select;

  @override
  ToolType get type => ToolType.select;

  @override
  String get name => "Select";
}
