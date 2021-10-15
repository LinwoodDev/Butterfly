import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'element.dart';

class LabelElement extends ElementLayer {
  final String text;
  final Color color;
  final double size;
  final Offset position;
  final FontWeight fontWeight;
  final bool lineThrough, underline, overline, italic;
  final Color decorationColor;
  final TextDecorationStyle decorationStyle;
  final double decorationThickness;

  const LabelElement(
      {this.text = "",
      this.size = 12,
      this.position = const Offset(0, 0),
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.lineThrough = false,
      this.underline = false,
      this.overline = false,
      this.italic = false,
      this.decorationColor = Colors.black,
      this.decorationStyle = TextDecorationStyle.solid,
      this.decorationThickness = 1});
  LabelElement.fromJson(Map<String, dynamic> json)
      : text = json['text'] ?? "",
        size = json['size'] ?? 12,
        position = json['position'] != null
            ? Offset(json['position']['x'], json['position']['y'])
            : const Offset(0, 0),
        color = json['color'] == null ? Colors.black : Color(json['color']),
        fontWeight = json['font-weight'] != null
            ? FontWeight.values[json['font-weight']]
            : FontWeight.normal,
        lineThrough = json['line-through'] ?? false,
        underline = json['underline'] ?? false,
        overline = json['overline'] ?? false,
        italic = json['italic'] ?? false,
        decorationColor =
            json['decoration-color'] != null ? Color(json['decoration-color']) : Colors.black,
        decorationStyle = json['decoration-style'] != null
            ? TextDecorationStyle.values[json['decoration-style']]
            : TextDecorationStyle.solid,
        decorationThickness = json['decoration-thickness'] ?? 1,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'type': 'label',
        'text': text,
        'size': size,
        'color': color.value,
        'position': {'x': position.dx, 'y': position.dy},
        'font-weight': FontWeight.values.indexOf(fontWeight),
        'line-through': lineThrough,
        'underline': underline,
        'overline': overline,
        'italic': italic,
        'decoration-color': decorationColor.value,
        'decoration-style': decorationStyle.index,
        'decoration-thickness': decorationThickness
      };

  @override
  bool hit(Offset offset) =>
      offset.dx >= position.dx &&
      offset.dy >= position.dy &&
      offset.dx <= position.dx + size &&
      offset.dy <= position.dy + size;

  LabelElement copyWith({String? text, Color? color, double? size, Offset? position}) =>
      LabelElement(
          text: text ?? this.text,
          color: color ?? this.color,
          size: size ?? this.size,
          position: position ?? this.position);
}
