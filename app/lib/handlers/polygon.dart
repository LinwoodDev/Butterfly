part of 'handler.dart';

class PolygonHandler extends Handler<PolygonTool> with ColoredHandler {
  PolygonHandler(super.data);

  @override
  SRGBColor getColor() => data.property.color;

  @override
  PolygonTool setColor(SRGBColor color) =>
      data.copyWith(property: data.property.copyWith(color: color));
}
