import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'main.dart';

const kClassicFirstColor = Color(0xFFc4840d);
const kClassicSecondColor = Color(0xFF7b8f96);
const kClassicThemePrimary = isNightly
    ? kClassicSecondColor
    : kClassicFirstColor;
const kClassicThemeSecondary = isNightly
    ? kClassicFirstColor
    : kClassicSecondColor;
const kClassicTheme = FlexSchemeColor(
  primary: kClassicThemePrimary,
  secondary: kClassicThemeSecondary,
);
const kClassicThemeData = FlexSchemeData(
  name: '',
  description: '',
  light: kClassicTheme,
  dark: kClassicTheme,
);

const EdgeInsets settingsCardMargin = EdgeInsets.all(8);
const EdgeInsets settingsCardPadding = EdgeInsets.all(16);
const EdgeInsets settingsCardTitlePadding = EdgeInsets.only(
  left: 12,
  top: 8,
  right: 12,
);

ThemeData getThemeData(
  String name,
  bool dark, [
  VisualDensity? density,
  ColorScheme? overridden,
  bool highContrast = false,
]) {
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
      visualDensity: density,
      darkIsTrueBlack: highContrast,
      fontFamilyFallback: ['Roboto'],
    );
  } else {
    theme = FlexThemeData.light(
      colors: override ? null : color,
      colorScheme: override ? overridden : null,
      useMaterial3: true,
      appBarElevation: 0.5,
      fontFamily: 'Comfortaa',
      visualDensity: density,
      lightIsWhite: highContrast,
      fontFamilyFallback: ['Roboto'],
    );
  }
  return theme.copyWith(
    tabBarTheme: const TabBarThemeData(tabAlignment: TabAlignment.center),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: defaultDropdownInputDecorationTheme(),
    ),
    sliderTheme: theme.sliderTheme.copyWith(year2023: false),
    progressIndicatorTheme: theme.progressIndicatorTheme.copyWith(
      year2023: false,
    ),
  );
}

InputDecorationTheme defaultDropdownInputDecorationTheme() {
  return const InputDecorationTheme(filled: true);
}

FlexSchemeColor getFlexThemeColor(String name, bool dark) {
  final color = FlexColor.schemesList.firstWhere(
    (scheme) => scheme.name == name,
    orElse: () => kClassicThemeData,
  );
  if (dark) return color.dark;
  return color.light;
}

List<String> getThemes() {
  return ['classic', ...FlexColor.schemesList.map((e) => e.name)];
}
