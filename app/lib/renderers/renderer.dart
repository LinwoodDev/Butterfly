import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' show Image;

import 'package:butterfly/helpers/offset_helper.dart';
import 'package:butterfly/helpers/rect_helper.dart';
import 'package:butterfly/models/area.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/element.dart';
import 'package:butterfly/models/tool.dart';
import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly/visualizer/int.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';

import '../cubits/current_index.dart';
import '../cubits/transform.dart';
import '../helpers/xml_helper.dart';
import '../models/background.dart';
import '../models/path_point.dart';
import '../models/property.dart';

part 'backgrounds/box.dart';
part 'backgrounds/empty.dart';
part 'elements/image.dart';
part 'elements/label.dart';
part 'elements/path.dart';
part 'elements/pen.dart';
part 'elements/shape.dart';
part 'elements/svg.dart';
part 'tool.dart';

class DefaultHitCalculator extends HitCalculator {
  final Rect? rect;

  DefaultHitCalculator(this.rect);

  @override
  bool hit(Rect rect) => this.rect?.overlaps(rect) ?? false;
}

abstract class HitCalculator {
  bool hit(Rect rect);
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
  FutureOr<bool> onAreaUpdate(AppDocument document, Area? area) async {
    if (area?.rect.overlaps(rect!) ?? false) {
      this.area = area;
    }
    return false;
  }

  Rect? get rect => null;
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]);
  HitCalculator getHitCalculator() => DefaultHitCalculator(rect);
  void buildSvg(XmlDocument xml, AppDocument document, Rect viewportRect) {}
  factory Renderer.fromInstance(T element) {
    // Elements
    if (element is PadElement) {
      return element.map(
        pen: (value) => PenRenderer(value),
        label: (value) => LabelRenderer(value),
        image: (value) => ImageRenderer(value),
        svg: (value) => SvgRenderer(value),
        shape: (value) => ShapeRenderer(value),
      ) as Renderer<T>;
    }

    // Backgrounds
    if (element is Background) {
      return element.map(
        empty: (value) => EmptyBackgroundRenderer(value),
        box: (value) => BoxBackgroundRenderer(value),
      ) as Renderer<T>;
    }

    if (element is ToolState) {
      return ToolRenderer(element) as Renderer<T>;
    }

    throw Exception('Invalid instance type');
  }

  Renderer<T>? transform(
          {Offset position = Offset.zero,
          double scaleX = 1,
          double scaleY = 1,
          bool relative = true}) =>
      null;
}
