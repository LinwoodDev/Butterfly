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
  final double letterSpacing;

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
      this.letterSpacing = 0,
      this.decorationColor = Colors.black,
      this.decorationStyle = TextDecorationStyle.solid,
      this.decorationThickness = 1});
  LabelElement.fromJson(Map<String, dynamic> json, [String? fileVersion])
      : text = json['text'] ?? "",
        size = json['size'] ?? 12,
        letterSpacing = json['letterSpacing'] ?? 0,
        position = json['position'] != null
            ? Offset(json['position']['x'], json['position']['y'])
            : const Offset(0, 0),
        color = json['color'] == null ? Colors.black : Color(json['color']),
        fontWeight =
            json['fontWeight'] != null ? FontWeight.values[json['fontWeight']] : FontWeight.normal,
        lineThrough = json['lineThrough'] ?? false,
        underline = json['underline'] ?? false,
        overline = json['overline'] ?? false,
        italic = json['italic'] ?? false,
        decorationColor =
            json['decorationColor'] != null ? Color(json['decorationColor']) : Colors.black,
        decorationStyle = json['decorationStyle'] != null
            ? TextDecorationStyle.values[json['decorationStyle']]
            : TextDecorationStyle.solid,
        decorationThickness = json['decorationThickness'] ?? 1,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'type': 'label',
        'text': text,
        'size': size,
        'color': color.value,
        'position': {'x': position.dx, 'y': position.dy},
        'fontWeight': FontWeight.values.indexOf(fontWeight),
        'lineThrough': lineThrough,
        'underline': underline,
        'overline': overline,
        'italic': italic,
        'decorationColor': decorationColor.value,
        'decorationStyle': decorationStyle.index,
        'decorationThickness': decorationThickness,
        'letterSpacing': letterSpacing
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
