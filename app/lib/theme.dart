import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'main.dart';

const kClassicFirstColor = Color(0xFFf2b138);
const kClassicSecondColor = Color(0xFF00469E);
const kClassicThemePrimary =
    isNightly ? kClassicSecondColor : kClassicFirstColor;
const kClassicThemeSecondary =
    isNightly ? kClassicFirstColor : kClassicSecondColor;
const kClassicTheme = FlexSchemeColor(
    primary: kClassicThemePrimary, secondary: kClassicThemeSecondary);
const kClassicThemeData = FlexSchemeData(
    name: '', description: '', light: kClassicTheme, dark: kClassicTheme);

ThemeData getThemeData(String name, bool dark, [ColorScheme? overridden]) {
  final color = getFlexThemeColor(name, dark);
  final override = overridden != null && name.isEmpty;
  ThemeData theme;
  if (dark) {
    theme = FlexThemeData.dark(
      colors: override ? null : color,
      colorScheme: override ? overridden : null,
      useMaterial3: true,
      appBarElevation: 2,
      fontFamily: 'Comfortaa',
      visualDensity: VisualDensity.compact,
    );
  } else {
    theme = FlexThemeData.light(
      colors: override ? null : color,
      colorScheme: override ? overridden : null,
      useMaterial3: true,
      appBarElevation: 0.5,
      fontFamily: 'Comfortaa',
      visualDensity: VisualDensity.compact,
    );
  }
  return theme.copyWith(
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: defaultDropdownInputDecorationTheme(),
    ),
  );
}

InputDecorationTheme defaultDropdownInputDecorationTheme() {
  return const InputDecorationTheme(
    filled: true,
  );
}

FlexSchemeColor getFlexThemeColor(String name, bool dark) {
  final color = FlexColor.schemesList.firstWhere(
      (scheme) => scheme.name == name,
      orElse: () => kClassicThemeData);
  if (dark) return color.dark;
  return color.light;
}

List<String> getThemes() {
  return FlexColor.schemesList.map((e) => e.name).toList();
}
