import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors.dart';

part 'text.g.dart';
part 'text.freezed.dart';

enum HorizontalAlignment { left, center, right, justify }

enum VerticalAlignment { top, center, bottom }

const kFontWeightNormal = 3;
const kFontWeightBold = 6;

enum TextDecorationStyle { solid, double, dotted, dashed, wavy }

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

  TextSpan subSpan([int start = 0, int? length]) {
    length ??= this.length;
    length = length.clamp(0, this.length);
    start = start.clamp(0, length);
    length = length.clamp(0, this.length - start);
    return copyWith(
      text: text.substring(start, length),
    );
  }

  bool get isEmpty => text.isEmpty;
  bool get isNotEmpty => text.isNotEmpty;
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

  bool get isEmpty => textSpans.every((element) => element.isEmpty);
  bool get isNotEmpty => textSpans.any((element) => element.isNotEmpty);

  TextSpan? getSpan(int index) {
    var currentLength = 0;
    for (var span in textSpans) {
      if (currentLength + span.length > index) {
        return span;
      }
      currentLength += span.length;
    }
    return null;
  }

  List<TextSpan> getSpans([int start = 0, int? length]) {
    length ??= this.length;
    var spans = <TextSpan>[];
    var currentLength = 0;
    final end = start + length;
    for (var span in textSpans) {
      if (currentLength + span.length > start) {
        if (currentLength >= end) {
          break;
        }
        spans.add(span.subSpan(
          start - currentLength,
          end - currentLength,
        ));
      }
      currentLength += span.length;
    }
    return spans;
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
    var subSpans = <TextSpan>[];
    final end = start + (length ?? 0);

    subSpans.addAll(getSpans(0, start));
    subSpans.add(span);
    subSpans.addAll(getSpans(end));
    return copyWith(textSpans: subSpans);
  }

  TextParagraph replaceText(String text, [int start = 0, int? length]) {
    var subSpans = <TextSpan>[];
    final end = start + (length ?? 0);

    final span = getSpan(start) ?? const TextSpan.text();
    final newSpan = span.copyWith(text: text);
    subSpans.addAll(getSpans(0, start));
    subSpans.add(newSpan);
    subSpans.addAll(getSpans(end));
    return copyWith(textSpans: subSpans);
  }
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
