import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';

Tool updateToolDefaultColor(Tool tool, int color) {
  final defaultColor =
      isDarkColor(Color(color)) ? BasicColors.white : BasicColors.black;
  return switch (tool) {
    PenTool e => e.copyWith(property: e.property.copyWith(color: defaultColor)),
    ShapeTool e =>
      e.copyWith(property: e.property.copyWith(color: defaultColor)),
    LabelTool e => e.copyWith(foreground: defaultColor),
    _ => tool,
  };
}
