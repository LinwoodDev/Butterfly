import 'package:butterfly/models/elements/type.dart';
import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsertTool extends Tool {
  @override
  List<Widget> buildOptions(
      {required BuildContext context,
      required DocumentLoadSuccess state,
      required bool? expanded,
      required bool isMobile,
      required GlobalKey<NavigatorState> navigator,
      required SplitWindow? window,
      required SplitView? view}) {
    return LayerType.values
        .map((e) => IconButton(onPressed: () {}, icon: Icon(e.icon), tooltip: e.name))
        .toList();
  }

  @override
  IconData get icon => PhosphorIcons.plusLight;

  @override
  ToolType get type => ToolType.insert;

  @override
  String get name => "Insert";
}
