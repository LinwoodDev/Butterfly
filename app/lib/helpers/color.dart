import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_leap/material_leap.dart';

Tool updateToolDefaultColor(Tool tool, SRGBColor color) {
  final defaultColor = color.toColor().isDark()
      ? SRGBColor.white
      : SRGBColor.black;
  return switch (tool) {
    PenTool e => e.copyWith(property: e.property.copyWith(color: defaultColor)),
    ShapeTool e => e.copyWith(
      property: e.property.copyWith(color: defaultColor),
    ),
    LabelTool e => e.copyWith(foreground: defaultColor),
    BarcodeTool e => e.copyWith(color: defaultColor),
    _ => tool,
  };
}
