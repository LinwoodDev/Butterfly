import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:butterfly/api/image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/element.dart';
import 'package:butterfly/helpers/markdown/latex.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly/visualizer/text.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:markdown/markdown.dart' as md;
import 'package:material_leap/material_leap.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:perfect_freehand/perfect_freehand.dart' as freehand;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:xml/xml.dart';

import '../cubits/transform.dart';
import '../helpers/xml.dart';
import '../models/label.dart';
import '../services/asset.dart';
import '../services/font.dart';
import '../services/logger.dart';
import 'textures/texture.dart';

part 'backgrounds/texture.dart';
part 'backgrounds/svg.dart';
part 'backgrounds/image.dart';
part 'elements/image.dart';
part 'elements/markdown.dart';
part 'elements/text.dart';
part 'elements/texture.dart';
part 'elements/pdf.dart';
part 'elements/pen.dart';
part 'elements/polygon.dart';
part 'elements/shape.dart';
part 'elements/svg.dart';

class ElementPaintRenderer {
  ui.Image? _image;
  String? _source;

  Future<void> setup(
    ElementPaint paint,
    NoteData document,
    AssetService assets,
  ) async {
    final source = switch (paint) {
      ImageElementPaint(:final source) => source,
      SvgElementPaint(:final source) => source,
      _ => null,
    };
    if (_source == source && _image != null) return;
    _image?.dispose();
    _image = null;
    _source = source;
    if (source != null) {
      _image = await assets.getImage(source, document);
    }
  }

  bool uses(String path) => _source == path;

  void dispose() {
    _image?.dispose();
    _image = null;
  }

  Paint build(ElementPaint paint, Rect bounds, {PaintingStyle? style}) {
    final preview = paint.previewColor;
    final result = Paint()
      ..color = preview.toColor()
      ..style = style ?? PaintingStyle.fill;
    if (paint.blur > 0) {
      result.maskFilter = ui.MaskFilter.blur(ui.BlurStyle.normal, paint.blur);
    }
    switch (paint) {
      case ImageElementPaint(:final scale, :final tint):
        if (!_applyImageShader(result, scale, tint)) return result;
      case SvgElementPaint(:final scale, :final tint):
        if (!_applyImageShader(result, scale, tint)) return result;
      case GradientElementPaint(:final gradient):
        final tileMode = TileMode.clamp;
        late final ui.Shader shader;
        switch (gradient) {
          case LinearElementGradient(:final start, :final end, :final stops):
            final startOffset = Offset(
              bounds.left + start.x * bounds.width,
              bounds.top + start.y * bounds.height,
            );
            final endOffset = Offset(
              bounds.left + end.x * bounds.width,
              bounds.top + end.y * bounds.height,
            );
            final centerOffset = Offset(
              bounds.left + bounds.width / 2,
              bounds.top + bounds.height / 2,
            );
            final scaledStart = centerOffset + (startOffset - centerOffset);
            final scaledEnd = centerOffset + (endOffset - centerOffset);
            shader = ui.Gradient.linear(
              scaledStart,
              scaledEnd,
              stops.map((s) => s.color.toColor()).toList(),
              stops.map((s) => s.offset).toList(),
              tileMode,
            );
          case RadialElementGradient(
            :final center,
            :final radius,
            :final stops,
          ):
            shader = ui.Gradient.radial(
              Offset(
                bounds.left + center.x * bounds.width,
                bounds.top + center.y * bounds.height,
              ),
              radius * sqrt(pow(bounds.width, 2) + pow(bounds.height, 2)) / 2,
              stops.map((s) => s.color.toColor()).toList(),
              stops.map((s) => s.offset).toList(),
              tileMode,
            );
        }
        result.shader = shader;
      case SolidElementPaint():
    }
    return result;
  }

  bool _applyImageShader(Paint paint, double scale, SRGBColor tint) {
    final image = _image;
    if (image == null) return false;
    final matrix = Matrix4.diagonal3Values(scale, scale, 1);
    paint
      ..shader = ui.ImageShader(
        image,
        TileMode.repeated,
        TileMode.repeated,
        matrix.storage,
      )
      ..colorFilter = ui.ColorFilter.mode(tint.toColor(), BlendMode.modulate);
    return true;
  }
}

