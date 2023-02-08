import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text.freezed.dart';

@freezed
class TextContext with _$TextContext {
  const TextContext._();
  const factory TextContext(
      {required LabelPainter painter,
      required TextPainter textPainter,
      TextElement? element,
      @Default(false) bool isCreating,
      @Default(TextSelection.collapsed(offset: 0)) TextSelection selection,
      ParagraphProperty? forcedProperty,
      bool? forceParagraph}) = _TextContext;

  TextArea? get area => element?.area;
  PackAssetLocation? get styleSheet => element?.styleSheet;

  int length() => 0;

  bool isParagraph() =>
      forceParagraph ??
      ((selection?.start ?? 0) <= 0 && (selection?.end ?? 0) >= length());

  bool? get isEmpty => length() == 0;

  ParagraphProperty getProperty(AppDocument document) {
    return forcedProperty ??
        area?.paragraph.property ??
        const ParagraphProperty.undefined();
  }

  DefinedParagraphProperty? getDefinedProperty(AppDocument document) {
    final property = getProperty(document);
    if (property is DefinedParagraphProperty) {
      return property;
    }
    if (styleSheet == null) {
      return null;
    }
    return document.getStyle(styleSheet!)?.resolveParagraphProperty(property);
  }
}
