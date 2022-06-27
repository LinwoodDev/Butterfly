part of '../renderer.dart';

class ShapeRenderer extends Renderer<ShapeElement> {
  @override
  Rect rect;

  ShapeRenderer(super.element, [this.rect = Rect.zero]);

  @override
  FutureOr<void> setup(AppDocument document) async {
    _updateRect();
    await super.setup(document);
    _updateRect();
  }

  @override
  FutureOr<bool> onAreaUpdate(AppDocument document, Area? area) async {
    await super.onAreaUpdate(document, area);
    _updateRect();
    return true;
  }

  void _updateRect() {
    rect = Rect.fromPoints(element.firstPosition, element.secondPosition);
  }

  @override
  FutureOr<void> build(Canvas canvas, Size size, CameraTransform transform,
      [bool foreground = false]) {
    final shape = element.property.shape;
    final paint = _buildPaint();
    if (shape is RectangleShape) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(shape.cornerRadius),
        ),
        paint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          rect.inflate(shape.cornerRadius),
          Radius.circular(shape.cornerRadius),
        ),
        _buildPaint(color: Color(shape.fillColor), style: PaintingStyle.fill),
      );
    } else if (shape is CircleShape) {
      canvas.drawCircle(rect.center, rect.width / 2, paint);
      canvas.drawCircle(
          rect.center,
          rect.width / 2,
          _buildPaint(
              color: Color(shape.fillColor), style: PaintingStyle.fill));
    } else if (shape is LineShape) {
      canvas.drawLine(element.firstPosition, element.secondPosition, paint);
    }
  }

  Paint _buildPaint({Color? color, PaintingStyle? style}) => Paint()
    ..color = color ?? Color(element.property.color)
    ..strokeWidth = element.property.strokeWidth
    ..style = style ?? PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  @override
  void buildSvg(XmlDocument xml, AppDocument document, Rect rect) {
    if (!this.rect.overlaps(rect)) return;
  }

  @override
  ShapeElement move(Offset position) {
    // Center of firstPosition and secondPosition
    final elementPosition =
        Rect.fromPoints(element.firstPosition, element.secondPosition).center;
    final offset = position - elementPosition;
    return element.copyWith(
      firstPosition: element.firstPosition + offset,
      secondPosition: element.secondPosition + offset,
    );
  }
}
