import 'dart:async';
import 'dart:math';
import 'dart:ui' show Image;

import 'package:butterfly/models/area.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/element.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Image;

import '../cubits/transform.dart';
import '../models/background.dart';

part 'elements/eraser.dart';
part 'elements/image.dart';
part 'elements/label.dart';
part 'elements/path.dart';
part 'elements/pen.dart';

part 'backgrounds/empty.dart';
part 'backgrounds/box.dart';

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

  void _updateArea(AppDocument document) => area = rect == null
      ? null
      : document.areas.firstWhereOrNull((area) => area.rect.overlaps(rect!));
  FutureOr<void> onAreaUpdate(AppDocument document) async =>
      _updateArea(document);
  Rect? get rect => null;
  FutureOr<void> build(Canvas canvas, Size size, CameraTransform transform,
      [bool foreground = false]);
  HitCalculator? get hitCalculator =>
      rect == null ? null : DefaultHitCalculator(rect!);
  factory Renderer.fromInstance(T element) {
    // Elements
    if (element is PadElement) {
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
    }

    // Backgrounds
    if (element is Background) {
      if (element is EmptyBackground) {
        return EmptyBackgroundRenderer(element) as Renderer<T>;
      }
      if (element is BoxBackground) {
        return BoxBackgroundRenderer(element) as Renderer<T>;
      }
    }

    throw Exception('Invalid instance type');
  }

  T? move(Offset position) => null;
}
