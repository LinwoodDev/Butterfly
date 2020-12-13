import 'package:butterfly/pad/views/inspector.dart';
import 'package:butterfly/pad/views/layers.dart';
import 'package:butterfly/pad/views/main.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Project"), actions: [
          IconButton(
              icon: Icon(MdiIcons.cogOutline),
              tooltip: "Project settings",
              onPressed: _showProjectSettings),
          IconButton(icon: Icon(MdiIcons.export), tooltip: "Export", onPressed: () {}),
          IconButton(icon: Icon(MdiIcons.link), tooltip: "Share (not implemented)", onPressed: null)
        ]),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          bool isMobile = MediaQuery.of(context).size.width < 800;
          if (isMobile)
            return MainView();
          else
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SplitView(
                    axis: Axis.horizontal,
                    second: SplitWindow(
                        minSize: 200,
                        size: 250,
                        maxSize: 500,
                        builder: (BuildContext context, SplitView view, SplitWindow window,
                                bool expanded) =>
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
                            MainView(view: view, window: window, expanded: expanded))));
        }));
  }

  void _showProjectSettings() {
    showDialog(
        context: context,
        builder: (context) => Dialog(
            child: DefaultTabController(
                length: 2,
                child: Container(
                    constraints: BoxConstraints(maxWidth: 600, maxHeight: 800),
                    child: Column(children: [
                      TabBar(
                        tabs: [
                          Tab(icon: Icon(MdiIcons.tune), text: "General"),
                          Tab(icon: Icon(MdiIcons.packageVariantClosed), text: "Packs")
                        ],
                      ),
                      Expanded(
                          child: Container(
                              child: TabBarView(children: [
                        Icon(Icons.directions_car),
                        Icon(Icons.directions_transit)
                      ]))),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            RaisedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Ok", style: Theme.of(context).primaryTextTheme.button),
                                color: Theme.of(context).primaryColor)
                          ]))
                    ])))));
  }
}
