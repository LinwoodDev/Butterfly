import 'package:butterfly/theme/themes.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static List<String> getThemes() => List<String>.from(kCustomSchemes.keys)
    ..addAll(FlexScheme.values.map((e) => e.name))
    ..remove('custom');
  static ThemeData getThemeByName(String name, {bool dark = false}) {
    FlexSchemeColor? colorScheme;
    if (name.isEmpty) name = 'classic';
    if (kCustomSchemes.containsKey(name)) {
      colorScheme =
          dark ? kCustomSchemes[name]!.dark : kCustomSchemes[name]!.light;
    }
    if (colorScheme == null) {
      try {
        var scheme = FlexScheme.values.firstWhere((e) => e.name == name);
        var colors = FlexColor.schemes[scheme];
        colorScheme = dark ? colors?.dark : colors?.light;
      } catch (e) {
        colorScheme = dark
            ? FlexColor.schemes[FlexScheme.material]?.dark
            : FlexColor.schemes[FlexScheme.material]?.light;
      }
    }
    if (dark) {
      return FlexThemeData.dark(
          fontFamily: 'Roboto',
          colors: colorScheme,
          useMaterial3: true,
          useMaterial3ErrorColors: true,
          appBarStyle: FlexAppBarStyle.material);
    } else {
      return FlexThemeData.light(
          fontFamily: 'Roboto',
          colors: colorScheme,
          useMaterial3: true,
          useMaterial3ErrorColors: true,
          appBarStyle: FlexAppBarStyle.material);
    }
  }
}
