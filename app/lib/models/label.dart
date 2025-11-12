import 'dart:math';

import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:butterfly_api/butterfly_text.dart' as txt;

part 'label.freezed.dart';

@freezed
sealed class LabelContext with _$LabelContext {
  const LabelContext._();
  const factory LabelContext.text({
    required LabelTool tool,
    required TextPainter textPainter,
    TextElement? element,
    @Default(1.0) double zoom,
    @Default(TextSelection.collapsed(offset: 0)) TextSelection selection,
    ParagraphProperty? forcedProperty,
    SpanProperty? forcedSpanProperty,
    bool? forceParagraph,
  }) = TextContext;

  const factory LabelContext.markdown({
    required LabelTool tool,
    required TextPainter textPainter,
    MarkdownElement? element,
    @Default(1.0) double zoom,
    @Default(TextSelection.collapsed(offset: 0)) TextSelection selection,
  }) = MarkdownContext;

  bool get isCreating => true;

  String? get text => labelElement?.text;

  LabelElement? get labelElement => element as LabelElement?;

  NamedItem<TextStyleSheet>? getNamedStyleSheet(NoteData document) =>
      labelElement?.styleSheet ?? tool.styleSheet;

  TextStyleSheet? getStyleSheet(NoteData document) =>
      getNamedStyleSheet(document)?.item;

  int get length =>
      switch (this) {
        TextContext e => e.area?.length,
        MarkdownContext e => e.element?.text.length,
      } ??
      0;

  bool isParagraph() {
    if (element == null) return true;
    final force = switch (this) {
      TextContext e => e.forceParagraph,
      _ => false,
    };
    if (force != null) return force;
    return selection.start <= 0 && selection.end >= length;
  }

  bool get isEmpty => length == 0;

  Rect? getRect() {
    final current = labelElement;
    if (current == null) return null;
    return Rect.fromLTWH(
      current.position.x,
      current.position.y,
      textPainter.width,
      labelElement!.getHeight(textPainter.height),
    );
  }

  int nextWordIndex(int index) {
    if (text == null) return 0;
    return text!.substring(index).indexOf(RegExp(r'\w')) + index;
  }

  int previousWordIndex(int index) {
    if (text == null) return 0;
    return text!.substring(0, index).lastIndexOf(RegExp(r'\w'));
  }

  int nextLineIndex(int index) {
    if (text == null) return 0;
    if (index >= length) {
      return length;
    }
    final current = text!.substring(index);
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
    if (text == null) return 0;
    if (index <= 0) {
      return 0;
    }
    return text!.substring(0, index).lastIndexOf(RegExp(r'\n'));
  }
}

extension TextContextHelper on TextContext {
  TextArea? get area => element?.area;
  TextParagraph? get paragraph => area?.paragraph;

  ParagraphProperty getProperty() {
    return forcedProperty ??
        paragraph?.property ??
        const ParagraphProperty.undefined();
  }

  DefinedParagraphProperty getDefinedProperty(NoteData document) {
    final property = getProperty();
    if (property is DefinedParagraphProperty) {
      return property;
    }
    return getStyleSheet(document)?.resolveParagraphProperty(property) ??
        DefinedParagraphProperty();
  }

  SpanProperty? getSpanProperty(NoteData document) {
    final index = selection.start;
    return switch (paragraph?.getSpan(index)?.property) {
      DefinedSpanProperty e => e,
      NamedSpanProperty e => e,
      _ => getDefinedProperty(document).span,
    };
  }

  DefinedSpanProperty getDefinedSpanProperty(NoteData document) {
    return switch (getSpanProperty(document)) {
          DefinedSpanProperty e => e,
          NamedSpanProperty e => getStyleSheet(
            document,
          )?.resolveSpanProperty(e),
          _ => null,
        } ??
        const DefinedSpanProperty();
  }

  DefinedParagraphProperty getDefinedForcedProperty(NoteData document) {
    return switch (forcedProperty) {
          DefinedParagraphProperty e => e,
          NamedParagraphProperty e => getStyleSheet(
            document,
          )?.resolveParagraphProperty(e),
          _ => null,
        } ??
        const DefinedParagraphProperty();
  }

  DefinedSpanProperty getDefinedForcedSpanProperty(
    NoteData document, [
    bool fallback = true,
  ]) {
    return switch (forcedSpanProperty) {
          DefinedSpanProperty e => e,
          NamedSpanProperty e => getStyleSheet(
            document,
          )?.resolveSpanProperty(e),
          _ => null,
        } ??
        (fallback
            ? getDefinedSpanProperty(document)
            : const DefinedSpanProperty());
  }

  bool shouldNewSpan(NoteData document) =>
      getDefinedSpanProperty(document) !=
      getDefinedForcedSpanProperty(document);

  bool paragraphModified() => switch (getProperty()) {
    NamedParagraphProperty _ => false,
    _ => true,
  };

  bool spanModified(NoteData document) => switch (getSpanProperty(document)) {
    NamedParagraphProperty _ => false,
    _ => true,
  };

  bool modified(NoteData document) =>
      isParagraph() ? paragraphModified() : spanModified(document);

  List<txt.InlineSpan> getSpans() {
    if (text == null) return [];
    if (isParagraph()) {
      return paragraph?.getSpans() ?? [];
    } else {
      return paragraph?.getSpans(
            selection.start,
            selection.end - selection.start,
          ) ??
          [];
    }
  }

  bool isMathSelection() {
    final spans = getSpans();
    if (spans.isEmpty) return false;
    return spans.every((e) => e is txt.MathTextSpan);
  }
}

extension LabelElementLayouter on LabelElement {
  double getMaxWidth([Area? area]) {
    var maxWidth = double.infinity;
    if (constraint.size > 0) maxWidth = constraint.size;
    if (constraint.includeArea && area != null) {
      maxWidth = min(maxWidth + position.x, area.rect.right) - position.x;
    }
    return maxWidth;
  }

  double getHeight(double textHeight, [Area? area]) {
    var height = textHeight;
    if (height < constraint.length) {
      height = constraint.length;
    } else if (constraint.includeArea && area != null) {
      height = max(height, area.rect.bottom - position.y);
    }
    return height;
  }

  Point<double> getOffset(double height) {
    final align = areaProperty.alignment;
    final current = position;
    return switch (align) {
      txt.VerticalAlignment.top => current,
      txt.VerticalAlignment.bottom => current + Point(0, height),
      txt.VerticalAlignment.center => current + Point(0, height / 2),
    };
  }
}
