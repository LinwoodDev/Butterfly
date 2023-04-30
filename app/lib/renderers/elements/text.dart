part of '../renderer.dart';

class TextRenderer extends Renderer<TextElement> {
  @override
  Rect rect = Rect.zero;
  TextPainter? _tp;
  TextContext? context;

  TextRenderer(super.element, [this.context]);

  TextAlign _convertAlignment(text.HorizontalAlignment alignment) {
    switch (alignment) {
      case text.HorizontalAlignment.left:
        return TextAlign.left;
      case text.HorizontalAlignment.right:
        return TextAlign.right;
      case text.HorizontalAlignment.center:
        return TextAlign.center;
      case text.HorizontalAlignment.justify:
        return TextAlign.justify;
    }
  }

  void _createPainter(NoteData document) {
    final paragraph = element.area.paragraph;
    final styleSheet = document.getStyle(element.styleSheet);
    final style = styleSheet.resolveParagraphProperty(paragraph.property) ??
        const text.DefinedParagraphProperty();
    _tp ??= context?.textPainter ?? TextPainter();
    _tp?.text = _createParagraphSpan(document, paragraph);
    _tp?.textDirection = TextDirection.ltr;
    _tp?.textScaleFactor = 1.0;
    _tp?.textAlign = _convertAlignment(style.alignment);
  }

  TextSpan _createParagraphSpan(
      DocumentPage page, text.TextParagraph paragraph) {
    final styleSheet = document.getStyle(element.styleSheet);
    final style = styleSheet.resolveParagraphProperty(paragraph.property) ??
        const text.DefinedParagraphProperty();
    return paragraph.map(
      text: (p) => TextSpan(
        children:
            p.textSpans.map((e) => _createSpan(document, e, style)).toList(),
        style: _buildSpanStyle(style.span),
      ),
    );
  }

  text.TextStyleSheet? _getStyle(NoteData document) =>
      document.getStyle(element.styleSheet);

  InlineSpan _createSpan(DocumentPage page, text.TextSpan span,
      [text.DefinedParagraphProperty? parent]) {
    final styleSheet = _getStyle(document);
    final style = styleSheet.resolveSpanProperty(span.property);
    return TextSpan(
      text: span.text,
      style: style == null ? null : _buildSpanStyle(style, parent),
    );
  }

  TextStyle _buildSpanStyle(text.DefinedSpanProperty property,
      [text.DefinedParagraphProperty? parent]) {
    return TextStyle(
      fontSize: property.getSize(parent) * element.scale,
      color: Color(property.getColor(parent)),
      fontFamily: 'Roboto',
      fontStyle:
          property.getItalic(parent) ? FontStyle.italic : FontStyle.normal,
      fontWeight: FontWeight.values[property.getFontWeight(parent)],
      letterSpacing: property.getLetterSpacing(parent),
      decorationColor: Color(property.getDecorationColor(parent)),
      decorationStyle: getDecorationStyle(property.getDecorationStyle(parent)),
      decorationThickness: property.getDecorationThickness(parent),
      decoration: TextDecoration.combine([
        if (property.getUnderline(parent)) TextDecoration.underline,
        if (property.getLineThrough(parent)) TextDecoration.lineThrough,
        if (property.getOverline(parent)) TextDecoration.overline,
      ]),
    );
  }

  TextDecorationStyle getDecorationStyle(
      text.TextDecorationStyle decorationStyle) {
    switch (decorationStyle) {
      case text.TextDecorationStyle.solid:
        return TextDecorationStyle.solid;
      case text.TextDecorationStyle.double:
        return TextDecorationStyle.double;
      case text.TextDecorationStyle.dotted:
        return TextDecorationStyle.dotted;
      case text.TextDecorationStyle.dashed:
        return TextDecorationStyle.dashed;
      case text.TextDecorationStyle.wavy:
        return TextDecorationStyle.wavy;
    }
  }

  @override
  FutureOr<void> setup(NoteData document) async {
    _createPainter(document);
    _updateRect(document);
    await super.setup(page);
    _updateRect(document);
  }

  @override
  FutureOr<bool> onAreaUpdate(DocumentPage page, Area? area) async {
    if (context != null) {
      await super.onAreaUpdate(document, area);
    }
    _updateRect(document);
    return true;
  }

  void _updateRect(NoteData document) {
    _tp?.layout(maxWidth: element.getMaxWidth(area));
    rect = Rect.fromLTWH(element.position.x, element.position.y,
        _tp?.width ?? 0, element.getHeight(_tp?.height ?? 0));
  }

  @override
  FutureOr<void> build(
      Canvas canvas, Size size, DocumentPage page, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    _tp?.layout(maxWidth: rect.width);
    _tp?.paint(canvas, element.getOffset(rect.height).toOffset());
  }

  @override
  void buildSvg(XmlDocument xml, DocumentPage page, Rect viewportRect) {
    if (!rect.overlaps(rect)) return;
    // TODO: implement buildSvg
  }

  @override
  TextRenderer transform(
      {Offset position = Offset.zero,
      double scaleX = 1,
      double scaleY = 1,
      bool relative = false}) {
    // final size = Size(rect.width * scaleX, rect.height * scaleY);
    final next =
        relative ? element.position + position.toPoint() : position.toPoint();
    return TextRenderer(element.copyWith(position: next), context);
  }

  @override
  void dispose() {
    if (context == null) _tp?.dispose();
  }

  InlineSpan? get span => _tp?.text;
}
