enum LayerType { container, document, group, paint }

extension LayerTypeExtension on LayerType {
  String getName() {
    switch (this) {
      case LayerType.container:
        return "Container";
      case LayerType.document:
        return "Document";
      case LayerType.group:
        return "Group";
      case LayerType.paint:
        return "Paint";
    }
    return "";
  }
}
