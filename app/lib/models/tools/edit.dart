import 'package:butterfly/models/tools/type.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditTool extends Tool {
  @override
  List<Widget> buildOptions(
      {BuildContext? context,
      DocumentBloc? bloc,
      bool? expanded,
      bool? isMobile,
      SplitWindow? window,
      SplitView? view}) {
    return [
      IconButton(icon: Icon(PhosphorIcons.pencilLight), tooltip: "Pencil", onPressed: () {}),
      IconButton(icon: Icon(PhosphorIcons.markerCircleLight), tooltip: "Marker", onPressed: () {})
    ];
  }

  @override
  IconData get icon => PhosphorIcons.pencilLight;

  @override
  ToolType get type => ToolType.edit;

  @override
  String get name => "Edit";
}
