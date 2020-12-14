import 'package:butterfly/models/elements/document.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

import 'inspector.dart';
import 'layers.dart';

class MainView extends StatefulWidget {
  final bool expanded;
  final SplitView view;
  final SplitWindow window;
  final AppDocument document;

  const MainView({Key key, this.expanded, this.view, this.window, this.document}) : super(key: key);
  @override
  _MainViewState createState() => _MainViewState();
}

enum Tool { view, select, move, edit }

class _MainViewState extends State<MainView> {
  Tool currentTool = Tool.view;

  void _toggleTool(Tool tool) => setState(() => currentTool = currentTool == tool ? null : tool);
  @override
  Widget build(BuildContext context) {
    bool isMobile = widget.window == null || widget.view == null || widget.expanded == null;
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Column(children: [
              Expanded(child: Center(child: FlutterLogo(size: 256))),
              Container(
                  color: Theme.of(context).canvasColor,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        IconButton(
                            icon: Icon(Mdi.cursorDefaultOutline),
                            color: currentTool == Tool.view ? Theme.of(context).primaryColor : null,
                            onPressed: () => _toggleTool(Tool.view)),
                        IconButton(
                            icon: Icon(Mdi.select),
                            color:
                                currentTool == Tool.select ? Theme.of(context).primaryColor : null,
                            onPressed: () => _toggleTool(Tool.select)),
                        IconButton(
                            icon: Icon(Mdi.cursorMove),
                            color: currentTool == Tool.move ? Theme.of(context).primaryColor : null,
                            onPressed: () => _toggleTool(Tool.move)),
                        IconButton(
                            icon: Icon(Mdi.pencilOutline),
                            color: currentTool == Tool.edit ? Theme.of(context).primaryColor : null,
                            onPressed: () => _toggleTool(Tool.edit)),
                        VerticalDivider(),
                        if (currentTool == Tool.view) ...[
                          if (isMobile) ...[
                            IconButton(
                                icon: Icon(Mdi.cubeOutline),
                                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LayersView(document: widget.document)))),
                            IconButton(
                                icon: Icon(Mdi.tuneVertical),
                                onPressed: () => Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => InspectorView())))
                          ] else ...[
                            IconButton(
                                icon:
                                    Icon(widget.expanded ? Mdi.windowMinimize : Mdi.windowMaximize),
                                onPressed: widget.expanded
                                    ? Navigator.of(context).pop
                                    : () =>
                                        widget.window.expand(context, widget.view, widget.window))
                          ]
                        ]
                      ])))
            ])));
  }
}
