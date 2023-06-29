import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:butterfly/helpers/element_helper.dart';
import 'package:butterfly/helpers/offset_helper.dart';
import 'package:butterfly/helpers/rect_helper.dart';
import 'package:butterfly/helpers/point_helper.dart';
import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly/visualizer/text.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:material_leap/material_leap.dart';
import 'package:perfect_freehand/perfect_freehand.dart' as freehand;
import 'package:xml/xml.dart';

import '../cubits/current_index.dart';
import '../cubits/transform.dart';
import '../helpers/xml_helper.dart';
import '../models/label.dart';
import '../models/tool.dart';
import '../services/asset.dart';

part 'backgrounds/box.dart';
part 'backgrounds/empty.dart';
part 'elements/image.dart';
part 'elements/markdown.dart';
part 'elements/text.dart';
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

  double get rotation =>
      element is PadElement ? (element as PadElement).rotation : 0.0;

  @mustCallSuper
  FutureOr<void> setup(NoteData document, AssetService assetService,
          DocumentPage page) async =>
      _updateArea(page);

  void dispose() {}

  void _updateArea(DocumentPage page) => area = rect == null
      ? null
      : page.areas.firstWhereOrNull((area) => area.rect.overlaps(rect!));
  FutureOr<bool> onAreaUpdate(DocumentPage page, Area? area) async {
    if (area?.rect.overlaps(rect!) ?? false) {
      this.area = area;
    }
    return false;
  }

  Rect? get rect => null;
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]);
  HitCalculator getHitCalculator() => DefaultHitCalculator(rect);
  void buildSvg(XmlDocument xml, DocumentPage page, Rect viewportRect) {}
  factory Renderer.fromInstance(T element) {
    // Elements
    if (element is PadElement) {
      return element.map(
        pen: (value) => PenRenderer(value),
        text: (value) => TextRenderer(value),
        image: (value) => ImageRenderer(value),
        svg: (value) => SvgRenderer(value),
        shape: (value) => ShapeRenderer(value),
        markdown: (value) => MarkdownRenderer(value),
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

  Renderer<T>? transform({
    Offset position = Offset.zero,
    double scaleX = 1,
    double scaleY = 1,
    double rotation = 0,
    bool relative = true,
  }) =>
      null;
}
