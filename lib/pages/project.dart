import 'package:butterfly/views/pad/inspector.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Project")),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SplitView(
                axis: Axis.horizontal,
                second: SplitWindow(
                    minSize: 200,
                    size: 200,
                    maxSize: 500,
                    builder:
                        (BuildContext context, SplitView view, SplitWindow window, bool expanded) {
                      return SplitScaffold(
                          title: "Inspector",
                          view: view,
                          window: window,
                          expanded: expanded,
                          body: InspectorView());
                    }),
                first: SplitWindow(
                    builder:
                        (BuildContext context, SplitView view, SplitWindow window, bool expanded) =>
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                    child: FlutterLogo(
                                  size: 256,
                                )))))));
  }
}
