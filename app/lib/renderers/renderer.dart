import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:butterfly/api/image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/helpers/element.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly/visualizer/text.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:markdown/markdown.dart' as md;
import 'package:material_leap/material_leap.dart';
import 'package:perfect_freehand/perfect_freehand.dart' as freehand;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:xml/xml.dart';

import '../cubits/transform.dart';
import '../helpers/xml.dart';
import '../models/label.dart';
import '../services/asset.dart';
import 'textures/texture.dart';

part 'backgrounds/texture.dart';
part 'backgrounds/svg.dart';
part 'backgrounds/image.dart';
part 'elements/image.dart';
part 'elements/markdown.dart';
part 'elements/text.dart';
part 'elements/texture.dart';
part 'elements/path.dart';
part 'elements/pen.dart';
part 'elements/shape.dart';
part 'elements/svg.dart';

class DefaultHitCalculator extends HitCalculator {
  final Rect? rect;
  final double rotation;

  DefaultHitCalculator(this.rect, this.rotation);

  @override
  bool hit(Rect rect, {bool full = false}) {
    final element = this.rect;
    if (element == null) return false;
    if (full) {
      return element.top >= rect.top &&
          element.left >= rect.left &&
          element.right <= rect.right &&
          element.bottom <= rect.bottom;
    }
    return element.overlaps(rect);
  }

  @override
  bool hitPolygon(List<ui.Offset> polygon, {bool full = false}) {
    if (rect == null) return false;
    final center = rect!.center;
    final isCenter = isPointInPolygon(polygon, center);
    final isTopLeft = isPointInPolygon(
      polygon,
      rect!.topLeft.rotate(center, rotation),
    );
    final isTopRight = isPointInPolygon(
      polygon,
      rect!.topRight.rotate(center, rotation),
    );
    final isBottomLeft = isPointInPolygon(
      polygon,
      rect!.bottomLeft.rotate(center, rotation),
    );
    final isBottomRight = isPointInPolygon(
      polygon,
      rect!.bottomRight.rotate(center, rotation),
    );
    if (full) {
      return isCenter &&
          isTopLeft &&
          isTopRight &&
          isBottomLeft &&
          isBottomRight;
    }
    return isCenter || isTopLeft || isTopRight || isBottomLeft || isBottomRight;
  }
}

/// A helper class to represent the projection of a polygon onto an axis.
class Projection {
  double min;
  double max;
  Projection(this.min, this.max);
}

double dotProduct(Offset a, Offset b) => a.dx * b.dx + a.dy * b.dy;

/// Projects the polygon onto the given axis and returns the min and max values.
Projection projectPolygon(Offset axis, List<Offset> polygon) {
  double min = dotProduct(polygon[0], axis);
  double max = min;

  for (int i = 1; i < polygon.length; i++) {
    final double p = dotProduct(polygon[i], axis);
    if (p < min) {
      min = p;
    }
    if (p > max) {
      max = p;
    }
  }
  return Projection(min, max);
}

abstract class HitCalculator {
  bool hit(Rect rect, {bool full = false});
  bool hitPolygon(List<Offset> polygon, {bool full = false});

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

  List<Offset> getAxesOfPolygon(List<Offset> polygon) {
    List<Offset> axes = [];
    for (int i = 0; i < polygon.length; i++) {
      final Offset p1 = polygon[i];
      final Offset p2 = polygon[(i + 1) % polygon.length];

      // Edge vector from p1 to p2.
      final Offset edge = p2 - p1;

      // The normal (perpendicular) to the edge.
      final Offset normal = Offset(-edge.dy, edge.dx);

      // Normalize the axis.
      final double length = normal.distance;
      axes.add(normal / length);
    }
    return axes;
  }

  bool isPolygonInPolygon(List<Offset> poly1, List<Offset> poly2) {
    // Get the axes from both polygons.
    final List<Offset> axes = [
      ...getAxesOfPolygon(poly1),
      ...getAxesOfPolygon(poly2),
    ];

    // For each axis, project both polygons.
    for (final axis in axes) {
      final Projection proj1 = projectPolygon(axis, poly1);
      final Projection proj2 = projectPolygon(axis, poly2);

      // If there is a gap on this axis, then there is a separating axis.
      if (proj1.max < proj2.min || proj2.max < proj1.min) {
        return false;
      }
    }
    return true;
  }
}