class DefaultHitCalculator extends HitCalculator {
  final Rect? rect;
  final Rect? boundsRect;
  final double rotation;

  DefaultHitCalculator(this.rect, this.boundsRect, this.rotation);

  List<Offset> _rotatedCorners(Rect rect) {
    final center = rect.center;
    return [
      rect.topLeft.rotate(center, rotation),
      rect.topRight.rotate(center, rotation),
      rect.bottomRight.rotate(center, rotation),
      rect.bottomLeft.rotate(center, rotation),
    ];
  }

  @override
  bool hit(
    Rect rect, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  }) {
    final element = this.rect;
    if (element == null) return false;
    if (!(boundsRect ?? element).overlaps(rect)) return false;
    final rotated = _rotatedCorners(element);
    if (hitElementMode == HitElementMode.full) {
      return rotated.every(rect.contains);
    }
    if (!isFiniteRect(rect)) {
      return rotated.any(rect.contains);
    }
    return isPolygonInPolygon(rotated, [
      rect.topLeft,
      rect.topRight,
      rect.bottomRight,
      rect.bottomLeft,
    ]);
  }

  @override
  bool hitPolygon(
    List<ui.Offset> polygon, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  }) {
    if (rect == null) return false;
    final rotated = _rotatedCorners(rect!);
    final center = rect!.center;
    final isCenter = isPointInPolygon(polygon, center);
    final isTopLeft = isPointInPolygon(polygon, rotated[0]);
    final isTopRight = isPointInPolygon(polygon, rotated[1]);
    final isBottomRight = isPointInPolygon(polygon, rotated[2]);
    final isBottomLeft = isPointInPolygon(polygon, rotated[3]);
    if (hitElementMode == HitElementMode.full) {
      return isCenter &&
          isTopLeft &&
          isTopRight &&
          isBottomLeft &&
          isBottomRight;
    }
    return isCenter || isTopLeft || isTopRight || isBottomLeft || isBottomRight;
  }
}

class TransformedHitCalculator extends HitCalculator {
  final HitCalculator delegate;
  final Rect? bounds;
  final Offset center;
  final double rotation;
  final double shear;

  TransformedHitCalculator(
    this.delegate,
    this.bounds,
    this.center,
    this.rotation,
    this.shear,
  );

  Offset _inverse(Offset point) {
    final rotated = (point - center).rotate(Offset.zero, -rotation);
    return center + Offset(rotated.dx - rotated.dy * shear, rotated.dy);
  }

