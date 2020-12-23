import 'package:butterfly/models/elements/paint.dart';

import 'container.dart';
import 'group.dart';
import 'layer.dart';

enum LayerType { container, group, paint }

extension LayerTypeExtension on LayerType {
  String getName() {
    switch (this) {
      case LayerType.container:
        return "Container";
      case LayerType.group:
        return "Group";
      case LayerType.paint:
        return "Paint";
    }
    return "";
  }

  ElementLayer create(String name, String description) {
    switch (this) {
      case LayerType.container:
        return LayerContainer(name: name, description: description);
      case LayerType.group:
        return GroupElement(name: name, description: description);
      case LayerType.paint:
        return PaintElement(name: name, description: description);
    }
    return null;
  }

  ElementLayer fromJson(Map<String, dynamic> json) {
    switch (this) {
      case LayerType.container:
        return LayerContainer.fromJson(json);
      case LayerType.group:
        return GroupElement.fromJson(json);
      case LayerType.paint:
        return PaintElement.fromJson(json);
    }
    return null;
  }

  Map<String, dynamic> toJson(Map<String, dynamic> json) {
    return Map.from(json)..addAll({"type": toString()});
  }
}
