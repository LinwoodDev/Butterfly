import 'package:butterfly/models/elements/document.dart';
import 'package:flutter/material.dart';

class LayersView extends StatefulWidget {
  final AppDocument document;

  const LayersView({Key key, this.document}) : super(key: key);
  @override
  _LayersViewState createState() => _LayersViewState();
}

class _LayersViewState extends State<LayersView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [Text("Tree")],
    ));
  }
}
