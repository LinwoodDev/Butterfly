import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_leap/material_leap.dart';

SRGBColor _readableDefaultColor(SRGBColor color) {
  return color.toColor().isDark() ? SRGBColor.white : SRGBColor.black;
}

SRGBColor _updateColor(
  SRGBColor color,
  SRGBColor defaultColor, {
  bool force = false,
}) {
  return force || color == SRGBColor.black ? defaultColor : color;
}

ElementPaint _updatePaintDefaultColor(
  ElementPaint paint,
  SRGBColor defaultColor, {
  bool force = false,
}) {
  return switch (paint) {
    SolidElementPaint e => e.copyWith(
      color: _updateColor(e.color, defaultColor, force: force),
    ),
    _ when force => ElementPaint.solid(color: defaultColor),
    _ => paint,
  };
}

Tool updateToolDefaultColor(Tool tool, SRGBColor color, {bool force = false}) {
  final defaultColor = _readableDefaultColor(color);

  return switch (tool) {
    PenTool e => e.copyWith(
      property: e.property.copyWith(
        paint: _updatePaintDefaultColor(
          e.property.paint,
          defaultColor,
          force: force,
        ),
      ),
    ),
    ShapeTool e => e.copyWith(
      property: e.property.copyWith(
        paint: _updatePaintDefaultColor(
          e.property.paint,
          defaultColor,
          force: force,
        ),
      ),
    ),
    PolygonTool e => e.copyWith(
      property: e.property.copyWith(
        paint: _updatePaintDefaultColor(
          e.property.paint,
          defaultColor,
          force: force,
        ),
      ),
    ),
    LabelTool e => e.copyWith(
      foreground: _updateColor(e.foreground, defaultColor, force: force),
    ),
    BarcodeTool e => e.copyWith(
      color: _updateColor(e.color, defaultColor, force: force),
    ),
    _ => tool,
  };
}
