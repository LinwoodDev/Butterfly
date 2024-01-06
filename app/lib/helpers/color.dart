import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';

Tool updateToolDefaultColor(Tool tool, int color) {
  final defaultColor =
      isDarkColor(Color(color)) ? BasicColors.white : BasicColors.black;
  return tool.maybeMap(
    pen: (pen) =>
        pen.copyWith(property: pen.property.copyWith(color: defaultColor)),
    shape: (shape) =>
        shape.copyWith(property: shape.property.copyWith(color: defaultColor)),
    label: (label) => label.copyWith(foreground: defaultColor),
    orElse: () => tool,
  );
}
