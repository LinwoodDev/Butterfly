part of '../renderer.dart';

class PenRenderer extends PathRenderer<PenElement> {
  PenRenderer(super.element, [super.rect = Rect.zero]);

  @override
  double? get zoom => element.zoom;

  @override
  void buildSvg(XmlDocument xml, DocumentPage page, Rect viewportRect) {
    if (!rect.overlaps(rect)) return;
    final points = element.points;
    final property = element.property;
    if (points.isEmpty) return;
    // Paint multiple paths
    var last = points.first;
    for (var element in points) {
      final width = property.strokeWidth + element.pressure * property.thinning;
      xml.getElement('svg')?.createElement('path', attributes: {
        'd': 'M${element.x} ${element.y} '
            'L${last.x} ${last.y} ',
        'fill': property.fill ? property.color.toHexColor() : 'none',
        'stroke': property.color.toHexColor(),
        'stroke-width': '${width}px',
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
      });
      last = element;
    }
  }

  @override
  Paint buildPaint([DocumentPage? page, bool foreground = false]) => Paint()
    ..color = Color(element.property.color)
    ..style = element.property.fill ? PaintingStyle.fill : PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  PenRenderer transform(
          {Offset position = Offset.zero,
          double scaleX = 1,
          double scaleY = 1,
          bool relative = false}) =>
      PenRenderer(
          element.copyWith(
              points: movePoints(position, scaleX, scaleY, relative)),
          moveRect(position, scaleX, scaleY, relative));
}
