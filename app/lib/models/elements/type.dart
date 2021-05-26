import 'package:butterfly/models/elements/paint.dart';
import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'container.dart';
import 'text.dart';

abstract class ElementLayer {
  final String? name;
  final String? description;

  final List<ElementLayer?> children = [];

  ElementLayer({required this.name, this.description = ''});

  static ElementLayer? fromJson(Map<String, dynamic>? json) =>
      LayerType.values.firstWhere((element) => element.toString() == json!['type']).fromJson(json);
  LayerType get type;
}

enum LayerType { container, text, paint }

extension LayerTypeExtension on LayerType {
  String get name {
    switch (this) {
      case LayerType.container:
        return "Container";
      case LayerType.text:
        return "Text";
      case LayerType.paint:
        return "Paint";
    }
  }

  IconData get icon {
    switch (this) {
      case LayerType.container:
        return PhosphorIcons.squareLight;
      case LayerType.text:
        return PhosphorIcons.textAlignLeftLight;
      case LayerType.paint:
        return PhosphorIcons.imageLight;
    }
  }

  ElementLayer create(String name, String description) {
    switch (this) {
      case LayerType.container:
        return LayerContainer(name: name, description: description);
      case LayerType.text:
        return GroupElement(name: name, description: description);
      case LayerType.paint:
        return PaintElement(name: name, description: description);
    }
  }

  ElementLayer? fromJson(Map<String, dynamic>? json) {
    switch (this) {
      case LayerType.container:
        return LayerContainer.fromJson(json!);
      case LayerType.text:
        return GroupElement.fromJson(json!);
      case LayerType.paint:
        return PaintElement.fromJson(json!);
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson(Map<String, dynamic> json) {
    return Map.from(json)..addAll({"type": toString()});
  }
}
