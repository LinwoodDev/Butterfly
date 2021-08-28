import 'elements/container.dart';
import 'elements/type.dart';
import 'packs/collection.dart';

class AppDocument {
  final String name, description;
  final List<PackCollection> packs = [];
  ElementLayer? root;

  AppDocument({required String name, String description = '', ElementLayer? root})
      : name = name,
        description = description,
        root = root ?? LayerContainer(name: 'root');

  AppDocument.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        root = ElementLayer.fromJson(json['root']);
  AppDocument copyWith({String? name, String? description}) {
    return AppDocument(name: name ?? this.name, description: description ?? this.description);
  }
}
