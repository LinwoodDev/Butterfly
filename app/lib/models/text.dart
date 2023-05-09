import 'dart:math';

import 'package:butterfly/helpers/rect_helper.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;

part 'text.freezed.dart';

@freezed
class TextContext with _$TextContext {
  const TextContext._();
  const factory TextContext(
      {required LabelPainter painter,
      required TextPainter textPainter,
      TextElement? element,
      @Default(false) bool isCreating,
      @Default(1.0) double zoom,
      @Default(TextSelection.collapsed(offset: 0)) TextSelection selection,
      ParagraphProperty? forcedProperty,
      SpanProperty? forcedSpanProperty,
      bool? forceParagraph}) = _TextContext;

  TextArea? get area => element?.area;
  PackAssetLocation? get styleSheet =>
      element?.styleSheet ?? painter.styleSheet;
  TextParagraph? get paragraph => area?.paragraph;

  int length() => 0;

  bool isParagraph() =>
      element == null ||
      (forceParagraph ?? (selection.start <= 0 && selection.end >= length()));

  bool? get isEmpty => length() == 0;

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
    if (styleSheet == null) {
      return null;
    }
    return styleSheet
        ?.resolveStyle(document)
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
              styleSheet?.resolveStyle(document)?.resolveSpanProperty(p),
        ) ??
        const DefinedSpanProperty();
  }

  DefinedParagraphProperty getDefinedForcedProperty(NoteData document) {
    return forcedProperty?.map(
          defined: (p) => p,
          undefined: (_) => null,
          named: (p) =>
              styleSheet?.resolveStyle(document)?.resolveParagraphProperty(p),
        ) ??
        const DefinedParagraphProperty();
  }

  DefinedSpanProperty getDefinedForcedSpanProperty(NoteData document,
      [bool fallback = true]) {
    return forcedSpanProperty?.map(
          defined: (p) => p,
          undefined: (_) => null,
          named: (p) =>
              styleSheet?.resolveStyle(document)?.resolveSpanProperty(p),
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

  Rect? getRect() {
    if (element == null) return null;
    return Rect.fromLTWH(element!.position.x, element!.position.y,
        textPainter.width, element!.getHeight(textPainter.height));
  }
}

extension TextElementLayouter on TextElement {
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
    final align = area.areaProperty.alignment;
    final current = position;
    switch (align) {
      case text.VerticalAlignment.top:
        return current;
      case text.VerticalAlignment.bottom:
        return current + Point(0, height);
      case text.VerticalAlignment.center:
        return current + Point(0, height / 2);
    }
  }
}
