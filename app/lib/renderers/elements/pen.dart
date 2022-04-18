part of '../renderer.dart';

class PenRenderer extends PathRenderer<PenElement> {
  PenRenderer(PenElement element, [Rect rect = Rect.zero])
      : super(element, rect);

  @override
  void buildSvg(XmlDocument xml, AppDocument document, Rect rect) {
    final points = element.points;
    final property = element.property;
    if (points.isEmpty) return;
    // Paint multiple paths
    var last = points.first;
    for (var element in points) {
      final width =
          property.strokeWidth + element.pressure * property.strokeMultiplier;
      final localPosition = rect.topLeft + element.toOffset();
      final lastLocalPosition = rect.topLeft + last.toOffset();
      xml.getElement('svg')?.createElement('path', attributes: {
        'd': 'M${localPosition.dx} ${localPosition.dy} '
            'L${lastLocalPosition.dx} ${lastLocalPosition.dy} ',
        'fill': property.fill
            ? '#${property.color.toRadixString(16).substring(2)}'
            : 'none',
        'stroke': '#${property.color.toRadixString(16).substring(2)}',
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
