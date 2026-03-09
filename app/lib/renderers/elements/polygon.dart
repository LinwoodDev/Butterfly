part of '../renderer.dart';

Rect calculatePolygonRect(List<PolygonPoint> points) {
  if (points.isEmpty) return Rect.zero;
  Rect rect = Rect.fromPoints(
    Offset(points.first.x, points.first.y),
    Offset(points.first.x, points.first.y),
  );
  for (final point in points) {
    final offset = Offset(point.x, point.y);
    rect = rect.expandToInclude(Rect.fromPoints(offset, offset));
    if (point.handleIn != null) {
      final handleInOffset = Offset(point.handleIn!.x, point.handleIn!.y);
      rect = rect.expandToInclude(
        Rect.fromPoints(handleInOffset, handleInOffset),
      );
    }
    if (point.handleOut != null) {
      final handleOutOffset = Offset(point.handleOut!.x, point.handleOut!.y);
      rect = rect.expandToInclude(
        Rect.fromPoints(handleOutOffset, handleOutOffset),
      );
    }
  }
  return rect;
}

class PolygonRenderer extends Renderer<PolygonElement> {
  @override
  Rect rect;

  ui.Path? _cachedPath;
  PolygonHitCalculator? _cachedHitCalculator;

  PolygonRenderer(super.element, [super.layer, this.rect = Rect.zero]);

  void _computePath() {
    final points = element.points;
    if (points.isEmpty) {
      _cachedPath = null;
      return;
    }
    _cachedPath = ui.Path();
    final first = points.first;
    _cachedPath!.moveTo(first.x, first.y);
    for (var i = 1; i < points.length; i++) {
      final point = points[i];
      final prev = points[i - 1];

      if (prev.handleOut != null || point.handleIn != null) {
        _cachedPath!.cubicTo(
          prev.handleOut?.x ?? prev.x,
          prev.handleOut?.y ?? prev.y,
          point.handleIn?.x ?? point.x,
          point.handleIn?.y ?? point.y,
          point.x,
          point.y,
        );
      } else {
        _cachedPath!.lineTo(point.x, point.y);
      }
    }

    if (points.length > 2) {
      final last = points.last;
      if ((first.toPoint().toOffset() - last.toPoint().toOffset()).distance <
          1.0) {
        _cachedPath!.close();
      }
    }
  }

  @override
  void setup(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    rect = calculatePolygonRect(element.points);
    _computePath();
    _cachedHitCalculator = null;

    super.setup(transformCubit, document, assetService, page);
  }

  @override
  void build(
    ui.Canvas canvas,
    ui.Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    if (element.points.isEmpty) return;

    // Compute path if not cached (e.g., for foreground renderers)
    if (_cachedPath == null) {
      _computePath();
    }
    final path = _cachedPath;
    if (path == null) return;

    final property = element.property;

    if (property.fill.a > 0) {
      final fillPaint = Paint()
        ..color = property.fill.toColor()
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);
    }
    if (property.color.a > 0) {
      final paint = Paint()
        ..color = property.color.toColor()
        ..style = PaintingStyle.stroke
        ..strokeWidth = property.strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(path, paint);
    }
  }

  @override
  ContextMenuItem? getContextMenuItem(DocumentBloc bloc, BuildContext context) {
    return ContextMenuItem(
      onPressed: () async {
        bloc.state.currentIndexCubit
            ?.fetchHandler<SelectHandler>()
            ?.clearSelection(bloc);
        final polygon =
            await bloc.state.currentIndexCubit?.changeTemporaryHandler(
                  context,
                  PolygonTool(property: element.property),
                  bloc: bloc,
                )
                as PolygonHandler;
        polygon.editElement(element);
        await bloc.refreshForegrounds();
        await bloc.refreshToolbar();
        Navigator.of(context).pop();
      },
      icon: const PhosphorIcon(PhosphorIconsLight.polygon),
      label: AppLocalizations.of(context).edit,
    );
  }

  List<PolygonPoint> movePoints(Offset position, double scaleX, double scaleY) {
    final topLeft = rect.topLeft;
    final points = element.points.map((element) {
      final old = element.toPoint() - topLeft.toPoint();
      final x = old.x * scaleX + position.dx;
      final y = old.y * scaleY + position.dy;
      SimplePoint? handleIn, handleOut;
      final elementHandleIn = element.handleIn;
      final elementHandleOut = element.handleOut;
      if (elementHandleIn != null) {
        final oldHandleIn = elementHandleIn.toPoint() - topLeft.toPoint();
        handleIn = SimplePoint(
          oldHandleIn.x * scaleX + position.dx,
          oldHandleIn.y * scaleY + position.dy,
        );
      }
      if (elementHandleOut != null) {
        final oldHandleOut = elementHandleOut.toPoint() - topLeft.toPoint();
        handleOut = SimplePoint(
          oldHandleOut.x * scaleX + position.dx,
          oldHandleOut.y * scaleY + position.dy,
        );
      }
      return element.copyWith(
        x: x,
        y: y,
        handleIn: handleIn,
        handleOut: handleOut,
      );
    }).toList();
    return points;
  }

  Rect moveRect(Offset position, double scaleX, double scaleY) {
    final size = Size(rect.width * scaleX, rect.height * scaleY);
    return position & size;
  }

  @override
  PolygonHitCalculator getHitCalculator() {
    _cachedHitCalculator ??= PolygonHitCalculator(
      rect,
      element.points,
      rotation * pi / 180,
      element.property,
    );
    return _cachedHitCalculator!;
  }

  @override
  PolygonRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) => PolygonRenderer(
    element.copyWith(
      rotation: rotation,
      points: movePoints(position, scaleX, scaleY),
    ),
    layer,
    moveRect(position, scaleX, scaleY),
  );
}

