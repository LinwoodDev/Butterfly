import 'package:butterfly/models/properties/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'element.dart';

class LabelElement extends ElementLayer {
  @override
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
  bool hit(Offset offset) {
    var tp = _createPainter();
    tp.layout();
    return (offset.dx - position.dx).abs() < tp.width &&
        (offset.dy - position.dy).abs() < tp.height;
  }

  LabelElement copyWith(
          {String? text, LabelProperty? property, Offset? position}) =>
      LabelElement(
          text: text ?? this.text,
          property: property ?? this.property,
          position: position ?? this.position);

  @override
  void paint(Canvas canvas, [bool preview = false]) {
    var tp = _createPainter();
    tp.layout();
    var current = position;
    tp.paint(canvas, current);
  }

  TextPainter _createPainter() => TextPainter(
      text: TextSpan(
          style: TextStyle(
              fontSize: property.size,
              fontStyle: property.italic ? FontStyle.italic : FontStyle.normal,
              color: property.color,
              fontWeight: property.fontWeight,
              letterSpacing: property.letterSpacing,
              decorationColor: property.decorationColor,
              decorationStyle: property.decorationStyle,
              decorationThickness: property.decorationThickness,
              decoration: TextDecoration.combine([
                if (property.underline) TextDecoration.underline,
                if (property.lineThrough) TextDecoration.lineThrough,
                if (property.overline) TextDecoration.overline,
              ])),
          text: text),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      textScaleFactor: 1.0);

  @override
  Rect get rect {
    var tp = _createPainter();
    tp.layout();
    return Rect.fromLTWH(position.dx, position.dy, tp.width, tp.height);
  }

  @override
  LabelElement moveBy(Offset offset) {
    return copyWith(position: position + offset);
  }
}
