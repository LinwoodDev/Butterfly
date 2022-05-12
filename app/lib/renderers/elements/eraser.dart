part of '../renderer.dart';

class EraserRenderer extends PathRenderer<EraserElement> {
  EraserRenderer(super.element, [super.rect]);

  @override
  Paint buildPaint([bool foreground = false]) {
    return Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..blendMode = foreground ? BlendMode.srcOver : BlendMode.clear;
  }

  @override
  void buildSvg(XmlDocument xml, AppDocument document, Rect rect) {
    final mask = xml
        .getElement('svg')
        ?.getOrCreateElement('defs')
        .getOrCreateElement('mask', id: 'eraser-mask');
    final points = element.points;
    final property = element.property;
    if (points.isEmpty) return;
    // Paint multiple paths
    var last = points.first;
    for (var element in points) {
      final width =
          property.strokeWidth + element.pressure * property.strokeMultiplier;
      mask?.createElement('path', attributes: {
        'd': 'M${element.x} ${element.y} '
            'L${last.x} ${last.y} ',
        'fill': 'none',
        'stroke': 'black',
        'stroke-width': '${width * 2}',
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
        'mask': 'url(#eraser-mask)',
      });
      last = element;
    }
  }
}
