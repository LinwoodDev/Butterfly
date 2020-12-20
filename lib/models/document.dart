import 'package:butterfly/models/elements/layer.dart';

import 'elements/container.dart';

class AppDocument {
  String name;
  String description;
  ElementLayer root = LayerContainer();
  AppDocument({this.name, this.description});
}