class PolygonHitCalculator extends HitCalculator {
  final Rect elementRect;
  final double rotation;
  final PolygonProperty property;
  final bool _isVisible;
  final List<Offset> _points;
  final List<Offset> _fillPolygon;
  final Rect _bounds;

  PolygonHitCalculator(
    this.elementRect,
    List<PolygonPoint> points,
    this.rotation,
    this.property,
  ) : _isVisible =
          property.fill.a > 0 ||
          (property.color.a > 0 && property.strokeWidth > 0),
      _points = _rotatePoints(
        _collectPoints(points),
        elementRect.center,
        rotation,
      ),
      _fillPolygon = _rotatePoints(
        _collectFillPolygon(points, property.fill.a > 0),
        elementRect.center,
        rotation,
      ),
      _bounds = Renderer._expandedAabbFor(
        elementRect.inflate(
          property.color.a > 0 && property.strokeWidth > 0
              ? property.strokeWidth / 2
              : 0,
        ),
        rotation,
      );

  static List<Offset> _collectPoints(List<PolygonPoint> points) {
    final collected = <Offset>[];
    for (final point in points) {
      collected.add(Offset(point.x, point.y));
      if (point.handleIn case final handleIn?) {
        collected.add(Offset(handleIn.x, handleIn.y));
      }
      if (point.handleOut case final handleOut?) {
        collected.add(Offset(handleOut.x, handleOut.y));
      }
    }
    return collected;
  }

  static List<Offset> _collectFillPolygon(
    List<PolygonPoint> points,
    bool hasFill,
  ) {
    if (!hasFill || points.length < 3) return const [];
    final polygon = points.map((point) => Offset(point.x, point.y)).toList();
    if (polygon.length > 1 && polygon.first == polygon.last) {
      polygon.removeLast();
    }
    return polygon;
  }

  static List<Offset> _rotatePoints(
    List<Offset> points,
    Offset center,
    double rotation,
  ) {
    if (points.isEmpty || rotation == 0) return points;
    final cosRotation = cos(rotation);
    final sinRotation = sin(rotation);
    return points
        .map((point) {
          final dx = point.dx - center.dx;
          final dy = point.dy - center.dy;
          return Offset(
            center.dx + dx * cosRotation - dy * sinRotation,
            center.dy + dx * sinRotation + dy * cosRotation,
          );
        })
        .toList(growable: false);
  }

  Rect _selectionBounds(List<Offset> polygon) {
    if (polygon.isEmpty) return Rect.zero;
    var minX = polygon.first.dx;
    var maxX = polygon.first.dx;
    var minY = polygon.first.dy;
    var maxY = polygon.first.dy;
    for (var index = 1; index < polygon.length; index++) {
      final point = polygon[index];
      if (point.dx < minX) minX = point.dx;
      if (point.dx > maxX) maxX = point.dx;
      if (point.dy < minY) minY = point.dy;
      if (point.dy > maxY) maxY = point.dy;
    }
    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  bool _allPointsInside(List<Offset> points, bool Function(Offset point) test) {
    for (final point in points) {
      if (!test(point)) return false;
    }
    return true;
  }

  @override
  bool hit(Rect rect, {bool full = false}) {
    if (!_isVisible || _points.isEmpty) return false;
    if (!_bounds.overlaps(rect)) return false;

    if (full) {
      return _allPointsInside(_points, rect.contains);
    }

    for (final point in _points) {
      if (rect.contains(point)) {
        return true;
      }
    }
    if (_fillPolygon.isNotEmpty) {
      if (isPointInPolygon(_fillPolygon, rect.center)) return true;
      if (isPointInPolygon(_fillPolygon, rect.topLeft)) return true;
      if (isPointInPolygon(_fillPolygon, rect.topRight)) return true;
      if (isPointInPolygon(_fillPolygon, rect.bottomLeft)) return true;
      if (isPointInPolygon(_fillPolygon, rect.bottomRight)) return true;
    }
    return false;
  }

  @override
  bool hitPolygon(List<Offset> polygon, {bool full = false}) {
    if (!_isVisible || polygon.isEmpty || _points.isEmpty) return false;
    if (!_bounds.overlaps(_selectionBounds(polygon))) return false;

    if (full) {
      return _allPointsInside(
        _points,
        (point) => isPointInPolygon(polygon, point),
      );
    }

    for (final point in _points) {
      if (isPointInPolygon(polygon, point)) {
        return true;
      }
    }
    if (_fillPolygon.isNotEmpty) {
      for (final point in polygon) {
        if (isPointInPolygon(_fillPolygon, point)) {
          return true;
        }
      }
    }
    return false;
  }
}
