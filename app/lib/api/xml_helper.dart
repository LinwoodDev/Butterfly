import 'package:xml/xml.dart';

extension XmlHelper on XmlNode {
  XmlElement createElement(String name,
      {String? id,
      String? className,
      Map<String, String> attributes = const {}}) {
    final element = XmlElement(XmlName(name));
    if (id != null) {
      element.attributes.add(XmlAttribute(XmlName('id'), id));
    }
    if (className != null) {
      element.attributes.add(XmlAttribute(XmlName('class'), className));
    }
    attributes.forEach((key, value) {
      element.attributes.add(XmlAttribute(XmlName(key), value));
    });
    addElement(element);
    return element;
  }

  void addElement(XmlElement element) {
    children.add(element);
  }

  XmlElement getOrCreateElement(String name, {String? id, String? className}) {
    var elements = findElements(name);
    if (id != null) {
      elements = elements
          .where((element) => element.attributes.any((attribute) =>
              attribute.name.local == 'id' && attribute.value == id))
          .toList();
    }
    if (className != null) {
      elements = elements
          .where((element) => element.attributes.any((attribute) =>
              attribute.name.local == 'class' && attribute.value == className))
          .toList();
    }
    if (elements.isEmpty) {
      return createElement(name, id: id, className: className);
    }
    return elements.last;
  }
}
