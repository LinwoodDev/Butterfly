import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Area {
  final String name;
  final Offset position;
  final double width, height;

  const Area({
    this.name = '',
    required this.width,
    required this.height,
    required this.position,
  });

  Area.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : name = json['name'] ?? '',
        height = json['height'],
        width = json['width'],
        position = json['position'] != null
            ? Offset(json['position']['x'], json['position']['y'])
            : Offset.zero;
  // Aspect ratio is the ratio between width and height.
  factory Area.fromPoints(Offset first, Offset second,
      {double width = 0,
      double height = 0,
      double aspectRatio = 0,
      String name = ''}) {
    double realWidth = width;
    double realHeight = height;
    if (realWidth == 0) {
      realWidth = (second.dx - first.dx).abs();
    }
    if (realHeight == 0) {
      realHeight = (second.dy - first.dy).abs();
    }
    if (aspectRatio != 0 && height == 0) {
      realHeight = realWidth / aspectRatio;
    }
    if (aspectRatio != 0 && width == 0) {
      realWidth = realHeight * aspectRatio;
    }
    Offset position = Offset(
      first.dx > second.dx ? second.dx : first.dx,
      first.dy > second.dy ? second.dy : first.dy,
    );
    return Area(
        width: realWidth, height: realHeight, position: position, name: name);
  }

  Map<String, dynamic> toJson() => {
        'height': height,
        'width': width,
        'position': {'x': position.dx, 'y': position.dy},
        'name': name,
      };

  Offset get second => Offset(position.dx + width, position.dy + height);

  Area copyWith({
    double? width,
    double? height,
    Offset? position,
    String? name,
  }) {
    return Area(
      width: width ?? this.width,
      height: height ?? this.height,
      position: position ?? this.position,
      name: name ?? this.name,
    );
  }

  bool hit(Offset offset, [double radius = 1]) {
    return offset.dx >= position.dx - radius &&
        offset.dx <= position.dx + width + radius &&
        offset.dy >= position.dy - radius &&
        offset.dy <= position.dy + height + radius;
  }

  ui.Rect get rect => Rect.fromLTWH(position.dx, position.dy, width, height);

  Area moveBy(Offset offset) => copyWith(position: position + offset);
}
