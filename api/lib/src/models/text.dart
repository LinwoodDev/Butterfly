import 'dart:math';

import 'package:butterfly_api/src/converter/color.dart';
import 'package:collection/collection.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'pack.dart';

part 'text.freezed.dart';
part 'text.g.dart';

@JsonEnum()
enum HorizontalAlignment { left, center, right, justify }

@JsonEnum()
enum VerticalAlignment { top, center, bottom }

const kFontWeightNormal = 3;
const kFontWeightBold = 6;

@JsonEnum()
enum TextDecorationStyle { solid, double, dotted, dashed, wavy }

@freezed
sealed class SpanProperty with _$SpanProperty {
  const factory SpanProperty.defined({
    double? size,
    @ColorJsonConverter() SRGBColor? color,
    int? fontWeight,
    bool? lineThrough,
    bool? underline,
    bool? overline,
    bool? italic,
    double? letterSpacing,
    @ColorJsonConverter() SRGBColor? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    @ColorJsonConverter() SRGBColor? backgroundColor,
  }) = DefinedSpanProperty;

  static const kDefault = DefinedSpanProperty(
    size: 12,
    color: SRGBColor.black,
    fontWeight: kFontWeightNormal,
    lineThrough: false,
    underline: false,
    overline: false,
    italic: false,
    letterSpacing: 0,
    decorationColor: SRGBColor.black,
    decorationStyle: TextDecorationStyle.solid,
    decorationThickness: 1,
    backgroundColor: SRGBColor.transparent,
  );

  const factory SpanProperty.named(String name) = NamedSpanProperty;

  const factory SpanProperty.undefined() = UndefinedSpanProperty;

  factory SpanProperty.fromJson(Map<String, dynamic> json) =>
      _$SpanPropertyFromJson(json);
}

@freezed
sealed class ParagraphProperty with _$ParagraphProperty {
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
sealed class AreaProperty with _$AreaProperty {
  const factory AreaProperty({
    @Default(VerticalAlignment.top) VerticalAlignment alignment,
  }) = _AreaProperty;

  factory AreaProperty.fromJson(Map<String, dynamic> json) =>
      _$AreaPropertyFromJson(json);
}

@freezed
sealed class TextSpan with _$TextSpan {
  const TextSpan._();
  const factory TextSpan.text({
    @Default('') String text,
    @Default(SpanProperty.undefined()) SpanProperty property,
  }) = _TextSpan;

  factory TextSpan.fromJson(Map<String, dynamic> json) =>
      _$TextSpanFromJson(json);

  int get length => text.length;

  TextSpan subSpan([int start = 0, int? length]) {
    length ??= this.length;
    length = length.clamp(0, this.length);
    start = max(start, 0);
    length = length.clamp(0, this.length - start);
    final end = start + length;
    return copyWith(
      text: text.substring(start, end),
    );
  }

  bool get isEmpty => text.isEmpty;
  bool get isNotEmpty => text.isNotEmpty;
}

@freezed
sealed class IndexedModel<T> with _$IndexedModel<T> {
  const factory IndexedModel(int index, T model) = _IndexedModel<T>;
}

@freezed
sealed class TextParagraph with _$TextParagraph {
  const TextParagraph._();
  const factory TextParagraph({
    @Default(ParagraphProperty.undefined()) ParagraphProperty property,
    @Default([]) List<TextSpan> textSpans,
  }) = _TextParagraph;

  factory TextParagraph.fromJson(Map<String, dynamic> json) =>
      _$TextParagraphFromJson(json);

  int get length =>
      textSpans.fold(0, (value, element) => value + element.length);

  bool get isEmpty => textSpans.every((element) => element.isEmpty);
  bool get isNotEmpty => textSpans.any((element) => element.isNotEmpty);
  String get text => textSpans.map((e) => e.text).join();
  String substring(int start, [int? end]) => text.substring(start, end);

  TextSpan? getSpan(int index, [bool cut = true]) =>
      getIndexedSpan(index, cut)?.model;

