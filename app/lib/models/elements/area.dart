import 'dart:ui' as ui;

import 'package:butterfly/models/elements/element.dart';
import 'package:flutter/material.dart';

class AreaElement extends PadElement {
  @override
  final Offset position;
  final double width, height;

  const AreaElement({
    required this.width,
    required this.height,
    required this.position,
    String layer = '',
  }) : super(layer: layer);

  AreaElement.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : height = json['height'],
        width = json['width'],
        position = json['position'] != null
            ? Offset(json['position']['x'], json['position']['y'])
            : Offset.zero;

  @override
  Map<String, dynamic> toJson() => {
        'height': height,
        'width': width,
        'type': 'area',
        'position': {'x': position.dx, 'y': position.dy}
      }..addAll(super.toJson());

  @override
  AreaElement copyWith({
    String? layer,
    double? width,
    double? height,
    Offset? position,
  }) {
    return AreaElement(
      layer: layer ?? this.layer,
      width: width ?? this.width,
      height: height ?? this.height,
      position: position ?? this.position,
    );
  }

  @override
  bool hit(Offset offset, [double radius = 1]) {
    return offset.dx >= position.dx &&
        offset.dy >= position.dy &&
        offset.dx <= position.dx + width &&
        offset.dy <= position.dy + height;
  }

  @override
  void paint(Canvas canvas, [bool preview = false]) =>
      throw UnimplementedError();

  @override
  ui.Rect get rect => Rect.fromLTWH(position.dx, position.dy, width, height);

  @override
  AreaElement moveBy(Offset offset) => copyWith(position: position + offset);
}
