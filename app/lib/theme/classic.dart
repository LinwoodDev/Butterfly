import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

const kClassicPrimaryColor = Color(0xFFF2B138);
const kClassicPrimaryVariantColor = Color(0xFFbb8200);
const kClassicSecondaryColor = Color(0xFF00469E);
const kClassicSecondaryVariantColor = Color(0xFF00206f);
const kClassicColor = FlexSchemeColor(
    primary: kClassicPrimaryColor,
    primaryContainer: kClassicPrimaryVariantColor,
    secondary: kClassicSecondaryColor,
    secondaryContainer: kClassicSecondaryVariantColor);
const kClassicTheme = FlexSchemeData(
  name: 'Classic',
  description: 'The old look',
  light: kClassicColor,
  dark: kClassicColor,
);
