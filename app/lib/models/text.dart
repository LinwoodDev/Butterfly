import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors.dart';

part 'text.g.dart';
part 'text.freezed.dart';

enum HorizontalAlignment { left, center, right, justify }

enum VerticalAlignment { top, center, bottom }

@freezed
class SpanProperty with _$SpanProperty {
  const factory SpanProperty.defined({
    @Default(12) double size,
    @Default(kColorBlack) int color,
    @Default(3) int fontWeight,
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
    @Default(SpanProperty.undefined()) SpanProperty spanProperty,
    @Default(HorizontalAlignment.left) HorizontalAlignment alignment,
  }) = DefinedParagraphProperty;
  const factory ParagraphProperty.named(String name) = NamedParagraphProperty;
  const factory ParagraphProperty.undefined() = UndefinedParagraphProperty;

  factory ParagraphProperty.fromJson(Map<String, dynamic> json) =>
      _$ParagraphPropertyFromJson(json);
}

@freezed
class AreaProperty with _$AreaProperty {
  const factory AreaProperty.defined({
    @Default(ParagraphProperty.undefined()) ParagraphProperty paragraphProperty,
    @Default(VerticalAlignment.top) VerticalAlignment verticalAlignment,
  }) = DefinedAreaProperty;
  const factory AreaProperty.named(String name) = NamedAreaProperty;
  const factory AreaProperty.undefined() = UndefinedAreaProperty;
  factory AreaProperty.fromJson(Map<String, dynamic> json) =>
      _$AreaPropertyFromJson(json);
}

@freezed
class TextSpan with _$TextSpan {
  const factory TextSpan({
    @Default('') String text,
    @Default(SpanProperty.undefined()) SpanProperty property,
  }) = _TextSpan;

  factory TextSpan.fromJson(Map<String, dynamic> json) =>
      _$TextSpanFromJson(json);
}

@freezed
class TextParagraph with _$TextParagraph {
  const factory TextParagraph({
    @Default(ParagraphProperty.undefined()) ParagraphProperty textProperty,
    @Default([]) List<TextSpan> textSpans,
  }) = _ParagraphProperty;

  factory TextParagraph.fromJson(Map<String, dynamic> json) =>
      _$TextParagraphFromJson(json);
}

@freezed
class TextArea with _$TextArea {
  const factory TextArea({
    @Default(AreaProperty.undefined()) AreaProperty areaProperty,
    @Default([]) List<TextParagraph> textParagraphs,
  }) = _TextArea;
  factory TextArea.fromJson(Map<String, dynamic> json) =>
      _$TextAreaFromJson(json);
}

@freezed
class RichStyleSheet with _$RichStyleSheet {
  const factory RichStyleSheet({
    @Default('') String name,
    @Default({}) Map<String, DefinedSpanProperty> spanProperties,
    @Default({}) Map<String, DefinedParagraphProperty> paragraphProperties,
  }) = _RichStyleSheet;
  factory RichStyleSheet.fromJson(Map<String, dynamic> json) =>
      _$RichStyleSheetFromJson(json);
}

@freezed
class MarkdownStyleSheet with _$MarkdownStyleSheet {
  const factory MarkdownStyleSheet({
    @Default('') String name,
    required DefinedParagraphProperty h1,
    required DefinedParagraphProperty h2,
    required DefinedParagraphProperty h3,
    required DefinedParagraphProperty h4,
    required DefinedParagraphProperty h5,
    required DefinedParagraphProperty h6,
    required DefinedParagraphProperty p,
    required DefinedParagraphProperty blockquote,
    required DefinedParagraphProperty code,
    required DefinedParagraphProperty pre,
    required DefinedParagraphProperty ol,
    required DefinedParagraphProperty ul,
    required DefinedParagraphProperty li,
    required DefinedParagraphProperty table,
    required DefinedParagraphProperty thead,
    required DefinedParagraphProperty tbody,
    required DefinedParagraphProperty tr,
    required DefinedParagraphProperty th,
    required DefinedParagraphProperty td,
    required DefinedSpanProperty em,
    required DefinedSpanProperty strong,
    required DefinedSpanProperty codeSpan,
    required DefinedSpanProperty del,
    required DefinedSpanProperty a,
    required DefinedSpanProperty img,
  }) = _MarkdownStyleSheet;
  factory MarkdownStyleSheet.fromJson(Map<String, dynamic> json) =>
      _$MarkdownStyleSheetFromJson(json);
}
