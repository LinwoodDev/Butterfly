import 'package:butterfly/models/pack.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors.dart';
import 'document.dart';

part 'text.freezed.dart';
part 'text.g.dart';

enum HorizontalAlignment { left, center, right, justify }

enum VerticalAlignment { top, center, bottom }

const kFontWeightNormal = 3;

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
  const factory TextSpan.text({
    @Default('') String text,
    @Default(SpanProperty.undefined()) SpanProperty property,
  }) = _TextSpan;

  factory TextSpan.fromJson(Map<String, dynamic> json) =>
      _$TextSpanFromJson(json);
}

@freezed
class TextParagraph with _$TextParagraph {
  const factory TextParagraph.text({
    @Default(ParagraphProperty.undefined()) ParagraphProperty textProperty,
    @Default([]) List<TextSpan> textSpans,
  }) = _ParagraphProperty;

  factory TextParagraph.fromJson(Map<String, dynamic> json) =>
      _$TextParagraphFromJson(json);
}

@freezed
class TextArea with _$TextArea {
  const factory TextArea({
    @Default(AreaProperty()) AreaProperty areaProperty,
    required TextParagraph paragraph,
  }) = _TextArea;
  factory TextArea.fromJson(Map<String, dynamic> json) =>
      _$TextAreaFromJson(json);
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

  DefinedSpanProperty? resolveSpanProperty(SpanProperty? property) {
    return property?.map(
      defined: (value) => value,
      named: (value) => spanProperties[value],
      undefined: (value) => null,
    );
  }

  DefinedParagraphProperty? resolveParagraphProperty(
      ParagraphProperty? property) {
    return property?.map(
      defined: (value) => value,
      named: (value) => paragraphProperties[value],
      undefined: (value) => null,
    );
  }
}

@freezed
class TextContext with _$TextContext {
  const TextContext._();
  const factory TextContext(
      {required PackAssetLocation styleSheet,
      TextRenderer? renderer,
      @Default(false) bool isCreating,
      SpanProperty? forcedProperty,
      bool? forceParagraph}) = _TextContext;

  TextArea? get area => renderer?.element.area;

  int? length() => renderer?.span?.toPlainText().length ?? 0;

  TextSelection? get selection => renderer?.selection;

  bool isParagraph() =>
      forceParagraph ??
      ((selection?.start ?? 0) <= 0 &&
          (selection?.end ?? 0) >= (length() ?? 0));

  bool? get isEmpty => renderer?.element.text.isEmpty;

  SpanProperty getProperty(AppDocument document) {
    return forcedProperty ??
        (document
                .getStyle(styleSheet)
                ?.resolveParagraphProperty(area?.paragraph.textProperty)
                ?.span ??
            const SpanProperty.undefined());
  }

  DefinedSpanProperty? getDefinedProperty(AppDocument document) => document
      .getStyle(styleSheet)
      ?.resolveParagraphProperty(area?.paragraph.textProperty)
      ?.span;
}
