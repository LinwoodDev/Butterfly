part of '../renderer.dart';

class PenRenderer extends Renderer<PenElement> {
  @override
  Rect rect;

  PenRenderer(
    super.element, [
    super.layer,
    this.rect = .zero,
    Rect expandedRect = .zero,
  ]) : expandedRect = expandedRect,
       _localExpandedRect = expandedRect {
    if (rotation != 0 || shear != 0) {
      _localExpandedRect = Renderer._inverseAabbFor(
        expandedRect,
        rect.center,
        rotation * pi / 180,
        shear,
      );
    }
  }

  @override
  Rect expandedRect;
  Rect _localExpandedRect;

  Path? _cachedFillPath;
  Path? _cachedStrokePath;
  PathHitCalculator? _cachedHitCalculator;
  final _strokePaint = ElementPaintRenderer();
  final _fillPaint = ElementPaintRenderer();

  void _clearCachedPaths() {
    _cachedFillPath = null;
    _cachedStrokePath = null;
    _cachedHitCalculator = null;
  }

  void _computePaths() {
    final points = element.points;
    if (points.isEmpty) return;
    final property = element.property;

    if (property.fillPaint.previewColor.a > 0) {
      _cachedFillPath = Path();
      final first = points.first;
      _cachedFillPath!.moveTo(first.x, first.y);
      for (var i = 1; i < points.length; i++) {
        final point = points[i];
        _cachedFillPath!.lineTo(point.x, point.y);
      }
    }

    if (property.paint.previewColor.a > 0) {
      final outlinePoints = _getOutlinePoints();
      if (outlinePoints.isNotEmpty) {
        final strokePath = Path();
        if (outlinePoints.length < 2) {
          strokePath.addOval(
            Rect.fromCircle(center: outlinePoints[0], radius: 1),
          );
        } else {
          strokePath.moveTo(outlinePoints[0].dx, outlinePoints[0].dy);
          for (int i = 1; i < outlinePoints.length - 1; ++i) {
            final p0 = outlinePoints[i];
            final p1 = outlinePoints[i + 1];
            strokePath.quadraticBezierTo(
              p0.dx,
              p0.dy,
              (p0.dx + p1.dx) / 2,
              (p0.dy + p1.dy) / 2,
            );
          }
        }
        _cachedStrokePath = strokePath;
      }
    }
  }

  bool shouldSimulatePressure() {
    final points = element.points;
    if (points.length < 2) return true;
    final pressure = points[1].pressure;
    for (var i = 2; i < points.length; i++) {
      if (points[i].pressure != pressure) return false;
    }
    return true;
  }

  @override
  Future<void> setup(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    final points = element.points;
    if (points.isEmpty) return;
    final property = element.property;
    var topLeftCorner = points.first.toOffset();
    var bottomRightCorner = points.first.toOffset();
    for (final element in points) {
      topLeftCorner = Offset(
        min(topLeftCorner.dx, element.x),
        min(topLeftCorner.dy, element.y),
      );
      bottomRightCorner = Offset(
        max(bottomRightCorner.dx, element.x),
        max(bottomRightCorner.dy, element.y),
      );
    }
    rect = Rect.fromLTRB(
      topLeftCorner.dx,
      topLeftCorner.dy,
      bottomRightCorner.dx,
      bottomRightCorner.dy,
    );
    for (final element in points) {
      final width = property.strokeWidth + element.pressure * property.thinning;
      topLeftCorner = Offset(
        min(topLeftCorner.dx, element.x - width),
        min(topLeftCorner.dy, element.y - width),
      );
      bottomRightCorner = Offset(
        max(bottomRightCorner.dx, element.x + width),
        max(bottomRightCorner.dy, element.y + width),
      );
    }
    _localExpandedRect = Rect.fromLTRB(
      topLeftCorner.dx,
      topLeftCorner.dy,
      bottomRightCorner.dx,
      bottomRightCorner.dy,
    );
    expandedRect = Renderer._expandedAabbFor(
      _localExpandedRect,
      rotation / 180 * pi,
      shear,
    );
    await Future.wait([
      _strokePaint.setup(property.paint, document, assetService),
      _fillPaint.setup(property.fillPaint, document, assetService),
    ]);
    await super.setup(transformCubit, document, assetService, page);
  }

  @override
  void dispose() {
    _strokePaint.dispose();
    _fillPaint.dispose();
    _clearCachedPaths();
    super.dispose();
  }

  @override
  bool onAssetUpdate(
    NoteData document,
    AssetService assetService,
    DocumentPage page,
    String path,
  ) => _strokePaint.uses(path) || _fillPaint.uses(path);

