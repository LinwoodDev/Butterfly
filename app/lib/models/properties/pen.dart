import 'package:butterfly/api/svg_helper.dart';
import 'package:butterfly/models/properties/path.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class PenProperty extends PathProperty {
  final Color color;
  final bool fill;

  const PenProperty(
      {double strokeWidth = 5,
      double strokeMultiplier = 10,
      this.color = Colors.black,
      this.fill = false})
      : super(strokeWidth: strokeWidth, strokeMultiplier: strokeMultiplier);

  PenProperty.fromJson(Map<String, dynamic> json)
      : color = json['color'] != null ? Color(json['color']) : Colors.black,
        fill = json['fill'] ?? false,
        super.fromJson(json);

  factory PenProperty.fromSvg(XmlElement e) {
    var aStroke = e.getAttribute('stroke');
    var color = stringToColor(aStroke ?? 'black');
    var aFill = e.getAttribute('fill')?.toLowerCase();
    var fill = ['none', 'transparent'].contains(aFill) ? false : true;
    if (fill) {
      color = stringToColor(aFill ?? 'transparent');
    }
    return PenProperty(color: color, fill: fill);
  }

  @override
  PenProperty copyWith(
          {Color? color,
          bool? fill,
          double? strokeWidth,
          double? strokeMultiplier}) =>
      PenProperty(
          color: color ?? this.color,
          fill: fill ?? this.fill,
          strokeMultiplier: strokeMultiplier ?? this.strokeMultiplier,
          strokeWidth: strokeWidth ?? this.strokeWidth);

  @override
  Map<String, dynamic> toJson() => {
        'color': color.value,
        'strokeWidth': strokeWidth,
        'strokeMultiplier': strokeMultiplier,
        'fill': fill
      };
}
