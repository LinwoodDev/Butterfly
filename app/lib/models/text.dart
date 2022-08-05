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
class AbstractProperty with _$AbstractProperty {
  const factory AbstractProperty.defined({
    @Default(SpanProperty.undefined()) SpanProperty spanProperty,
    @Default(HorizontalAlignment.left) HorizontalAlignment alignment,
  }) = DefinedAbstractProperty;
  const factory AbstractProperty.named(String name) = NamedAbstractProperty;
  const factory AbstractProperty.undefined() = UndefinedAbstractProperty;

  factory AbstractProperty.fromJson(Map<String, dynamic> json) =>
      _$AbstractPropertyFromJson(json);
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
class TextAbstract with _$TextAbstract {
  const factory TextAbstract({
    @Default(AbstractProperty.undefined()) AbstractProperty textProperty,
    @Default([]) List<TextSpan> textSpans,
  }) = _AbstractProperty;

  factory TextAbstract.fromJson(Map<String, dynamic> json) =>
      _$TextAbstractFromJson(json);
}
