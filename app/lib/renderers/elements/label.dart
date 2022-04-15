part of '../renderer.dart';

class LabelRenderer extends Renderer<LabelElement> {
  @override
  Rect rect;

  LabelRenderer(LabelElement element, [this.rect = Rect.zero]) : super(element);

  TextPainter _createPainter() => TextPainter(
      text: TextSpan(
          style: TextStyle(
              fontSize: element.property.size,
              fontStyle:
                  element.property.italic ? FontStyle.italic : FontStyle.normal,
              color: Color(element.property.color),
              fontWeight: FontWeight.values[element.property.fontWeight],
              letterSpacing: element.property.letterSpacing,
              decorationColor: Color(element.property.decorationColor),
              decorationStyle: element.property.decorationStyle,
              decorationThickness: element.property.decorationThickness,
              decoration: TextDecoration.combine([
                if (element.property.underline) TextDecoration.underline,
                if (element.property.lineThrough) TextDecoration.lineThrough,
                if (element.property.overline) TextDecoration.overline,
              ])),
          text: element.text),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      textScaleFactor: 1.0);

  @override
  FutureOr<void> setup(AppDocument document) {
    final tp = _createPainter();
    tp.layout();
    rect = Rect.fromLTWH(
        element.position.dx, element.position.dy, tp.width, tp.height);
    super.setup(document);
  }

  @override
  FutureOr<void> build(Canvas canvas, Size size, CameraTransform transform,
      [bool foreground = false]) {
    final tp = _createPainter();
    tp.layout();
    var current = element.position;
    tp.paint(canvas, current);
  }

  @override
  LabelElement move(Offset position) => element.copyWith(position: position);
}
