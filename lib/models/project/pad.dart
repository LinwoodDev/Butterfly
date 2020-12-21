import 'package:butterfly/models/elements/container.dart';
import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/packs/collection.dart';

import 'item.dart';

class PadProjectItem extends ProjectItem {
  String name;
  String description = "";
  ElementLayer root = LayerContainer();

  PadProjectItem({this.name = "Test", this.description});
}
