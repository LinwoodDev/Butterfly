import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SelectTool extends Tool {
  @override
  List<Widget> buildOptions(
      {required BuildContext context,
      required DocumentLoadSuccess state,
      required bool? expanded,
      required bool isMobile,
      required GlobalKey<NavigatorState> navigator,
      required SplitWindow? window,
      required SplitView? view}) {
    return [
      IconButton(icon: Icon(PhosphorIcons.xLight), tooltip: "Select all", onPressed: () {}),
      IconButton(icon: Icon(PhosphorIcons.divideLight), tooltip: "Deselect", onPressed: () {}),
      IconButton(
          icon: Icon(PhosphorIcons.percentLight), tooltip: "Select inverse", onPressed: () {}),
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
  IconData get icon => PhosphorIcons.mathOperationsLight;

  @override
  ToolType get type => ToolType.select;

  @override
  String get name => "Select";
}
