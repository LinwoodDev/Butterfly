import 'dart:math';

import 'package:butterfly/helpers/rect_helper.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:butterfly_api/butterfly_text.dart' as txt;

part 'label.freezed.dart';

@freezed
class LabelContext with _$LabelContext {
  const LabelContext._();
  const factory LabelContext.text(
      {required LabelPainter painter,
      required TextPainter textPainter,
      TextElement? element,
      @Default(false) bool isCreating,
      @Default(1.0) double zoom,
      @Default(TextSelection.collapsed(offset: 0)) TextSelection selection,
      ParagraphProperty? forcedProperty,
      SpanProperty? forcedSpanProperty,
      bool? forceParagraph}) = TextContext;

  const factory LabelContext.markdown({
    required LabelPainter painter,
    required TextPainter textPainter,
    MarkdownElement? element,
    @Default(false) bool isCreating,
    @Default(1.0) double zoom,
    @Default(TextSelection.collapsed(offset: 0)) TextSelection selection,
  }) = MarkdownContext;

  String? get text => labelElement?.text;

  LabelElement? get labelElement => element as LabelElement?;

  PackAssetLocation get styleSheet =>
      labelElement?.styleSheet ?? painter.styleSheet;

  int get length =>
      map(
          text: (e) => e.area?.length,
          markdown: (e) => e.element?.text.length) ??
      0;

  bool isParagraph() {
    if (element == null) return true;
    final force =
        maybeMap(text: (value) => value.forceParagraph, orElse: () => false);
    if (force != null) return force;
    return selection.start <= 0 && selection.end >= length;
  }

  bool? get isEmpty => length == 0;

  Rect? getRect() {
    final current = labelElement;
    if (current == null) return null;
    return Rect.fromLTWH(current.position.x, current.position.y,
        textPainter.width, labelElement!.getHeight(textPainter.height));
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

  DefinedParagraphProperty? getDefinedProperty(NoteData document) {
    final property = getProperty();
    if (property is DefinedParagraphProperty) {
      return property;
    }
    return styleSheet
        .resolveStyle(document)
        ?.resolveParagraphProperty(property);
  }

  SpanProperty? getSpanProperty(NoteData document) {
    final index = selection.start;
    return paragraph?.getSpan(index)?.property.mapOrNull(
              undefined: (_) => null,
              defined: (p) => p,
              named: (p) => p,
            ) ??
        getDefinedProperty(document)?.span;
  }

  DefinedSpanProperty getDefinedSpanProperty(NoteData document) {
    return getSpanProperty(document)?.map(
          defined: (p) => p,
          undefined: (_) => null,
          named: (p) =>
              styleSheet.resolveStyle(document)?.resolveSpanProperty(p),
        ) ??
        const DefinedSpanProperty();
  }

  DefinedParagraphProperty getDefinedForcedProperty(NoteData document) {
    return forcedProperty?.map(
          defined: (p) => p,
          undefined: (_) => null,
          named: (p) =>
              styleSheet.resolveStyle(document)?.resolveParagraphProperty(p),
        ) ??
        const DefinedParagraphProperty();
  }

  DefinedSpanProperty getDefinedForcedSpanProperty(NoteData document,
      [bool fallback = true]) {
    return forcedSpanProperty?.map(
          defined: (p) => p,
          undefined: (_) => null,
          named: (p) =>
              styleSheet.resolveStyle(document)?.resolveSpanProperty(p),
        ) ??
        (fallback
            ? getDefinedSpanProperty(document)
            : const DefinedSpanProperty());
  }

  bool paragraphModified() =>
      getProperty().maybeMap(orElse: () => true, named: (p) => false);

  bool spanModified(NoteData document) =>
      getSpanProperty(document)?.maybeMap(
        orElse: () => true,
        named: (p) => false,
      ) ??
      true;

  bool modified(NoteData document) =>
      isParagraph() ? paragraphModified() : spanModified(document);
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
    switch (align) {
      case txt.VerticalAlignment.top:
        return current;
      case txt.VerticalAlignment.bottom:
        return current + Point(0, height);
      case txt.VerticalAlignment.center:
        return current + Point(0, height / 2);
    }
  }
}
