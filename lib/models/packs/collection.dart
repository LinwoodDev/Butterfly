import 'package:butterfly/models/packs/background.dart';
import 'package:butterfly/models/packs/layer.dart';
import 'package:flutter/foundation.dart';

class PackCollection {
  final String name;
  final String author;
  final String description;
  final String website;

  final List<BackgroundPack> backgrounds = [];
  final List<LayerPack> layers = [];

  PackCollection({@required this.name, @required this.author, this.description = "", this.website});
}
