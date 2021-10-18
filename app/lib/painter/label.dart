import 'package:flutter/material.dart';

import 'painter.dart';

class LabelPainter extends Painter {
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final bool lineThrough, underline, overline, italic;
  final Color decorationColor;
  final TextDecorationStyle decorationStyle;
  final double decorationThickness;

  const LabelPainter(
      {this.color = Colors.black,
      this.size = 12,
      String name = '',
      this.fontWeight = FontWeight.normal,
      this.lineThrough = false,
      this.underline = false,
      this.overline = false,
      this.italic = false,
      this.decorationColor = Colors.black,
      this.decorationStyle = TextDecorationStyle.solid,
      this.decorationThickness = 1})
      : super(name: name);
  LabelPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : color = json['color'] == null ? Colors.black : Color(json['color']),
        size = json['size'] ?? 12,
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
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      "type": "label",
      "color": color.value,
      "size": size,
      'font-weight': FontWeight.values.indexOf(fontWeight),
      'line-through': lineThrough,
      'underline': underline,
      'overline': overline,
      'italic': italic,
      'decoration-color': decorationColor.value,
      'decoration-style': decorationStyle.index,
      'decoration-thickness': decorationThickness
    });

  LabelPainter copyWith(
          {String? name,
          Color? color,
          double? size,
          FontWeight? fontWeight,
          bool? lineThrough,
          bool? underline,
          bool? overline,
          bool? italic,
          Color? decorationColor,
          TextDecorationStyle? decorationStyle,
          double? decorationThickness}) =>
      LabelPainter(
          name: name ?? this.name,
          color: color ?? this.color,
          size: size ?? this.size,
          fontWeight: fontWeight ?? this.fontWeight,
          lineThrough: lineThrough ?? this.lineThrough,
          underline: underline ?? this.underline,
          overline: overline ?? this.overline,
          italic: italic ?? this.italic,
          decorationColor: decorationColor ?? this.decorationColor,
          decorationStyle: decorationStyle ?? this.decorationStyle,
          decorationThickness: decorationThickness ?? this.decorationThickness);
}
