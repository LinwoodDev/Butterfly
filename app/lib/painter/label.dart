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
  final double letterSpacing;

  const LabelPainter(
      {this.color = Colors.black,
      this.size = 12,
      String name = '',
      this.fontWeight = FontWeight.normal,
      this.lineThrough = false,
      this.underline = false,
      this.overline = false,
      this.italic = false,
      this.letterSpacing = 0,
      this.decorationColor = Colors.black,
      this.decorationStyle = TextDecorationStyle.solid,
      this.decorationThickness = 1})
      : super(name: name);
  LabelPainter.fromJson(Map<String, dynamic> json, [String? fileVersion])
      : color = json['color'] == null ? Colors.black : Color(json['color']),
        size = json['size'] ?? 12,
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
        letterSpacing = json['letterSpacing'] ?? 0,
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      "type": "label",
      "color": color.value,
      "size": size,
      'fontWeight': FontWeight.values.indexOf(fontWeight),
      'lineThrough': lineThrough,
      'underline': underline,
      'overline': overline,
      'italic': italic,
      'decorationColor': decorationColor.value,
      'decorationStyle': decorationStyle.index,
      'decorationThickness': decorationThickness,
      'letterSpacing': letterSpacing
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
          double? decorationThickness,
          double? letterSpacing}) =>
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
          decorationThickness: decorationThickness ?? this.decorationThickness,
          letterSpacing: letterSpacing ?? this.letterSpacing);
}
