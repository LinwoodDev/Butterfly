import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';

extension HorizontalTextAlignmentFlutterConverter on text.HorizontalAlignment {
  TextAlign toFlutter() => switch (this) {
    text.HorizontalAlignment.left => TextAlign.left,
    text.HorizontalAlignment.right => TextAlign.right,
    text.HorizontalAlignment.center => TextAlign.center,
    text.HorizontalAlignment.justify => TextAlign.justify,
  };
}

extension TextDecorationStyleFlutterConverter on text.TextDecorationStyle {
  TextDecorationStyle toFlutter() => switch (this) {
    text.TextDecorationStyle.solid => TextDecorationStyle.solid,
    text.TextDecorationStyle.double => TextDecorationStyle.double,
    text.TextDecorationStyle.dotted => TextDecorationStyle.dotted,
    text.TextDecorationStyle.dashed => TextDecorationStyle.dashed,
    text.TextDecorationStyle.wavy => TextDecorationStyle.wavy,
  };

  String toCss() => name;
}

extension DefinedSpanPropertyFlutterConverter on text.DefinedSpanProperty {
  TextStyle toFlutter([
    text.DefinedParagraphProperty? parent,
    SRGBColor? foreground,
  ]) {
    return TextStyle(
      fontSize: getSize(parent),
      color: getColor(parent, foreground).toColor(),
      fontFamily: 'Roboto',
      fontStyle: getItalic(parent) ? FontStyle.italic : FontStyle.normal,
      fontWeight: FontWeight.values[getFontWeight(parent)],
      letterSpacing: getLetterSpacing(parent),
      decorationColor: getDecorationColor(parent).toColor(),
      decorationStyle: getDecorationStyle(parent).toFlutter(),
      decorationThickness: getDecorationThickness(parent),
      decoration: TextDecoration.combine([
        if (getUnderline(parent)) TextDecoration.underline,
        if (getLineThrough(parent)) TextDecoration.lineThrough,
        if (getOverline(parent)) TextDecoration.overline,
      ]),
      backgroundColor: getBackgroundColor(parent).toColor(),
    );
  }

  String toCss([text.DefinedParagraphProperty? parent]) =>
      """
      font-weight: ${getFontWeight(parent)};
      font-style: ${getItalic(parent) ? 'italic' : 'normal'};
      font-size: ${getSize(parent)}px;
      color: ${getColor(parent).toHexString()};
      letter-spacing: ${getLetterSpacing(parent)}px;
      text-decoration-color: ${getDecorationColor(parent).toHexString()};
      text-decoration-style: ${getDecorationStyle(parent).toCss()};
      text-decoration-thickness: ${getDecorationThickness(parent)}px;
      text-decoration-line: ${getUnderline(parent) ? 'underline' : 'none'} ${getLineThrough(parent) ? 'line-through' : 'none'} ${getOverline(parent) ? 'overline' : 'none'};
      background-color: ${getBackgroundColor(parent).toHexString()};
""";
}

extension DefinedParagraphPropertyVisualizer on text.DefinedParagraphProperty {
  String toCss() =>
      """
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
  }) => [
    ...paragraphProperties.entries.map(
      (e) => '$paragraphPrefix${e.key}{\n${e.value.toCss()}}',
    ),
    ...spanProperties.entries.map(
      (e) => '$spanPrefix${e.key}{\n${e.value.toCss()}}',
    ),
  ].join('\n');
}

extension TextDecorationStyleVisualizer on text.TextDecorationStyle {
  String getLocalizedName(BuildContext context) => switch (this) {
    text.TextDecorationStyle.solid => AppLocalizations.of(context).solid,
    text.TextDecorationStyle.double => AppLocalizations.of(context).double,
    text.TextDecorationStyle.dotted => AppLocalizations.of(context).dotted,
    text.TextDecorationStyle.dashed => AppLocalizations.of(context).dashed,
    text.TextDecorationStyle.wavy => AppLocalizations.of(context).wavy,
  };
}