  IndexedModel<TextSpan>? getIndexedSpan(int index, [bool cut = true]) {
    var currentLength = 0;
    for (var span in textSpans) {
      if (currentLength + span.length > index) {
        return IndexedModel(
            currentLength, cut ? span.subSpan(index - currentLength) : span);
      }
      currentLength += span.length;
    }
    return null;
  }

  List<TextSpan> getSpans([int start = 0, int? length, bool cut = false]) =>
      getIndexedSpans(start, length, cut).model;

  IndexedModel<List<TextSpan>> getIndexedSpans(
      [int start = 0, int? length, bool cut = false]) {
    length ??= this.length;
    var spans = <TextSpan>[];
    var currentLength = 0;
    int? firstIndex;
    final end = start + length;
    for (var span in textSpans) {
      if (currentLength + span.length > start) {
        if (currentLength >= end) {
          break;
        }
        firstIndex ??= currentLength;
        spans.add(cut
            ? span.subSpan(
                start - currentLength, end - max(currentLength, start))
            : span);
      }
      currentLength += span.length;
    }
    return IndexedModel(firstIndex ?? 0, spans);
  }

  TextParagraph subParagraph([int start = 0, int? length]) {
    length ??= this.length;
    var subSpans = <TextSpan>[];
    var currentLength = 0;
    final end = start + length;
    for (var span in textSpans) {
      if (currentLength + span.length > start) {
        if (currentLength >= end) {
          break;
        }
        final subSpan = span.subSpan(
          start - currentLength,
          end - currentLength,
        );
        if (subSpan.isNotEmpty) {
          subSpans.add(subSpan);
        }
      }
      currentLength += span.length;
    }
    return copyWith(textSpans: subSpans);
  }

  TextParagraph insert(TextSpan span, int offset) {
    List<TextSpan> spans = [];
    spans.addAll(getSpans(0, offset));
    spans.add(span);
    spans.addAll(getSpans(offset));
    return copyWith(textSpans: spans);
  }

  TextParagraph insertText(String text, int offset) {
    List<TextSpan> spans = [];
    // Merge spans
    final span = getSpan(offset) ?? const TextSpan.text();
    var newSpan = span.copyWith(text: span.text + text);
    final before = getSpans(0, offset);
    before.removeLast();
    spans.addAll(before);
    spans.add(newSpan);
    spans.addAll(getSpans(offset + newSpan.length));
    return copyWith(textSpans: spans);
  }

  TextParagraph replace(TextSpan span, [int start = 0, int? length]) {
    length ??= 0;
    var subSpans = <TextSpan>[];
    final end = start + length;

    final endSpans = getSpans(end, null, true);

    if (endSpans.firstOrNull?.property == span.property) {
      final firstSpan = endSpans.removeAt(0);
      span = span.copyWith(text: span.text + firstSpan.text);
    }

    final startSpans = getSpans(0, start, true);

    if (startSpans.lastOrNull?.property == span.property) {
      final lastSpan = startSpans.removeLast();
      span = lastSpan.copyWith(text: lastSpan.text + span.text);
    }

    subSpans.addAll(startSpans);
    subSpans.add(span);
    subSpans.addAll(endSpans);
    return copyWith(textSpans: subSpans);
  }

  TextParagraph replaceText(String text,
      [int start = 0, int? length, bool replaceWholeSpan = false]) {
    final indexed = getIndexedSpan(start);
    length ??= replaceWholeSpan ? indexed?.model.length : 0;
    return replace(
        indexed != null
            ? indexed.model.copyWith(text: text)
            : TextSpan.text(text: text),
        (replaceWholeSpan ? indexed?.index : null) ?? start,
        length);
  }

  TextParagraph remove([int start = 0, int length = 0]) {
    final end = start + (length);

    final beforeSpans = getSpans(0, start, true);
    final afterSpans = getSpans(end, null, true);
// Test if beforeSpans and afterSpans can be merged
    if (beforeSpans.isNotEmpty &&
        beforeSpans.lastOrNull?.property == afterSpans.firstOrNull?.property) {
      final merged = beforeSpans.lastOrNull!.copyWith(
          text: beforeSpans.lastOrNull!.text + afterSpans.firstOrNull!.text);
      afterSpans.removeAt(0);
      beforeSpans.removeLast();
      beforeSpans.add(merged);
    }
    return copyWith(textSpans: [...beforeSpans, ...afterSpans]);
  }

