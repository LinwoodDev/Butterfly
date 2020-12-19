import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/packs/collection.dart';
import 'package:flutter/rendering.dart';

import 'container.dart';

class AppDocument {
  String name;
  String description = "";
  ElementLayer root = LayerContainer();
  PackCollection packs = PackCollection();

  AppDocument({this.name = "Test", this.description});
}
