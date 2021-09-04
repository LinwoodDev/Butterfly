import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/packs/background.dart';

class PackCollection {
  final String name;
  final String author;
  final String description;
  final String? website;

  final List<BackgroundPack> backgrounds = [];
  final List<ElementLayer> layers = [];

  PackCollection({required this.name, required this.author, this.description = "", this.website});
}