enum RendererOperation {
  invert,
  background,
  grayscale,
  flipHorizontal,
  flipVertical;

  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      RendererOperation.invert => loc.invert,
      RendererOperation.background => loc.background,
      RendererOperation.grayscale => loc.grayscale,
      RendererOperation.flipHorizontal => loc.flipHorizontal,
      RendererOperation.flipVertical => loc.flipVertical,
    };
  }

  IconGetter get icon => switch (this) {
    RendererOperation.invert => PhosphorIcons.circleHalf,
    RendererOperation.background => PhosphorIcons.paintBucket,
    RendererOperation.grayscale => PhosphorIcons.palette,
    RendererOperation.flipHorizontal => PhosphorIcons.flipHorizontal,
    RendererOperation.flipVertical => PhosphorIcons.flipVertical,
  };
}

typedef RendererOperationCallback =
    void Function(DocumentBloc bloc, BuildContext context);

abstract class Renderer<T> {
  final T element;
  final String? layer;
  Area? area;

  Renderer(this.element, [this.layer]);

  factory Renderer.fromInstance(T element, [String? layer]) {
    // Elements
    if (element is PadElement) {
      return switch (element) {
            PenElement() => PenRenderer(element, layer),
            TextElement() => TextRenderer(element, layer),
            ImageElement() => ImageRenderer(element, layer),
            SvgElement() => SvgRenderer(element, layer),
            ShapeElement() => ShapeRenderer(element, layer),
            MarkdownElement() => MarkdownRenderer(element, layer),
            TextureElement() => TextureRenderer(element, layer),
          }
          as Renderer<T>;
    }

    // Backgrounds
    if (element is Background) {
      return switch (element) {
            TextureBackground() => TextureBackgroundRenderer(element),
            ImageBackground() => ImageBackgroundRenderer(element),
            SvgBackground() => SvgBackgroundRenderer(element),
          }
          as Renderer<T>;
    }

    throw Exception('Invalid instance type');
  }

  double get rotation =>
      element is PadElement ? (element as PadElement).rotation : 0.0;

  String get id =>
      (element is PadElement ? (element as PadElement).id : null) ??
      createUniqueId();

  @mustCallSuper
  FutureOr<void> setup(
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async => _updateArea(page);

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

  bool onAssetUpdate(
    NoteData document,
    AssetService assetService,
    DocumentPage page,
    String path,
  ) => false;

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

  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]);

  HitCalculator getHitCalculator() =>
      DefaultHitCalculator(rect, this.rotation * (pi / 180));

  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) {}

  Renderer<T>? transform({
    Offset? position,
    double scaleX = 1,
    double scaleY = 1,
    double? rotation,
    bool relative = true,
    bool rotatePosition = false,
  }) {
    final rect = this.rect ?? Rect.zero;
    rotation ??= relative ? 0 : this.rotation;
    final double nextRotation =
        (relative ? rotation + this.rotation : rotation) % 360;
    position ??= relative ? Offset.zero : rect.topLeft;
    final expandedRect = this.expandedRect ?? rect;
    var nextPosition = relative ? position + rect.topLeft : position;

    final radians = this.rotation * (pi / 180);
    if (rotatePosition) {
      var relativePosition = nextPosition - rect.topLeft;
      relativePosition = relativePosition.rotate(Offset.zero, radians);
      nextPosition = relativePosition + rect.topLeft;
    }

    if (radians != 0) {
      final rotationCos = cos(radians);
      final rotationSin = sin(radians);
      final oldScaleX = scaleX;
      final oldScaleY = scaleY;

      scaleX = (oldScaleX * rotationCos - oldScaleY * rotationSin).abs();
      scaleY = (oldScaleX * rotationSin + oldScaleY * rotationCos).abs();
      // Calculate offset, please use Offset#rotate(pivot, radians)
      // to rotate the offset around the pivot point
      // Don't forget to use the radians and the scales to calculate the offset to keep the rectangle on the same position as if they are unrotated
      final rotationPoint = rect.topLeft;
      final offset = Offset(
        (expandedRect.left - rotationPoint.dx) * scaleX / 2,
        (expandedRect.top - rotationPoint.dy) * scaleY / 2,
      );
      final rotatedOffset = offset.rotate(Offset.zero, radians);
      nextPosition -= rotatedOffset;
    }

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
  }) => null;

  Map<RendererOperation, RendererOperationCallback> getOperations() => {};
}
