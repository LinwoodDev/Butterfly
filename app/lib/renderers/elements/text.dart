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

  void _createPainter(AppDocument document) {
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
      AppDocument document, text.TextParagraph paragraph) {
    final styleSheet = document.getStyle(element.styleSheet);
    final style = styleSheet.resolveParagraphProperty(paragraph.property) ??
        const text.DefinedParagraphProperty();
    return paragraph.map(
      text: (p) => TextSpan(
        children: p.textSpans.map((e) => _createSpan(document, e)).toList(),
        style: _buildSpanStyle(style.span),
      ),
    );
  }

  text.TextStyleSheet? _getStyle(AppDocument document) =>
      document.getStyle(element.styleSheet);

  InlineSpan _createSpan(AppDocument document, text.TextSpan span) {
    final styleSheet = _getStyle(document);
    final style = styleSheet.resolveSpanProperty(span.property);
    return TextSpan(
      text: span.text,
      style: style == null ? null : _buildSpanStyle(style),
    );
  }

  TextStyle _buildSpanStyle(text.DefinedSpanProperty property) {
    return TextStyle(
      fontSize: property.size,
      color: Color(property.color),
      fontFamily: 'Roboto',
      fontStyle: property.italic ? FontStyle.italic : FontStyle.normal,
      fontWeight: FontWeight.values[property.fontWeight],
      letterSpacing: property.letterSpacing,
      decorationColor: Color(property.decorationColor),
      decorationStyle: property.decorationStyle,
      decorationThickness: property.decorationThickness,
      decoration: TextDecoration.combine([
        if (property.underline) TextDecoration.underline,
        if (property.lineThrough) TextDecoration.lineThrough,
        if (property.overline) TextDecoration.overline,
      ]),
    );
  }

  @override
  FutureOr<void> setup(AppDocument document) async {
    _createPainter(document);
    _updateRect(document);
    await super.setup(document);
    _updateRect(document);
  }

  @override
  FutureOr<bool> onAreaUpdate(AppDocument document, Area? area) async {
    await super.onAreaUpdate(document, area);
    _updateRect(document);
    return true;
  }

  void _updateRect(AppDocument document) {
    var maxWidth = double.infinity;
    final constraints = element.constraint;
    if (constraints.size > 0) maxWidth = constraints.size;
    if (constraints.includeArea && area != null) {
      maxWidth = min(maxWidth + element.position.dx, area!.rect.right) -
          element.position.dx;
    }
    _tp?.layout(maxWidth: maxWidth);
    var height = _tp?.height ?? 0;
    if (height < constraints.length) {
      height = constraints.length;
    } else if (constraints.includeArea && area != null) {
      height = max(height, area!.rect.bottom - element.position.dy);
    }
    rect = Rect.fromLTWH(
        element.position.dx, element.position.dy, _tp?.width ?? 0, height);
  }

  @override
  FutureOr<void> build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    _tp?.layout(maxWidth: rect.width);
    var current = element.position;
    // Change vertical alignment
    final align = element.area.areaProperty.alignment;
    switch (align) {
      case text.VerticalAlignment.top:
        current = current.translate(0, 0);
        break;
      case text.VerticalAlignment.bottom:
        current = current.translate(0, rect.height - (_tp?.height ?? 0));
        break;
      case text.VerticalAlignment.center:
        current = current.translate(0, (rect.height - (_tp?.height ?? 0)) / 2);
        break;
    }
    _tp?.paint(canvas, current);
  }

  @override
  void buildSvg(XmlDocument xml, AppDocument document, Rect viewportRect) {
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
    final next = relative ? element.position + position : position;
    return TextRenderer(element.copyWith(position: next), context);
  }

  @override
  void dispose() {
    if (context == null) _tp?.dispose();
  }

  InlineSpan? get span => _tp?.text;
}
