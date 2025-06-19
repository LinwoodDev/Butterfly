part of '../renderer.dart';

class PolygonRenderer extends Renderer<PolygonElement> {
  PolygonRenderer(super.element, [super.layer]);

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
    final points = element.points;
    if (points.isEmpty) return;
    final path = ui.Path();
    final first = points.first;
    path.moveTo(first.x, first.y);
    for (var i = 1; i < points.length; i++) {
      final point = points[i];
      final prev = points[i - 1];

      if (prev.handleOut != null || point.handleIn != null) {
        path.cubicTo(
          prev.handleOut?.x ?? prev.x,
          prev.handleOut?.y ?? prev.y,
          point.handleIn?.x ?? point.x,
          point.handleIn?.y ?? point.y,
          point.x,
          point.y,
        );
      } else {
        path.lineTo(point.x, point.y);
      }
    }
    final property = element.property;

    if (property.color.a > 0) {
      final paint = Paint()
        ..color = property.color.toColor()
        ..style = PaintingStyle.stroke
        ..strokeWidth = property.strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(path, paint);
    }
    if (property.fill.a > 0) {
      final fillPaint = Paint()
        ..color = property.fill.toColor()
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);
    }
  }
}
