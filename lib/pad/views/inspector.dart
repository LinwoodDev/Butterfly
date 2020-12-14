import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class InspectorView extends StatefulWidget {
  final SplitView view;
  final SplitWindow window;
  final bool expanded;

  const InspectorView({Key key, this.view, this.window, this.expanded}) : super(key: key);
  @override
  _InspectorViewState createState() => _InspectorViewState();
}

class _InspectorViewState extends State<InspectorView> {
  @override
  Widget build(BuildContext context) {
    return SplitScaffold(
        body: Container(
            child: ListView(
          children: [
            ExpansionTile(title: Text("Transform"), children: [Text("Some properties")])
          ],
        )),
        view: widget.view,
        window: widget.window,
        expanded: widget.expanded,
        title: 'Inspector',
        icon: Icon(Mdi.tuneVertical));
  }
}
