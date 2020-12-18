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
        return LayerContainer();
      case LayerType.group:
        return GroupElement();
      case LayerType.paint:
        return PaintElement();
    }
    return null;
  }
}
