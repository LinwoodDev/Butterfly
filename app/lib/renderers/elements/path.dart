part of '../renderer.dart';

abstract class PathRenderer<T extends PadElement> extends Renderer<T> {
  @override
  Rect rect = Rect.zero;

  PathRenderer(super.element, [this.rect = Rect.zero]);

  Paint buildPaint([AppDocument? document, bool foreground = false]);

  @override
  FutureOr<void> setup(AppDocument document) {
    final current = element as PathElement;
    final points = current.points;
    final property = current.property;
    var topLeftCorner = points.first.toOffset();
    var bottomRightCorner = points.first.toOffset();
    for (var element in points) {
      final width =
          property.strokeWidth + element.pressure * property.strokeMultiplier;
      topLeftCorner = Offset(min(topLeftCorner.dx, element.x - width),
          min(topLeftCorner.dy, element.y - width));
      bottomRightCorner = Offset(max(bottomRightCorner.dx, element.x + width),
          max(bottomRightCorner.dy, element.y + width));
    }
    rect = Rect.fromLTRB(topLeftCorner.dx, topLeftCorner.dy,
        bottomRightCorner.dx, bottomRightCorner.dy);
    super.setup(document);
  }

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [bool foreground = false]) {
    final current = element as PathElement;
    final points = current.points;
    final property = current.property;
    final paint = buildPaint(document, foreground);
    if (points.isNotEmpty) {
      if (paint.style == PaintingStyle.fill) {
        final path = Path();
        final first = points.first;
        path.moveTo(first.x, first.y);
        points.sublist(1).forEach((point) => path.lineTo(point.x, point.y));
        canvas.drawPath(path, paint);
        return;
      }
      var first = points.first;
      var previous = first;
      for (var element in points) {
        canvas.drawLine(
            previous.toOffset(),
            element.toOffset(),
            paint
              ..strokeWidth = property.strokeWidth +
                  element.pressure * property.strokeMultiplier);
        previous = element;
      }
    }
  }

  List<PathPoint> movePoints(Offset position, double scaleX, double scaleY,
      [bool relative = false]) {
    var current = element as PathElement;
    final center = rect.center;
    if (relative) {
      return current.points.map((e) {
        final next = e.toOffset() + position;
        final x = (next.dx - center.dx) * scaleX + center.dx;
        final y = (next.dy - center.dy) * scaleY + center.dy;
        return e.copyWith(x: x, y: y);
      }).toList();
    }
    var diff = position - center;
    var points = current.points.map((element) {
      final next = element.toOffset() + diff;
      final x = (next.dx - center.dx) * scaleX + center.dx;
      final y = (next.dy - center.dy) * scaleY + center.dy;
      return element.copyWith(x: x, y: y);
    }).toList();
    return points;
  }
}
