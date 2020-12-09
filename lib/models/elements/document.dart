import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/packs/collection.dart';

class AppDocument {
  String name;
  String description;
  PackCollection packs;
  List<ElementLayer> elements = new List();

  AppDocument({this.name, this.description});
}
