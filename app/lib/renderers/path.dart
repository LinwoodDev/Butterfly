part of 'renderer.dart';

abstract class PathRenderer<T extends PadElement> extends Renderer<T> {
  @override
  Rect rect = Rect.zero;

  PathRenderer(T element, [this.rect = Rect.zero]) : super(element);

  Paint buildPaint([bool foreground = false]);

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
  FutureOr<void> build(Canvas canvas, CameraTransform transform,
      [bool foreground = false]) {
    final current = element as PathElement;
    final points = current.points;
    final property = current.property;
    final paint = buildPaint(foreground);
    if (points.isNotEmpty) {
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
  PathRenderer<T> move(Offset position) {
    var current = element as PathElement;
    var center = rect.center;
    var diff = position - center;
    var points = current.points
        .map((element) =>
            element.copyWith(x: element.x + diff.dx, y: element.y + diff.dy))
        .toList();
    return _copyWith(
        element: (current as dynamic).copyWith(points: points) as T,
        rect: rect.shift(diff));
  }

  PathRenderer<T> _copyWith({T? element, Rect? rect});
}
