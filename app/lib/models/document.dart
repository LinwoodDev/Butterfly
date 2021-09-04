import 'package:butterfly/models/elements/element.dart';

import 'elements/paint.dart';
import 'elements/text.dart';
import 'packs/collection.dart';

class AppDocument {
  final String name, description;
  final List<PackCollection> packs = [];
  final List<ElementLayer> content;

  AppDocument({required String name, String description = '', this.content = const []})
      : name = name,
        description = description;

  AppDocument.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        content = (json['content'] as List<Map<String, dynamic>>).map<ElementLayer>((e) {
          switch (e['type']) {
            case 'text':
              return TextElement.fromJson(e);
            case 'paint':
              return PaintElement.fromJson(e);
            default:
              throw Exception('Unknown element type: ${e['type']}');
          }
        }).toList();
  AppDocument copyWith({String? name, String? description}) {
    return AppDocument(name: name ?? this.name, description: description ?? this.description);
  }
}
