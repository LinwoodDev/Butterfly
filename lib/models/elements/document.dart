import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/packs/collection.dart';
import 'package:flutter/material.dart';

class AppDocument extends ElementLayer {
  String name;
  String description;
  ElementLayer _currentLayer;
  PackCollection packs;
  List<ElementLayer> elements = [];

  ElementLayer get currentLayer => _currentLayer == null ? this : _currentLayer;
  set currentLayer(ElementLayer value) => _currentLayer = value == this ? null : value;

  AppDocument({this.name, this.description});

  @override
  Widget buildTile(BuildContext context, AppDocument document) {
    return ListTile(title: Text(name), subtitle: Text(description));
  }
}
