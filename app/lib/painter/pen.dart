import 'package:butterfly/painter/painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PenPainter extends Painter {
  final Color color;
  final double strokeWidth;
  final double strokeMultiplier;

  const PenPainter(
      {this.color = Colors.black,
      this.strokeWidth = 5,
      this.strokeMultiplier = 1,
      String name = ''})
      : super(name: name);
  PenPainter.fromJson(Map<String, dynamic> json)
      : color = json['color'] ?? Colors.black,
        strokeWidth = json['stroke-width'] ?? 5,
        strokeMultiplier = json['stroke-multiplier'] ?? 1,
        super.fromJson(json);
  PenPainter copyWith(
          {String? name, Color? color, double? strokeWidth, double? strokeMultiplier}) =>
      PenPainter(
          name: name ?? this.name,
          color: color ?? this.color,
          strokeWidth: strokeWidth ?? this.strokeWidth,
          strokeMultiplier: strokeMultiplier ?? this.strokeMultiplier);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      "type": "pen",
      "color": color,
      "stroke-width": strokeWidth,
      "stroke-multiplier": strokeMultiplier
    });
}
