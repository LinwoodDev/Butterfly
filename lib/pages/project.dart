import 'package:butterfly/views/pad/inspector.dart';
import 'package:butterfly/views/pad/layers.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum Tool { view, select, move, edit }

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  Tool currentTool = Tool.view;

  void _toggleTool(Tool tool) => setState(() => currentTool = currentTool == tool ? null : tool);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Project"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SplitView(
                axis: Axis.horizontal,
                second: SplitWindow(
                    minSize: 200,
                    size: 200,
                    maxSize: 500,
                    builder:
                        (BuildContext context, SplitView view, SplitWindow window, bool expanded) =>
                            SplitView(
                                axis: Axis.vertical,
                                first: SplitWindow(
                                  minSize: 100,
                                  size: 200,
                                  builder: (context, view, window, expanded) => SplitScaffold(
                                      view: view,
                                      window: window,
                                      expanded: expanded,
                                      title: "Layers",
                                      icon: Icon(MdiIcons.cubeOutline),
                                      body: LayersView()),
                                ),
                                second: SplitWindow(
                                    minSize: 100,
                                    builder: (BuildContext context, SplitView view,
                                            SplitWindow window, bool expanded) =>
                                        SplitScaffold(
                                            body: InspectorView(),
                                            title: "Inspector",
                                            view: view,
                                            icon: Icon(MdiIcons.tuneVertical),
                                            window: window,
                                            expanded: expanded)))),
                first: SplitWindow(
                    builder: (BuildContext context, SplitView view, SplitWindow window,
                            bool expanded) =>
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(children: [
                              Expanded(child: Center(child: FlutterLogo(size: 256))),
                              Container(
                                  color: Theme.of(context).canvasColor,
                                  child:
                                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    IconButton(
                                      icon: Icon(MdiIcons.cursorDefaultOutline),
                                      color: currentTool == Tool.view
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      onPressed: () => _toggleTool(Tool.view),
                                    ),
                                    IconButton(
                                      icon: Icon(MdiIcons.select),
                                      color: currentTool == Tool.select
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      onPressed: () => _toggleTool(Tool.select),
                                    ),
                                    IconButton(
                                      icon: Icon(MdiIcons.cursorMove),
                                      color: currentTool == Tool.move
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      onPressed: () => _toggleTool(Tool.move),
                                    ),
                                    IconButton(
                                      icon: Icon(MdiIcons.pencilOutline),
                                      color: currentTool == Tool.edit
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      onPressed: () => _toggleTool(Tool.edit),
                                    ),
                                    VerticalDivider(),
                                    if (currentTool == Tool.view) ...[
                                      IconButton(
                                        icon: Icon(MdiIcons.cubeOutline),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: Icon(MdiIcons.tuneVertical),
                                        onPressed: () {},
                                      )
                                    ]
                                  ]))
                            ]))))));
  }
}
