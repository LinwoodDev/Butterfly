import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      IconButton(icon: Icon(PhosphorIcons.folderLight), tooltip: "Select all", onPressed: () {}),
      IconButton(icon: Icon(PhosphorIcons.trashLight), tooltip: "Deselect", onPressed: () {}),
      IconButton(
          icon: Icon(PhosphorIcons.arrowClockwiseLight),
          tooltip: "Select inverse",
          onPressed: () {}),
      VerticalDivider(),
      IconButton(
          icon: Icon(PhosphorIcons.plusLight), tooltip: "Add to selection", onPressed: () {}),
      IconButton(
          icon: Icon(PhosphorIcons.plusMinusLight), tooltip: "Replace selection", onPressed: () {}),
      IconButton(
          icon: Icon(PhosphorIcons.minusLight), tooltip: "Remove from selection", onPressed: () {})
    ];
  }

  @override
  IconData get icon => PhosphorIcons.plusMinusLight;

  @override
  ToolType get type => ToolType.select;

  @override
  String get name => "Select";
}
