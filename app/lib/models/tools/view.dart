import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/pad/views/inspector.dart';
import 'package:butterfly/pad/views/layers.dart';
import 'package:butterfly/pad/views/project.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ViewTool extends Tool {
  const ViewTool();
  @override
  Widget buildInspector(DocumentBloc bloc) {
    return (bloc.state as DocumentLoadSuccess).currentSelected!.buildInspector(bloc);
  }

  @override
  List<Widget> buildOptions(
      {BuildContext? context,
      DocumentBloc? bloc,
      bool? expanded,
      bool? isMobile,
      SplitWindow? window,
      SplitView? view}) {
    return [
      if (isMobile!) ...[
        IconButton(
            icon: Icon(MdiIcons.cubeOutline),
            onPressed: () =>
                Navigator.of(context!).push(MaterialPageRoute(builder: (context) => LayersView()))),
        IconButton(
            icon: Icon(MdiIcons.tuneVertical),
            onPressed: () => Navigator.of(context!)
                .push(MaterialPageRoute(builder: (context) => InspectorView()))),
        IconButton(
            icon: Icon(MdiIcons.tableOfContents),
            onPressed: () =>
                Navigator.of(context!).push(MaterialPageRoute(builder: (context) => ProjectView())))
      ] else ...[
        IconButton(
            icon: Icon(expanded! ? MdiIcons.windowMinimize : MdiIcons.windowMaximize),
            tooltip: expanded ? 'Minimize' : 'Maximize',
            onPressed: expanded
                ? Navigator.of(context!).pop
                : () => window!.expand(context!, view, window))
      ],
      VerticalDivider(),
      IconButton(icon: Icon(MdiIcons.magnifyPlus), tooltip: "Zoom in", onPressed: () {}),
      IconButton(icon: Icon(MdiIcons.magnify), tooltip: "Reset zoom", onPressed: () {}),
      IconButton(icon: Icon(MdiIcons.magnifyMinus), tooltip: "Zoom out", onPressed: () {}),
      VerticalDivider(),
      IconButton(icon: Icon(MdiIcons.export), tooltip: "Export", onPressed: () {}),
      IconButton(icon: Icon(MdiIcons.printer), tooltip: "Print", onPressed: () {}),
      IconButton(icon: Icon(MdiIcons.presentationPlay), tooltip: "Presentation", onPressed: () {}),
    ];
  }

  @override
  IconData get icon => MdiIcons.cursorDefaultOutline;

  @override
  ToolType get type => ToolType.view;

  @override
  String get name => "View";
}
