import 'package:butterfly/models/elements/document.dart';
import 'package:butterfly/pad/dialogs/create_layer.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class LayersView extends StatefulWidget {
  final AppDocument document;
  final SplitView view;
  final SplitWindow window;
  final bool expanded;

  const LayersView({Key key, this.document, this.view, this.window, this.expanded})
      : super(key: key);
  @override
  _LayersViewState createState() => _LayersViewState();
}

class _LayersViewState extends State<LayersView> {
  @override
  Widget build(BuildContext context) {
    return SplitScaffold(
        view: widget.view,
        window: widget.window,
        expanded: widget.expanded,
        title: "Layers",
        icon: Icon(Mdi.cubeOutline),
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                showDialog(builder: (context) => CreateLayerDialog(), context: context),
            child: Icon(Mdi.plus),
            tooltip: "Create layer"),
        body: Container(
            child: ListView.builder(
                itemCount: widget.document.currentLayer.children.length,
                itemBuilder: (BuildContext context, int index) => Builder(
                    builder: (context) => widget.document.currentLayer.children[index]
                        .buildTile(context, widget.document)))));
  }
}
