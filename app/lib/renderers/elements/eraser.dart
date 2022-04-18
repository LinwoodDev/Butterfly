part of '../renderer.dart';

class EraserRenderer extends PathRenderer<EraserElement> {
  EraserRenderer(EraserElement element, [Rect rect = Rect.zero])
      : super(element, rect);

  @override
  Paint buildPaint([bool foreground = false]) => Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white
    ..strokeCap = StrokeCap.round
    ..blendMode = foreground ? BlendMode.srcOver : BlendMode.clear;

  @override
  void buildSvg(XmlDocument xml, AppDocument document, Rect rect) {
    final mask =
        xml.getElement('svg')?.getOrCreateElement('mask', id: 'eraser-mask');
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
      mask?.createElement('path', attributes: {
        'd': 'M${localPosition.dx} ${localPosition.dy} '
            'L${lastLocalPosition.dx} ${lastLocalPosition.dy} ',
        'fill': 'none',
        'stroke': 'white',
        'stroke-width': '${width * 2}',
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
      });
    }
  }
}
