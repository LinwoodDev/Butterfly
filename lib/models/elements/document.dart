import 'package:butterfly/models/elements/layer.dart';

class AppDocument {
  String name;
  String description;
  List<LayerElement> elements = new List();

  AppDocument({this.name, this.description});
}
