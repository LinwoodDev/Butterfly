import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors.dart';

part 'text.g.dart';
part 'text.freezed.dart';

enum HorizontalAlignment { left, center, right, justify }

enum VerticalAlignment { top, center, bottom }

const kFontWeightNormal = 3;
const kFontWeightBold = 6;

@freezed
class SpanProperty with _$SpanProperty {
  const factory SpanProperty.defined({
    @Default(12) double size,
    @Default(kColorBlack) int color,
    @Default(kFontWeightNormal) int fontWeight,
    @Default(false) bool lineThrough,
    @Default(false) bool underline,
    @Default(false) bool overline,
    @Default(false) bool italic,
    @Default(0) double letterSpacing,
    @Default(kColorBlack) int decorationColor,
    @Default(TextDecorationStyle.solid) TextDecorationStyle decorationStyle,
    @Default(1) double decorationThickness,
  }) = DefinedSpanProperty;

  const factory SpanProperty.named(String name) = NamedSpanProperty;

  const factory SpanProperty.undefined() = UndefinedSpanProperty;

  factory SpanProperty.fromJson(Map<String, dynamic> json) =>
      _$SpanPropertyFromJson(json);
}

@freezed
class ParagraphProperty with _$ParagraphProperty {
  const factory ParagraphProperty.defined({
    @Default(DefinedSpanProperty()) DefinedSpanProperty span,
    @Default(HorizontalAlignment.left) HorizontalAlignment alignment,
  }) = DefinedParagraphProperty;
  const factory ParagraphProperty.named(String name) = NamedParagraphProperty;
  const factory ParagraphProperty.undefined() = UndefinedParagraphProperty;

  factory ParagraphProperty.fromJson(Map<String, dynamic> json) =>
      _$ParagraphPropertyFromJson(json);
}

@freezed
class AreaProperty with _$AreaProperty {
  const factory AreaProperty({
    @Default(VerticalAlignment.top) VerticalAlignment alignment,
  }) = _AreaProperty;

  factory AreaProperty.fromJson(Map<String, dynamic> json) =>
      _$AreaPropertyFromJson(json);
}

@freezed
class TextSpan with _$TextSpan {
  const TextSpan._();
  const factory TextSpan.text({
    @Default('') String text,
    @Default(SpanProperty.undefined()) SpanProperty property,
  }) = _TextSpan;

  factory TextSpan.fromJson(Map<String, dynamic> json) =>
      _$TextSpanFromJson(json);

  int get length => text.length;
}

@freezed
class TextParagraph with _$TextParagraph {
  const TextParagraph._();
  const factory TextParagraph.text({
    @Default(ParagraphProperty.undefined()) ParagraphProperty property,
    @Default([]) List<TextSpan> textSpans,
  }) = _ParagraphProperty;

  factory TextParagraph.fromJson(Map<String, dynamic> json) =>
      _$TextParagraphFromJson(json);

  int get length =>
      textSpans.fold(0, (value, element) => value + element.length);
}

@freezed
class TextArea with _$TextArea {
  const TextArea._();
  const factory TextArea({
    @Default(AreaProperty()) AreaProperty areaProperty,
    required TextParagraph paragraph,
  }) = _TextArea;

  factory TextArea.fromJson(Map<String, dynamic> json) =>
      _$TextAreaFromJson(json);

  int get length => paragraph.length;
}

@freezed
class TextStyleSheet with _$TextStyleSheet {
  const TextStyleSheet._();

  const factory TextStyleSheet({
    @Default('') String name,
    @Default({}) Map<String, DefinedSpanProperty> spanProperties,
    @Default({}) Map<String, DefinedParagraphProperty> paragraphProperties,
  }) = _TextStyleSheet;
  factory TextStyleSheet.fromJson(Map<String, dynamic> json) =>
      _$TextStyleSheetFromJson(json);

  static List<String> getMarkdownSpanPropertyNames() {
    return [
      'em',
      'strong',
      'codeSpan',
      'del',
      'a',
      'img',
    ];
  }

  static List<String> getMarkdownParagraphPropertyNames() {
    return [
      'h1',
      'h2',
      'h3',
      'h4',
      'h5',
      'h6',
      'p',
      'blockquote',
      'code',
      'pre',
      'ol',
      'ul',
      'li',
      'table',
      'thead',
      'tbody',
      'tr',
      'th',
      'td',
    ];
  }

  DefinedSpanProperty? getSpanProperty(String name) {
    return spanProperties[name];
  }

  DefinedParagraphProperty? getParagraphProperty(String name) {
    return paragraphProperties[name];
  }
}

extension ResolveProperty on TextStyleSheet? {
  DefinedSpanProperty? resolveSpanProperty(SpanProperty? property) {
    return property?.map(
      defined: (value) => value,
      named: (value) => this?.spanProperties[value],
      undefined: (value) => null,
    );
  }

  DefinedParagraphProperty? resolveParagraphProperty(
      ParagraphProperty? property) {
    return property?.map(
      defined: (value) => value,
      named: (value) => this?.paragraphProperties[value],
      undefined: (value) => null,
    );
  }
}
