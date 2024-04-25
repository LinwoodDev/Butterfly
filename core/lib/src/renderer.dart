import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class DefaultHitCalculator extends HitCalculator {
  final Rect? rect;
  final double rotation;

  DefaultHitCalculator(this.rect, this.rotation);

  @override
  bool hit(Rect rect) => this.rect?.overlaps(rect) ?? false;

  @override
  bool hitPolygon(List<ui.Offset> polygon) {
    if (rect == null) return false;
    final center = rect!.center;
    return isPointInPolygon(polygon, center) ||
        isPointInPolygon(polygon, rect!.topLeft.rotate(center, rotation)) ||
        isPointInPolygon(polygon, rect!.topRight.rotate(center, rotation)) ||
        isPointInPolygon(polygon, rect!.bottomLeft.rotate(center, rotation)) ||
        isPointInPolygon(polygon, rect!.bottomRight.rotate(center, rotation));
  }
}

abstract class HitCalculator {
  bool hit(Rect rect);
  bool hitPolygon(List<Offset> polygon);

  bool isPointInPolygon(List<Offset> polygon, Offset testPoint) {
    bool result = false;
    int j = polygon.length - 1;
    for (int i = 0; i < polygon.length; i++) {
      if ((polygon[i].dy < testPoint.dy && polygon[j].dy >= testPoint.dy) ||
          (polygon[j].dy < testPoint.dy && polygon[i].dy >= testPoint.dy)) {
        if (polygon[i].dx +
                (testPoint.dy - polygon[i].dy) /
                    (polygon[j].dy - polygon[i].dy) *
                    (polygon[j].dx - polygon[i].dx) <
            testPoint.dx) {
          result = !result;
        }
      }
      j = i;
    }
    return result;
  }
}

abstract class Renderer<T> {
  final T element;
  Area? area;

  Renderer(this.element);

  double get rotation;

  @mustCallSuper
  FutureOr<void> setup(NoteData document, AssetService assetService,
          DocumentPage page) async =>
      _updateArea(page);

  void dispose() {}

  void _updateArea(DocumentPage page) => area = rect == null
      ? null
      : page.areas.firstWhereOrNull((area) => area.rect.overlaps(rect!));
  bool onAreaUpdate(NoteData document, DocumentPage page, Area? area) {
    if (area?.rect.overlaps(rect!) ?? false) {
      this.area = area;
    }
    return false;
  }

  bool onAssetUpdate(NoteData document, AssetService assetService,
          DocumentPage page, String path) =>
      false;

  Rect? get rect => null;

  Rect? get expandedRect {
    final current = rect;
    if (current == null) return null;
    final rotation = this.rotation * (pi / 180);
    if (rotation == 0) return current;
    final center = current.center;
    final topLeft = current.topLeft.rotate(center, rotation);
    final topRight = current.topRight.rotate(center, rotation);
    final bottomLeft = current.bottomLeft.rotate(center, rotation);
    final bottomRight = current.bottomRight.rotate(center, rotation);
    final all = [topLeft, topRight, bottomLeft, bottomRight];
    final xs = all.map((p) => p.dx);
    final ys = all.map((p) => p.dy);
    final left = xs.reduce(min);
    final right = xs.reduce(max);
    final top = ys.reduce(min);
    final bottom = ys.reduce(max);
    return Rect.fromLTRB(left, top, right, bottom);
  }

  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]);

  HitCalculator getHitCalculator() =>
      DefaultHitCalculator(rect, this.rotation * (pi / 180));

  void buildSvg(XmlDocument xml, NoteDa ta document, DocumentPage page,
      Rect viewportRect) {}

  Renderer<T>? transform({
    Offset? position,
    double scaleX = 1,
    double scaleY = 1,
    double? rotation,
    bool relative = true,
  }) {
    final rect = this.rect ?? Rect.zero;
    rotation ??= relative ? 0 : this.rotation;
    final nextRotation = relative ? rotation + this.rotation : rotation;
    position ??= relative ? Offset.zero : rect.topLeft;
    final nextPosition = relative ? position + rect.topLeft : position;

    /*final radians = this.rotation * (pi / 180);
    final cosRotation = cos(radians);
    final sinRotation = sin(radians);

    scaleX = scaleX * cosRotation - scaleY * sinRotation;
    scaleY = scaleX * sinRotation + scaleY * cosRotation;*/

    return _transform(
      position: nextPosition,
      rotation: nextRotation,
      scaleX: scaleX,
      scaleY: scaleY,
    );
  }

  Renderer<T>? _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) =>
      null;
}
