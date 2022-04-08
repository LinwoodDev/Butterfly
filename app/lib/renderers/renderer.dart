import 'dart:async';
import 'dart:math';
import 'dart:ui' show Image;

import 'package:butterfly/models/area.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/element.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Image;

import '../cubits/transform.dart';

part 'eraser.dart';

part 'image.dart';

part 'label.dart';

part 'path.dart';

part 'pen.dart';

class DefaultHitCalculator extends HitCalculator {
  final Rect rect;

  DefaultHitCalculator(this.rect);

  @override
  bool hit(Offset position, [double radius = 1]) =>
      rect.inflate(radius).contains(position);
}

abstract class HitCalculator {
  bool hit(Offset position, [double radius = 1]);
}

abstract class Renderer<T> {
  final T element;
  Area? area;

  Renderer(this.element);

  @mustCallSuper
  FutureOr<void> setup(AppDocument document) async => _updateArea(document);

  void _updateArea(AppDocument document) => area =
      document.areas.firstWhereOrNull((area) => area.rect.overlaps(rect));
  FutureOr<void> onAreaUpdate(AppDocument document) async =>
      _updateArea(document);
  Rect get rect;
  FutureOr<void> build(Canvas canvas, CameraTransform transform,
      [bool foreground = false]);
  HitCalculator get hitCalculator => DefaultHitCalculator(rect);
  factory Renderer.fromElement(T element) {
    if (element is PenElement) {
      return PenRenderer(element) as Renderer<T>;
    }
    if (element is EraserElement) {
      return EraserRenderer(element) as Renderer<T>;
    }
    if (element is LabelElement) {
      return LabelRenderer(element) as Renderer<T>;
    }
    if (element is ImageElement) {
      return ImageRenderer(element) as Renderer<T>;
    }
    throw Exception('Invalid element type');
  }

  Renderer<T> move(Offset position);
}
