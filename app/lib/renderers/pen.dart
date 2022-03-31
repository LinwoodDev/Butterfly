part of 'renderer.dart';

class PenRenderer extends PathRenderer<PenElement> {
  PenRenderer(PenElement element) : super(element);

  @override
  Paint buildPaint([bool foreground = false]) => Paint()
    ..color = Color(element.property.color)
    ..style = element.property.fill ? PaintingStyle.fill : PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
}
