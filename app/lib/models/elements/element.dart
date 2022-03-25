import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show Vector2;

import '../area.dart';
import '../property.dart';

part 'path.dart';
part 'eraser.dart';
part 'image.dart';
part 'label.dart';
part 'pen.dart';
part 'positioned.dart';

@immutable
abstract class PadElement {
  final String layer;

  const PadElement({this.layer = ''});

  @mustCallSuper
  PadElement.fromJson(Map<String, dynamic> json) : layer = json['layer'] ?? '';

  @mustCallSuper
  Map<String, dynamic> toJson() => {'layer': layer, 'type': type.name};

  PadElement moveBy(Offset offset);

  Offset get position;

  PadElement moveTo(Offset offset) {
    return moveBy(offset - position);
  }

  bool hit(Offset offset, [double radius = 1.0]);

  ui.Rect get rect;

  ElementType get type;

  bool inArea(Area area) => area.rect.overlaps(rect);

  PadElement copyWith({String? layer});

  void paint(ui.Canvas canvas, bool preview) {}
}

enum ElementType { pen, eraser, image, label }

extension ElementTypeExtension on ElementType {
  PadElement create({String layer = '', Offset position = Offset.zero}) {
    switch (this) {
      case ElementType.pen:
        return PenElement(layer: layer);
      case ElementType.eraser:
        return EraserElement(layer: layer);
      case ElementType.image:
        return ImageElement(
            pixels: Uint8List.fromList([]),
            width: 0,
            height: 0,
            position: position);
      case ElementType.label:
        return LabelElement(layer: layer, position: position);
    }
  }
}