  TextParagraph updateSpans(TextSpan Function(TextSpan) update,
      [int start = 0, int length = 0]) {
    final spans = getSpans(start, length, true);
    if (spans.isEmpty) {
      return this;
    }
    final updated = update(spans.first.copyWith(
      text: spans.map((e) => e.text).join(),
    ));
    return replace(updated, start, length);
  }

  TextParagraph applyStyle(SpanProperty property,
      [int start = 0, int length = 0]) {
    return updateSpans(
      (span) => span.copyWith(property: property),
      start,
      length,
    );
  }
}

@freezed
sealed class TextArea with _$TextArea {
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
sealed class TextStyleSheet extends PackAsset with _$TextStyleSheet {
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
  DefinedSpanProperty? resolveSpanProperty(SpanProperty? property) =>
      switch (property) {
        DefinedSpanProperty e => e,
        NamedSpanProperty e => this?.spanProperties[e.name],
        _ => null,
      };

  DefinedParagraphProperty? resolveParagraphProperty(
          ParagraphProperty? property) =>
      switch (property) {
        DefinedParagraphProperty e => e,
        NamedParagraphProperty e => this?.paragraphProperties[e.name],
        _ => null,
      };
}

extension SpanPropertyGetter on DefinedSpanProperty {
  double getSize([DefinedParagraphProperty? paragraphProperty]) =>
      size ?? paragraphProperty?.span.size ?? SpanProperty.kDefault.size!;
  SRGBColor getColor(
          [DefinedParagraphProperty? paragraphProperty,
          SRGBColor? foreground]) =>
      color ??
      paragraphProperty?.span.color ??
      foreground ??
      SpanProperty.kDefault.color!;
  int getFontWeight([DefinedParagraphProperty? paragraphProperty]) =>
      fontWeight ??
      paragraphProperty?.span.fontWeight ??
      SpanProperty.kDefault.fontWeight!;
  bool getLineThrough([DefinedParagraphProperty? paragraphProperty]) =>
      lineThrough ??
      paragraphProperty?.span.lineThrough ??
      SpanProperty.kDefault.lineThrough!;
  bool getUnderline([DefinedParagraphProperty? paragraphProperty]) =>
      underline ??
      paragraphProperty?.span.underline ??
      SpanProperty.kDefault.underline!;
  bool getOverline([DefinedParagraphProperty? paragraphProperty]) =>
      overline ??
      paragraphProperty?.span.overline ??
      SpanProperty.kDefault.overline!;
  bool getItalic([DefinedParagraphProperty? paragraphProperty]) =>
      italic ?? paragraphProperty?.span.italic ?? SpanProperty.kDefault.italic!;
  double getLetterSpacing([DefinedParagraphProperty? paragraphProperty]) =>
      letterSpacing ??
      paragraphProperty?.span.letterSpacing ??
      SpanProperty.kDefault.letterSpacing!;
  SRGBColor getDecorationColor([DefinedParagraphProperty? paragraphProperty]) =>
      decorationColor ??
      paragraphProperty?.span.decorationColor ??
      SpanProperty.kDefault.decorationColor!;
  TextDecorationStyle getDecorationStyle(
          [DefinedParagraphProperty? paragraphProperty]) =>
      decorationStyle ??
      paragraphProperty?.span.decorationStyle ??
      SpanProperty.kDefault.decorationStyle!;
  double getDecorationThickness(
          [DefinedParagraphProperty? paragraphProperty]) =>
      decorationThickness ??
      paragraphProperty?.span.decorationThickness ??
      SpanProperty.kDefault.decorationThickness!;
  SRGBColor getBackgroundColor([DefinedParagraphProperty? paragraphProperty]) =>
      backgroundColor ??
      paragraphProperty?.span.backgroundColor ??
      SpanProperty.kDefault.backgroundColor!;
}
