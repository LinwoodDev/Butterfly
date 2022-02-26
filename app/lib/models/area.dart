import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Area {
  final Offset position;
  final double width, height;

  const Area({
    required this.width,
    required this.height,
    required this.position,
  });

  Area.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : height = json['height'],
        width = json['width'],
        position = json['position'] != null
            ? Offset(json['position']['x'], json['position']['y'])
            : Offset.zero;
  Area.fromPoints(Offset first, Offset second)
      : position = Offset(first.dx < second.dx ? first.dx : second.dx,
            first.dy < second.dy ? first.dy : second.dy),
        width = (second.dx - first.dx).abs(),
        height = (second.dy - first.dy).abs();

  Map<String, dynamic> toJson() => {
        'height': height,
        'width': width,
        'position': {'x': position.dx, 'y': position.dy}
      };

  Offset get second => Offset(position.dx + width, position.dy + height);

  Area copyWith({
    double? width,
    double? height,
    Offset? position,
  }) {
    return Area(
      width: width ?? this.width,
      height: height ?? this.height,
      position: position ?? this.position,
    );
  }

  bool hit(Offset offset, [double radius = 1]) {
    return offset.dx >= position.dx &&
        offset.dy >= position.dy &&
        offset.dx <= position.dx + width &&
        offset.dy <= position.dy + height;
  }

  ui.Rect get rect => Rect.fromLTWH(position.dx, position.dy, width, height);

  Area moveBy(Offset offset) => copyWith(position: position + offset);
}
