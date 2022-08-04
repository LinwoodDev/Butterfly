import 'package:adwaita/adwaita.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import 'classic.dart';

class ThemeManager {
  static List<String> getThemes() => [
        'classic',
        'adwaita',
        ...getYaruThemes(),
        ...FlexScheme.values.map((e) => e.name)
      ]..remove('custom');
  static ThemeData getThemeByName(String name, {bool dark = false}) {
    FlexSchemeColor? colorScheme;
    if (name.isEmpty) name = 'classic';
    if (name == 'adwaita') {
      return getAdwaitaTheme(dark: dark);
    }
    final yaruTheme = getYaruTheme(variant: name, dark: dark);
    if (yaruTheme != null) {
      return yaruTheme;
    }
    if (name == 'classic') {
      return getClassicTheme(dark: dark);
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

ThemeData getAdwaitaTheme({bool dark = false}) {
  return dark ? AdwaitaThemeData.dark() : AdwaitaThemeData.light();
}

ThemeData? getYaruTheme({bool dark = false, required String variant}) {
  try {
    if (!variant.startsWith('yaru')) {
      return null;
    }
    variant = variant.substring(4);
    variant = variant[0].toLowerCase() + variant.substring(1);
    YaruVariant yaruVariant = YaruVariant.values.byName(variant);
    return dark ? yaruVariant.darkTheme : yaruVariant.theme;
  } catch (_) {
    return null;
  }
}

List<String> getYaruThemes() => YaruVariant.values
    .map((e) => e.name)
    .map((e) => e.substring(0, 1).toUpperCase() + e.substring(1))
    .map((e) => 'yaru$e')
    .toList();