  @override
  void onHidden(
    EditorController editorController,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) {
    _clearCachedPaths();
  }

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    _build(canvas);
  }

  void buildCombined(Canvas canvas) {
    _build(canvas, BlendMode.src);
  }

  void _build(Canvas canvas, [BlendMode? blendMode]) {
    final points = element.points;
    if (points.isEmpty) return;
    final property = element.property;

    if (_cachedFillPath == null && _cachedStrokePath == null) {
      _computePaths();
    }

    if (property.fillPaint.previewColor.a > 0 && _cachedFillPath != null) {
      final paint = _fillPaint.build(property.fillPaint, rect, style: .fill)
        ..strokeCap = StrokeCap.round
        ..blendMode = blendMode ?? BlendMode.srcOver;
      canvas.drawPath(_cachedFillPath!, paint);
    }
    if (property.paint.previewColor.a > 0 && _cachedStrokePath != null) {
      final paint =
          _strokePaint.build(property.paint, expandedRect, style: .fill)
            ..strokeCap = StrokeCap.round
            ..blendMode = blendMode ?? BlendMode.srcOver;
      canvas.drawPath(_cachedStrokePath!, paint);
    }
  }

  List<Offset> _getOutlinePoints() {
    final currentZoom = element.zoom ?? kMaxZoom;
    final property = element.property;
    final center = rect.center;
    var outlinePoints = freehand.getStroke(
      [
        for (final point in element.points)
          point.scale(currentZoom, center).toFreehandPoint(),
      ],
      options: freehand.StrokeOptions(
        size: property.strokeWidth * currentZoom,
        thinning: property.thinning.clamp(0, 1),
        smoothing: property.smoothing.clamp(0, 1),
        streamline: property.streamline.clamp(.1, 1),
        simulatePressure: shouldSimulatePressure(),
      ),
    );

    return [
      for (final point in outlinePoints)
        point.scaleFromCenter(1 / currentZoom, center),
    ];
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) {
    final points = element.points;
    final property = element.property;
    if (points.isEmpty) return;
    final fill = property.fillPaint.previewColor;
    final color = property.paint.previewColor;
    if (fill.a > 0) {
      final first = points.first;
      final path = StringBuffer('M ${first.x} ${first.y}');
      for (var i = 1; i < points.length; i++) {
        final point = points[i];
        path.write(' L ${point.x} ${point.y}');
      }
      xml.getElement('svg')?.createElement('path')
        ?..setAttribute('d', path.toString())
        ..setAttribute('fill', fill.toHexString(alpha: false))
        ..setAttribute('fill-opacity', '${fill.a / 255}')
        ..setAttribute('stroke', 'none')
        ..setAttribute('stroke-linecap', 'round')
        ..setAttribute('stroke-linejoin', 'round');
    }
    if (color.a > 0) {
      // 1. Get the outline points from the input points
      var outlinePoints = _getOutlinePoints();

      // 2. Render the points as a path
      if (outlinePoints.isEmpty) {
        // If the list is empty, don't do anything.
        return;
      }

      final first = outlinePoints.first;
      final path = StringBuffer('M ${first.roundedX()} ${first.roundedY()}');
      for (var i = 1; i < outlinePoints.length; i++) {
        final point = outlinePoints[i];
        path.write(' L ${point.roundedX()} ${point.roundedY()}');
      }
      path.write(' Z');

      xml.getElement('svg')?.createElement('path')
        ?..setAttribute('d', path.toString())
        ..setAttribute('fill', color.toHexString(alpha: false))
        ..setAttribute('fill-opacity', '${color.a / 255}')
        ..setAttribute('stroke', 'none')
        ..setAttribute('stroke-linecap', 'round')
        ..setAttribute('stroke-linejoin', 'round');
    }
  }

  List<PathPoint> movePoints(Offset position, double scaleX, double scaleY) {
    final points = element.points;
    if (points.isEmpty) return const [];
    var left = points.first.x;
    var top = points.first.y;
    for (var i = 1; i < points.length; i++) {
      left = min(left, points[i].x);
      top = min(top, points[i].y);
    }
    return [
      for (final point in points)
        point.copyWith(
          x: (point.x - left) * scaleX + position.dx,
          y: (point.y - top) * scaleY + position.dy,
        ),
    ];
  }

  Rect moveRect(
    Offset position,
    double scaleX,
    double scaleY, [
    bool expanded = false,
  ]) {
    final rect = expanded ? expandedRect : this.rect;
    return Rect.fromPoints(
      position,
      position + Offset(rect.width * scaleX, rect.height * scaleY),
    );
  }

  @override
  PenRenderer _transform({
    required Offset position,
    required double rotation,
    required double shear,
    double scaleX = 1,
    double scaleY = 1,
  }) => PenRenderer(
    element.copyWith(
      rotation: rotation,
      shear: shear,
      points: movePoints(position, scaleX, scaleY),
    ),
    layer,
    moveRect(position, scaleX, scaleY),
    moveRect(position, scaleX, scaleY, true),
  );

  @override
  PathHitCalculator createHitCalculator() {
    _cachedHitCalculator ??= PathHitCalculator(rect, element.points, 0);
    return _cachedHitCalculator!;
  }
}

class PathHitCalculator extends HitCalculator {
  final Rect elementRect;
  final List<PathPoint> points;
  final double rotation;
  final double _cos;
  final double _sin;

  PathHitCalculator(this.elementRect, this.points, this.rotation)
    : _cos = rotation == 0 ? 1 : cos(rotation),
      _sin = rotation == 0 ? 0 : sin(rotation);

  Offset _rotatePoint(PathPoint point) {
    if (rotation == 0) return point.toOffset();
    final center = elementRect.center;
    final dx = point.x - center.dx;
    final dy = point.y - center.dy;
    return Offset(
      center.dx + dx * _cos - dy * _sin,
      center.dy + dx * _sin + dy * _cos,
    );
  }

  @override
  bool hitPolygon(
    List<ui.Offset> polygon, {
    HitElementMode hitElementMode = .touchAnywhere,
  }) {
    if (points.isEmpty || polygon.isEmpty || hitElementMode == .none) {
      return false;
    }
    final path = points.map(_rotatePoint).toList();
    if (hitElementMode == .full) {
      return path.every((point) => isPointInPolygon(polygon, point));
    }
    if (path.length == 1) return isPointInPolygon(polygon, path.first);
    // A pen path is open: test each segment without closing the last point
    // back to the first, and include crossings between sparse samples.
    for (var i = 1; i < path.length; i++) {
      if (isPolygonInPolygon(polygon, [path[i - 1], path[i]])) return true;
    }
    return false;
  }
}
