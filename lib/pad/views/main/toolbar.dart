import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

import '../inspector.dart';
import '../layers.dart';
import '../project.dart';

enum Tool { view, select, move, edit }
enum SelectMode { add, replace, remove }

class MainViewToolbar extends StatefulWidget {
  final DocumentBloc documentBloc;
  final bool isMobile;
  final bool expanded;
  final SplitView view;
  final SplitWindow window;

  const MainViewToolbar(
      {Key key, this.documentBloc, this.isMobile, this.expanded, this.view, this.window})
      : super(key: key);

  @override
  _MainViewToolbarState createState() => _MainViewToolbarState();
}

class _MainViewToolbarState extends State<MainViewToolbar> {
  Tool currentTool = Tool.view;

  void _toggleTool(Tool tool) => setState(() => currentTool = tool);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(scrollDirection: Axis.horizontal, shrinkWrap: true, children: [
      IconButton(
          tooltip: "View",
          icon: Icon(Mdi.cursorDefaultOutline),
          color: currentTool == Tool.view ? Theme.of(context).primaryColor : null,
          onPressed: () => _toggleTool(Tool.view)),
      IconButton(
          tooltip: "Select",
          icon: Icon(Mdi.select),
          color: currentTool == Tool.select ? Theme.of(context).primaryColor : null,
          onPressed: () => _toggleTool(Tool.select)),
      IconButton(
          tooltip: "Move",
          icon: Icon(Mdi.cursorMove),
          color: currentTool == Tool.move ? Theme.of(context).primaryColor : null,
          onPressed: () => _toggleTool(Tool.move)),
      IconButton(
          tooltip: "Edit",
          icon: Icon(Mdi.pencilOutline),
          color: currentTool == Tool.edit ? Theme.of(context).primaryColor : null,
          onPressed: () => _toggleTool(Tool.edit)),
      if (currentTool != null) VerticalDivider(),
      ..._buildOptions(),
    ]);
  }

  List<Widget> _buildOptions() {
    switch (currentTool) {
      case Tool.view:
        return [
          if (widget.isMobile) ...[
            IconButton(
                icon: Icon(Mdi.cubeOutline),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LayersView(documentBloc: widget.documentBloc)))),
            IconButton(
                icon: Icon(Mdi.tuneVertical),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => InspectorView(documentBloc: widget.documentBloc)))),
            IconButton(
                icon: Icon(Mdi.tableOfContents),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProjectView(documentBloc: widget.documentBloc))))
          ] else ...[
            IconButton(
                icon: Icon(widget.expanded ? Mdi.windowMinimize : Mdi.windowMaximize),
                tooltip: widget.expanded ? 'Minimize' : 'Maximize',
                onPressed: widget.expanded
                    ? Navigator.of(context).pop
                    : () => widget.window.expand(context, widget.view, widget.window))
          ],
          VerticalDivider(),
          IconButton(icon: Icon(Mdi.magnifyPlus), tooltip: "Zoom in", onPressed: () {}),
          IconButton(icon: Icon(Mdi.magnify), tooltip: "Reset zoom", onPressed: () {}),
          IconButton(icon: Icon(Mdi.magnifyMinus), tooltip: "Zoom out", onPressed: () {}),
          VerticalDivider(),
          IconButton(icon: Icon(Mdi.export), tooltip: "Export", onPressed: () {}),
          IconButton(icon: Icon(Mdi.printer), tooltip: "Print", onPressed: () {}),
          IconButton(icon: Icon(Mdi.presentationPlay), tooltip: "Presentation", onPressed: () {}),
        ];
      case Tool.select:
        return [
          IconButton(icon: Icon(Mdi.selectAll), tooltip: "Select all", onPressed: () {}),
          IconButton(icon: Icon(Mdi.selectOff), tooltip: "Deselect", onPressed: () {}),
          IconButton(icon: Icon(Mdi.selectInverse), tooltip: "Select inverse", onPressed: () {}),
          VerticalDivider(),
          IconButton(icon: Icon(Mdi.plus), tooltip: "Add to selection", onPressed: () {}),
          IconButton(icon: Icon(Mdi.selection), tooltip: "Replace selection", onPressed: () {}),
          IconButton(icon: Icon(Mdi.minus), tooltip: "Remove from selection", onPressed: () {})
        ];
      case Tool.move:
        return [
          IconButton(icon: Icon(Mdi.crosshairs), tooltip: "Location", onPressed: () {}),
          IconButton(icon: Icon(Mdi.formatRotate90), tooltip: "Rotation", onPressed: () {}),
          IconButton(icon: Icon(Mdi.resize), tooltip: "Size", onPressed: () {})
        ];
      case Tool.edit:
        return [
          IconButton(icon: Icon(Mdi.pencilOutline), tooltip: "Pencil", onPressed: () {}),
          IconButton(icon: Icon(Mdi.marker), tooltip: "Marker", onPressed: () {}),
          VerticalDivider(),
          IconButton(icon: Icon(Mdi.hexagonOutline), tooltip: "Size", onPressed: () {}),
          IconButton(icon: Icon(Mdi.palette), tooltip: "Color", onPressed: () {})
        ];
    }
    return [];
  }
}
