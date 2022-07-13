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

  @override
  T move(Offset position) {
    var current = element as PathElement;
    var center = rect.center;
    var diff = position - center;
    var points = current.points
        .map((element) =>
            element.copyWith(x: element.x + diff.dx, y: element.y + diff.dy))
        .toList();
    return (current as dynamic).copyWith(points: points) as T;
  }
}
