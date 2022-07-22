import 'package:flutter/material.dart';

const kClassicPrimary = Color(0xFFf2b138);
const kClassicPrimaryDark = Color(0xFFf0a61c);
const kClassicPrimaryDarker = Color(0xFFeea010);
const kClassicPrimaryDarkest = Color(0xFFc4840d);
const kClassicPrimaryLight = Color(0xFFf4bc54);
const kClassicPrimaryLighter = Color(0xFFf5c162);
const kClassicPrimaryLightest = Color(0xFFf7d28c);
const kClassicLight = Color(0xFFe3e3e3);
const kClassicLighter = Color(0xFFf5f5f5);
const kClassicDarker = Color(0xFF000000);
const kClassicDark = Color(0xFF242526);
//const kClassicSecondaryColor = Color(0xFF00469E);
//const kClassicSecondaryVariantColor = Color(0xFF00206f);

ThemeData getClassicTheme({bool dark = false}) {
  final color = dark ? kClassicDark : kClassicLight;
  final colorInverted = dark ? kClassicLight : kClassicDark;
  final colorStronger = dark ? kClassicDarker : kClassicLighter;
  return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          brightness: dark ? Brightness.dark : Brightness.light,
          seedColor: kClassicPrimary),
      listTileTheme: ListTileThemeData(
        selectedTileColor: kClassicPrimaryDark,
        selectedColor: colorInverted,
        tileColor: Colors.transparent,
        iconColor: colorInverted,
        textColor: colorInverted,
      ),
      dialogBackgroundColor: color,
      splashFactory: NoSplash.splashFactory,
      canvasColor: colorStronger,
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return kClassicPrimary;
                  }
                  return Colors.transparent;
                },
              ),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return kClassicLight;
                }
                return kClassicPrimary;
              }),
              splashFactory: NoSplash.splashFactory)));
}
