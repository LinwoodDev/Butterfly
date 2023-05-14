part of '../renderer.dart';

class TextRenderer extends Renderer<TextElement> {
  @override
  Rect rect = Rect.zero;
  TextPainter? _tp;
  TextContext? context;

  TextRenderer(super.element, [this.context]);

  void _createPainter(NoteData document, DocumentPage page) {
    final paragraph = element.area.paragraph;
    final style =
        _getStyle(document).resolveParagraphProperty(paragraph.property) ??
            const text.DefinedParagraphProperty();
    _tp ??= context?.textPainter ?? TextPainter();
    _tp?.text = _createParagraphSpan(document, paragraph);
    _tp?.textDirection = TextDirection.ltr;
    _tp?.textScaleFactor = 1.0;
    _tp?.textAlign = style.alignment.toFlutter();
  }

  TextSpan _createParagraphSpan(
      NoteData document, text.TextParagraph paragraph) {
    final styleSheet = element.styleSheet.resolveStyle(document);
    final style = styleSheet.resolveParagraphProperty(paragraph.property) ??
        const text.DefinedParagraphProperty();
    return paragraph.map(
      text: (p) => TextSpan(
        children:
            p.textSpans.map((e) => _createSpan(document, e, style)).toList(),
        style: style.span.toFlutter(element.scale, null, element.foreground),
      ),
    );
  }

  text.TextStyleSheet? _getStyle(NoteData document) =>
      element.styleSheet.resolveStyle(document);

  InlineSpan _createSpan(NoteData document, text.TextSpan span,
      [text.DefinedParagraphProperty? parent]) {
    final styleSheet = _getStyle(document);
    final style = styleSheet.resolveSpanProperty(span.property);
    return TextSpan(
      text: span.text,
      style: style?.toFlutter(element.scale, parent, element.foreground),
    );
  }

  @override
  FutureOr<void> setup(NoteData document, DocumentPage page) async {
    _createPainter(document, page);
    _updateRect();
    await super.setup(document, page);
    _updateRect();
  }

  @override
  FutureOr<bool> onAreaUpdate(DocumentPage page, Area? area) async {
    if (context != null) {
      await super.onAreaUpdate(page, area);
    }
    _updateRect();
    return true;
  }

  void _updateRect() {
    _tp?.layout(maxWidth: element.getMaxWidth(area));
    rect = Rect.fromLTWH(element.position.x, element.position.y,
        _tp?.width ?? 0, element.getHeight(_tp?.height ?? 0));
  }

  @override
  FutureOr<void> build(Canvas canvas, Size size, NoteData document,
      DocumentPage page, CameraTransform transform,
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
