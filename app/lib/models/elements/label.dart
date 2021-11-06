import 'package:butterfly/models/properties/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'element.dart';

class LabelElement extends ElementLayer {
  final Offset position;
  final String text;
  final LabelProperty property;

  const LabelElement(
      {this.text = '',
      this.position = const Offset(0, 0),
      this.property = const LabelProperty()});
  LabelElement.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : text = json['text'] ?? '',
        property = LabelProperty.fromJson(json),
        position = json['position'] != null
            ? Offset(json['position']['x'], json['position']['y'])
            : const Offset(0, 0),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'type': 'label',
        'text': text,
        'position': {'x': position.dx, 'y': position.dy},
      }..addAll(property.toJson());

  @override
  bool hit(Offset offset) =>
      offset.dx >= position.dx &&
      offset.dy >= position.dy &&
      offset.dx <= position.dx + property.size &&
      offset.dy <= position.dy + property.size;

  LabelElement copyWith(
          {String? text, LabelProperty? property, Offset? position}) =>
      LabelElement(
          text: text ?? this.text,
          property: property ?? this.property,
          position: position ?? this.position);
}
