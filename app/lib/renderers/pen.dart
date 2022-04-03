part of 'renderer.dart';

class PenRenderer extends PathRenderer<PenElement> {
  PenRenderer(PenElement element, [Rect rect = Rect.zero])
      : super(element, rect);

  @override
  Paint buildPaint([bool foreground = false]) => Paint()
    ..color = Color(element.property.color)
    ..style = element.property.fill ? PaintingStyle.fill : PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  PathRenderer<PenElement> _copyWith({PenElement? element, Rect? rect}) =>
      PenRenderer(element ?? this.element, rect ?? this.rect);
}