  @override
  bool hit(
    Rect rect, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  }) {
    if (!isFiniteRect(rect)) {
      final bounds = this.bounds;
      if (bounds == null) return false;
      return hitElementMode == HitElementMode.full
          ? [
              bounds.topLeft,
              bounds.topRight,
              bounds.bottomRight,
              bounds.bottomLeft,
            ].every(rect.contains)
          : bounds.overlaps(rect);
    }
    return delegate.hitPolygon(
      [
        rect.topLeft,
        rect.topRight,
        rect.bottomRight,
        rect.bottomLeft,
      ].map(_inverse).toList(),
      hitElementMode: hitElementMode,
    );
  }

  @override
  bool hitPolygon(
    List<Offset> polygon, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  }) => delegate.hitPolygon(
    polygon.map(_inverse).toList(),
    hitElementMode: hitElementMode,
  );
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
  bool hit(
    Rect rect, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  });

  bool hitPolygon(
    List<Offset> polygon, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  });

  bool isPointInPolygon(List<Offset> polygon, Offset testPoint) {
    if (!_isFiniteOffset(testPoint) || !isFinitePolygon(polygon)) return false;
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

  bool _isFiniteOffset(Offset point) => point.dx.isFinite && point.dy.isFinite;

  bool isFinitePolygon(List<Offset> polygon) => polygon.every(_isFiniteOffset);

  bool isFiniteRect(Rect rect) =>
      rect.left.isFinite &&
      rect.top.isFinite &&
      rect.right.isFinite &&
      rect.bottom.isFinite;

  List<Offset> rectToPolygon(Rect rect) => [
    rect.topLeft,
    rect.topRight,
    rect.bottomRight,
    rect.bottomLeft,
  ];

  bool hitRectPolygon(Rect rect, List<Offset> polygon) {
    if (polygon.isEmpty) return false;
    if (!isFiniteRect(rect)) {
      return polygon.any(rect.contains);
    }
    return isPolygonInPolygon(rectToPolygon(rect), polygon);
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

  bool _isPointOnSegment(Offset point, Offset a, Offset b) {
    const epsilon = 1e-10;
    final cross =
        (point.dy - a.dy) * (b.dx - a.dx) - (point.dx - a.dx) * (b.dy - a.dy);
    if (cross.abs() > epsilon) return false;

    final dot =
        (point.dx - a.dx) * (b.dx - a.dx) + (point.dy - a.dy) * (b.dy - a.dy);
    if (dot < -epsilon) return false;

    final lengthSquared =
        (b.dx - a.dx) * (b.dx - a.dx) + (b.dy - a.dy) * (b.dy - a.dy);
    return dot <= lengthSquared + epsilon;
  }

  int _orientation(Offset a, Offset b, Offset c) {
    const epsilon = 1e-10;
    final value = (b.dy - a.dy) * (c.dx - b.dx) - (b.dx - a.dx) * (c.dy - b.dy);
    if (value.abs() <= epsilon) return 0;
    return value > 0 ? 1 : 2;
  }

  bool _segmentsIntersect(Offset a, Offset b, Offset c, Offset d) {
    final o1 = _orientation(a, b, c);
    final o2 = _orientation(a, b, d);
    final o3 = _orientation(c, d, a);
    final o4 = _orientation(c, d, b);

    if (o1 != o2 && o3 != o4) return true;
    if (o1 == 0 && _isPointOnSegment(c, a, b)) return true;
    if (o2 == 0 && _isPointOnSegment(d, a, b)) return true;
    if (o3 == 0 && _isPointOnSegment(a, c, d)) return true;
    if (o4 == 0 && _isPointOnSegment(b, c, d)) return true;
    return false;
  }

  Iterable<(Offset, Offset)> _edgesOf(List<Offset> polygon) sync* {
    if (polygon.length < 2) return;
    for (var i = 0; i < polygon.length - 1; i++) {
      yield (polygon[i], polygon[i + 1]);
    }
    if (polygon.length > 2) {
      yield (polygon.last, polygon.first);
    }
  }

  bool isPolygonInPolygon(List<Offset> poly1, List<Offset> poly2) {
    if (poly1.isEmpty || poly2.isEmpty) return false;
    if (!isFinitePolygon(poly1) || !isFinitePolygon(poly2)) return false;

    for (final (a, b) in _edgesOf(poly1)) {
      for (final (c, d) in _edgesOf(poly2)) {
        if (_segmentsIntersect(a, b, c, d)) return true;
      }
    }

    if (poly2.length > 2 &&
        poly1.any((point) => isPointInPolygon(poly2, point))) {
      return true;
    }
    if (poly1.length > 2 &&
        poly2.any((point) => isPointInPolygon(poly1, point))) {
      return true;
    }
    return false;
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
            PdfElement() => PdfRenderer(element, layer),
            TextElement() => TextRenderer(element, layer),
            ImageElement() => ImageRenderer(element, layer),
            SvgElement() => SvgRenderer(element, layer),
            ShapeElement() => ShapeRenderer(element, layer),
            MarkdownElement() => MarkdownRenderer(element, layer),
            TextureElement() => TextureRenderer(element, layer),
            PolygonElement() => PolygonRenderer(element, layer),
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

  double get shear => element is PadElement ? (element as PadElement).shear : 0;

  String get id =>
      (element is PadElement ? (element as PadElement).id : null) ??
      createUniqueId();

  @mustCallSuper
  FutureOr<void> setup(
    TransformCubit transformCubit,
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

  bool isVisible(Rect rect) => expandedRect?.overlaps(rect) ?? true;

  Rect? get expandedRect {
    final current = rect;
    if (current == null) return null;
    final rotation = this.rotation * (pi / 180);
    return _expandedAabbFor(current, rotation, shear);
  }

  static Offset _transformPoint(
    Offset point,
    Offset center,
    double radians,
    double shear,
  ) {
    final local = point - center;
    final sheared = Offset(local.dx + local.dy * shear, local.dy);
    return center + sheared.rotate(Offset.zero, radians);
  }

  Offset transformPoint(Offset point, [Rect? bounds]) => _transformPoint(
    point,
    (bounds ?? rect ?? Rect.zero).center,
    rotation * pi / 180,
    shear,
  );

  // Computes the axis-aligned bounding box of an affine-transformed rect.
  static Rect _expandedAabbFor(Rect r, double radians, [double shear = 0]) {
    if (radians == 0 && shear == 0) {
      return r;
    }
    final center = r.center;
    final topLeft = _transformPoint(r.topLeft, center, radians, shear);
    final topRight = _transformPoint(r.topRight, center, radians, shear);
    final bottomLeft = _transformPoint(r.bottomLeft, center, radians, shear);
    final bottomRight = _transformPoint(r.bottomRight, center, radians, shear);
    final all = [topLeft, topRight, bottomLeft, bottomRight];
    final xs = all.map((p) => p.dx);
    final ys = all.map((p) => p.dy);
    final left = xs.reduce(min);
    final right = xs.reduce(max);
    final top = ys.reduce(min);
    final bottom = ys.reduce(max);
    return Rect.fromLTRB(left, top, right, bottom);
  }

  static Rect _inverseAabbFor(
    Rect r,
    Offset center,
    double radians,
    double shear,
  ) {
    Offset inverse(Offset point) {
      final rotated = (point - center).rotate(Offset.zero, -radians);
      return center + Offset(rotated.dx - rotated.dy * shear, rotated.dy);
    }

    final points = [
      inverse(r.topLeft),
      inverse(r.topRight),
      inverse(r.bottomRight),
      inverse(r.bottomLeft),
    ];
    return Rect.fromLTRB(
      points.map((point) => point.dx).reduce(min),
      points.map((point) => point.dy).reduce(min),
      points.map((point) => point.dx).reduce(max),
      points.map((point) => point.dy).reduce(max),
    );
  }

  bool transformCanvas(Canvas canvas) {
    final radians = rotation * pi / 180;
    if (radians == 0 && shear == 0) {
      return false;
    }
    final center = rect?.center;
    canvas.save();
    if (center != null) canvas.translate(center.dx, center.dy);
    canvas.rotate(radians);
    canvas.transform((Matrix4.identity()..setEntry(0, 1, shear)).storage);
    if (center != null) canvas.translate(-center.dx, -center.dy);
    return true;
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

  HitCalculator getHitCalculator() {
    final calculator = createHitCalculator();
    if (rotation == 0 && shear == 0) return calculator;
    return TransformedHitCalculator(
      calculator,
      expandedRect,
      rect?.center ?? Offset.zero,
      rotation * pi / 180,
      shear,
    );
  }

  @protected
  HitCalculator createHitCalculator() => DefaultHitCalculator(rect, rect, 0);

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
    final rotationDelta = relative ? rotation : rotation - this.rotation;

    // Determine position (absolute for _transform)
    position ??= relative ? Offset.zero : rect.topLeft;
    var nextPosition = relative ? position + rect.topLeft : position;

    final radians = (this.rotation % 360) * (pi / 180);
    // Keep original rotatePosition behavior (rotate relative movement by current rotation)
    if (rotatePosition && (this.rotation % 360) != 0) {
      var relativePosition = nextPosition - rect.topLeft;
      relativePosition = relativePosition.rotate(Offset.zero, radians);
      nextPosition = relativePosition + rect.topLeft;
    }

    // Compose the requested world transform with the current local transform.
    // QR decomposition then gives a rotation, an X shear and local scales,
    // which together can represent every non-reflecting affine transform.
    final currentShear = shear;
    final c = cos(radians), s = sin(radians);
    final a = c;
    final b = c * currentShear - s;
    final d = s;
    final e = s * currentShear + c;
    final deltaRadians = rotationDelta * pi / 180;
    final dc = cos(deltaRadians), ds = sin(deltaRadians);
    final m00 = dc * scaleX * a - ds * scaleY * d;
    final m01 = dc * scaleX * b - ds * scaleY * e;
    final m10 = ds * scaleX * a + dc * scaleY * d;
    final m11 = ds * scaleX * b + dc * scaleY * e;

    final r00 = sqrt(m00 * m00 + m10 * m10);
    if (r00 <= 1e-12) return null;
    final q00 = m00 / r00, q10 = m10 / r00;
    final r01 = q00 * m01 + q10 * m11;
    final determinant = m00 * m11 - m01 * m10;
    final r11 = determinant / r00;
    if (r11.abs() <= 1e-12) return null;

    final nextRotation = atan2(q10, q00) * 180 / pi % 360;
    final geometryScaleX = r00;
    final geometryScaleY = r11.abs();
    final nextShear = r01 / r11;

    final oldExpanded = _expandedAabbFor(rect, radians, currentShear);
    final scaledRect = Rect.fromLTWH(
      rect.left,
      rect.top,
      rect.width * geometryScaleX,
      rect.height * geometryScaleY,
    );
    final newExpanded = _expandedAabbFor(
      scaledRect,
      nextRotation * pi / 180,
      nextShear,
    );
    if (rotationDelta == 0) {
      nextPosition +=
          (oldExpanded.topLeft - rect.topLeft) -
          (newExpanded.topLeft - scaledRect.topLeft);
    }

    return _transform(
      position: nextPosition,
      rotation: nextRotation,
      shear: nextShear,
      scaleX: geometryScaleX,
      scaleY: geometryScaleY,
    );
  }

  Renderer<T>? _transform({
    required Offset position,
    required double rotation,
    required double shear,
    // ignore: unused_element_parameter
    double scaleX = 1,
    // ignore: unused_element_parameter
    double scaleY = 1,
  }) => null;

  Map<RendererOperation, RendererOperationCallback> getOperations() => {};

  ContextMenuItem? getContextMenuItem(
    DocumentBloc bloc,
    BuildContext context,
  ) => null;

  FutureOr<void> onVisible(
    EditorController editorController,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) {}

  FutureOr<void> onHidden(
    EditorController editorController,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) {}

  FutureOr<void> updateView(
    EditorController editorController,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) {}
}

Future<ui.Image> renderWidget(Widget widget, {double pixelRatio = 1.0}) async {
  final repaintBoundary = RenderRepaintBoundary();
  final pipelineOwner = PipelineOwner();
  final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
  RenderView? renderView;

  try {
    renderView = RenderView(
      view: ui.PlatformDispatcher.instance.implicitView!,
      child: RenderPositionedBox(
        alignment: Alignment.center,
        child: repaintBoundary,
      ),
      configuration: ViewConfiguration(
        logicalConstraints: BoxConstraints.tightFor(),
        devicePixelRatio: pixelRatio,
      ),
    );

    pipelineOwner.rootNode = renderView;

    renderView.prepareInitialFrame();
    final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: MediaQuery(
        data: MediaQueryData(),
        child: Directionality(textDirection: TextDirection.ltr, child: widget),
      ),
    ).attachToRenderTree(buildOwner);
    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();
    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();
    final image = await repaintBoundary.toImage(pixelRatio: pixelRatio);
    return image;
  } catch (e) {
    throw Exception('Failed to render widget: $e');
  } finally {
    pipelineOwner.rootNode = null;
    repaintBoundary.dispose();
    pipelineOwner.dispose();
    renderView?.dispose();
  }
}
