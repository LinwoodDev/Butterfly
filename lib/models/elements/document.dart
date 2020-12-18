import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/packs/collection.dart';

class AppDocument {
  String name;
  String description = "";
  ElementLayer root;
  PackCollection packs = PackCollection();

  AppDocument({this.name = "Test", this.description});
}
