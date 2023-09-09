import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';

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

  String toCss() => name;
}

extension DefinedSpanPropertyFlutterConverter on text.DefinedSpanProperty {
  TextStyle toFlutter(
      [text.DefinedParagraphProperty? parent, int? foreground]) {
    return TextStyle(
      fontSize: getSize(parent),
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
      backgroundColor: Color(getBackgroundColor(parent)),
    );
  }

  String toCss([text.DefinedParagraphProperty? parent]) => """
      font-weight: ${getFontWeight(parent)};
      font-style: ${getItalic(parent) ? 'italic' : 'normal'};
      font-size: ${getSize(parent)}px;
      color: #${getColor(parent).toRadixString(16).padLeft(8, '0')};
      letter-spacing: ${getLetterSpacing(parent)}px;
      text-decoration-color: #${getDecorationColor(parent).toRadixString(16).padLeft(8, '0')};
      text-decoration-style: ${getDecorationStyle(parent).toCss()};
      text-decoration-thickness: ${getDecorationThickness(parent)}px;
      text-decoration-line: ${getUnderline(parent) ? 'underline' : 'none'} ${getLineThrough(parent) ? 'line-through' : 'none'} ${getOverline(parent) ? 'overline' : 'none'};
      background-color: #${getBackgroundColor(parent).toHexColor()};
""";
}

extension DefinedParagraphPropertyVisualizer on text.DefinedParagraphProperty {
  String toCss() => """
${span.toCss(this)}
text-align: ${alignment.toFlutter().toString().split('.').last};
""";
}

const kStyleParagraphPrefix = 'paragraph-';
const kStyleSpanPrefix = 'span-';

extension StyleSheetVisualizer on text.TextStyleSheet {
  String toCss({
    String paragraphPrefix = kStyleParagraphPrefix,
    String spanPrefix = kStyleSpanPrefix,
  }) =>
      [
        ...paragraphProperties.entries
            .map((e) => '$paragraphPrefix${e.key}{\n${e.value.toCss()}}'),
        ...spanProperties.entries
            .map((e) => '$spanPrefix${e.key}{\n${e.value.toCss()}}')
      ].join('\n');
}
