import 'package:butterfly/painter/painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PenPainter extends Painter {
  final Color color;
  final double strokeWidth;
  final double strokeMultiplier;
  final bool fill;

  const PenPainter(
      {this.color = Colors.black,
      this.strokeWidth = 5,
      this.strokeMultiplier = 1,
      this.fill = false,
      String name = ''})
      : super(name: name);
  PenPainter.fromJson(Map<String, dynamic> json, [String? fileVersion])
      : color = json['color'] == null ? Colors.black : Color(json['color']),
        strokeWidth = json['strokeWidth'] ?? 5,
        strokeMultiplier = json['strokeMultiplier'] ?? 1,
        fill = json['fill'] ?? false,
        super.fromJson(json);
  PenPainter copyWith(
          {String? name,
          Color? color,
          double? strokeWidth,
          double? strokeMultiplier,
          bool? fill}) =>
      PenPainter(
          name: name ?? this.name,
          color: color ?? this.color,
          strokeWidth: strokeWidth ?? this.strokeWidth,
          strokeMultiplier: strokeMultiplier ?? this.strokeMultiplier,
          fill: fill ?? this.fill);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      "type": "pen",
      "color": color.value,
      "strokeWidth": strokeWidth,
      "strokeMultiplier": strokeMultiplier,
      "fill": fill
    });
}
