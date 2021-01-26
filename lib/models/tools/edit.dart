import 'package:butterfly/models/tools/type.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:mdi/mdi.dart';

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
      IconButton(icon: Icon(Mdi.pencilOutline), tooltip: "Pencil", onPressed: () {}),
      IconButton(icon: Icon(Mdi.marker), tooltip: "Marker", onPressed: () {})
    ];
  }

  @override
  IconData get icon => Mdi.pencilOutline;

  @override
  ToolType get type => ToolType.edit;

  @override
  String get name => "Edit";
}
