import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';

extension HorizontalTextAlignmentFlutterConverter on text.HorizontalAlignment {
  TextAlign toFlutter() {
    switch (this) {
      case text.HorizontalAlignment.left:
        return TextAlign.left;
      case text.HorizontalAlignment.right:
        return TextAlign.right;
      case text.HorizontalAlignment.center:
        return TextAlign.center;
      case text.HorizontalAlignment.justify:
        return TextAlign.justify;
    }
  }
}

extension TextDecorationStyleFlutterConverter on text.TextDecorationStyle {
  TextDecorationStyle toFlutter() {
    switch (this) {
      case text.TextDecorationStyle.solid:
        return TextDecorationStyle.solid;
      case text.TextDecorationStyle.double:
        return TextDecorationStyle.double;
      case text.TextDecorationStyle.dotted:
        return TextDecorationStyle.dotted;
      case text.TextDecorationStyle.dashed:
        return TextDecorationStyle.dashed;
      case text.TextDecorationStyle.wavy:
        return TextDecorationStyle.wavy;
    }
  }
}

extension DefinedSpanPropertyFlutterConverter on text.DefinedSpanProperty {
  TextStyle toFlutter(
      [double scale = 1,
      text.DefinedParagraphProperty? parent,
      int? foreground]) {
    return TextStyle(
      fontSize: getSize(parent) * scale,
      color: Color(getColor(parent, foreground)),
      fontFamily: 'Roboto',
      fontStyle: getItalic(parent) ? FontStyle.italic : FontStyle.normal,
      fontWeight: FontWeight.values[getFontWeight(parent)],
      letterSpacing: getLetterSpacing(parent),
      decorationColor: Color(getDecorationColor(parent)),
      decorationStyle: getDecorationStyle(parent).toFlutter(),
      decorationThickness: getDecorationThickness(parent),
      decoration: TextDecoration.combine([
        if (getUnderline(parent)) TextDecoration.underline,
        if (getLineThrough(parent)) TextDecoration.lineThrough,
        if (getOverline(parent)) TextDecoration.overline,
      ]),
    );
  }
}
