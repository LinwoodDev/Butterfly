import 'package:flutter/material.dart';

class InspectorView extends StatefulWidget {
  @override
  _InspectorViewState createState() => _InspectorViewState();
}

class _InspectorViewState extends State<InspectorView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        ExpansionTile(title: Text("Transform"), children: [Text("Some properties")])
      ],
    ));
  }
}
