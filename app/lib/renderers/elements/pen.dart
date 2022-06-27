part of '../renderer.dart';

class PenRenderer extends PathRenderer<PenElement> {
  PenRenderer(super.element, [super.rect = Rect.zero]);

  @override
  void buildSvg(XmlDocument xml, AppDocument document, Rect rect) {
    if (!this.rect.overlaps(rect)) return;
    final points = element.points;
    final property = element.property;
    if (points.isEmpty) return;
    // Paint multiple paths
    var last = points.first;
    for (var element in points) {
      final width =
          property.strokeWidth + element.pressure * property.strokeMultiplier;
      xml.getElement('svg')?.createElement('path', attributes: {
        'd': 'M${element.x} ${element.y} '
            'L${last.x} ${last.y} ',
        'fill': property.fill ? property.color.toHex() : 'none',
        'stroke': property.color.toHex(),
        'stroke-width': '${width}px',
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
      });
      last = element;
    }
  }

  @override
  Paint buildPaint([bool foreground = false]) => Paint()
    ..color = Color(element.property.color)
    ..style = element.property.fill ? PaintingStyle.fill : PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
}
