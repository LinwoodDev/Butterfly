import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors.dart';

part 'text.g.dart';
part 'text.freezed.dart';

@JsonEnum()
enum HorizontalAlignment { left, center, right, justify }

@JsonEnum()
enum VerticalAlignment { top, center, bottom }

const kFontWeightNormal = 3;
const kFontWeightBold = 6;

@JsonEnum()
enum TextDecorationStyle { solid, double, dotted, dashed, wavy }

@freezed
class SpanProperty with _$SpanProperty {
  const factory SpanProperty.defined({
    double? size,
    int? color,
    int? fontWeight,
    bool? lineThrough,
    bool? underline,
    bool? overline,
    bool? italic,
    double? letterSpacing,
    int? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) = DefinedSpanProperty;

  static const kDefault = DefinedSpanProperty(
    size: 12,
    color: kColorBlack,
    fontWeight: kFontWeightNormal,
    lineThrough: false,
    underline: false,
    overline: false,
    italic: false,
    letterSpacing: 0,
    decorationColor: kColorBlack,
    decorationStyle: TextDecorationStyle.solid,
    decorationThickness: 1,
  );

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
    final end = start + length;
    return copyWith(
      text: text.substring(start, end),
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
  String get text => textSpans.map((e) => e.text).join();
  String substring(int start, [int? end]) => text.substring(start, end);

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

  TextParagraph remove([int start = 0, int? length]) {
    var subSpans = <TextSpan>[];
    final end = start + (length ?? 0);

    subSpans.addAll(getSpans(0, start));
    subSpans.addAll(getSpans(end));
    return copyWith(textSpans: subSpans);
  }

  TextParagraph updateSpans(
      int start, int? length, TextSpan Function(TextSpan) update) {
    var subSpans = <TextSpan>[];
    final end = start + (length ?? 0);

    subSpans.addAll(getSpans(0, start));
    subSpans.addAll(getSpans(start, length).map(update));
    subSpans.addAll(getSpans(end));
    return copyWith(textSpans: subSpans);
  }

  TextParagraph applyStyle(int start, int? length, SpanProperty property) {
    final span = getSpan(start)?.copyWith(
        property: property, text: substring(start, start + (length ?? 0)));
    if (span == null) {
      return this;
    }
    return replace(
      span,
      start,
      length,
    );
  }

  int nextWordIndex(int index) {
    return text.substring(index).indexOf(RegExp(r'\w')) + index;
  }

  int previousWordIndex(int index) {
    return text.substring(0, index).lastIndexOf(RegExp(r'\w'));
  }

  int nextLineIndex(int index) {
    if (index >= length) {
      return length;
    }
    final current = text.substring(index);
    if (current.isEmpty) {
      return index;
    }
    final next = current.indexOf(RegExp(r'\n'));
    if (next == -1) {
      return length;
    }
    return next + index;
  }

  int previousLineIndex(int index) {
    if (index <= 0) {
      return 0;
    }
    return text.substring(0, index).lastIndexOf(RegExp(r'\n'));
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
      named: (value) => this?.spanProperties[value.name],
      undefined: (value) => null,
    );
  }

  DefinedParagraphProperty? resolveParagraphProperty(
      ParagraphProperty? property) {
    return property?.map(
      defined: (value) => value,
      named: (value) => this?.paragraphProperties[value.name],
      undefined: (value) => null,
    );
  }
}

extension SpanPropertyGetter on DefinedSpanProperty {
  double getSize([DefinedParagraphProperty? paragraphProperty]) =>
      size ?? paragraphProperty?.span.size ?? SpanProperty.kDefault.size!;
  int getColor([DefinedParagraphProperty? paragraphProperty]) =>
      color ?? paragraphProperty?.span.color ?? SpanProperty.kDefault.color!;
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
  int getDecorationColor([DefinedParagraphProperty? paragraphProperty]) =>
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
}
