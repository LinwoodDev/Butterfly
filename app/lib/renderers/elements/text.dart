part of '../renderer.dart';

class TextRenderer extends Renderer<TextElement> {
  @override
  Rect rect;

  TextRenderer(super.element, [this.rect = Rect.zero]);

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

  TextPainter _createPainter(AppDocument document) {
    final paragraph = element.area.paragraph;
    final styleSheet = document.getStyle(element.styleSheet);
    final style =
        styleSheet?.resolveParagraphProperty(paragraph.textProperty) ??
            const text.DefinedParagraphProperty();
    return TextPainter(
      text: _createParagraphSpan(document, paragraph),
      textDirection: TextDirection.ltr,
      textScaleFactor: 1.0,
      textAlign: _convertAlignment(style.alignment),
    );
  }

  TextSpan _createParagraphSpan(
      AppDocument document, text.TextParagraph paragraph) {
    final styleSheet = document.getStyle(element.styleSheet);
    final style =
        styleSheet?.resolveParagraphProperty(paragraph.textProperty) ??
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
    final style = styleSheet?.resolveSpanProperty(span.property);
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
    final tp = _createPainter(document);
    tp.layout(maxWidth: maxWidth);
    var height = tp.height;
    if (height < constraints.length) {
      height = constraints.length;
    } else if (constraints.includeArea && area != null) {
      height = max(height, area!.rect.bottom - element.position.dy);
    }
    rect = Rect.fromLTWH(
        element.position.dx, element.position.dy, tp.width, height);
  }

  @override
  FutureOr<void> build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    final tp = _createPainter(document);
    tp.layout(maxWidth: rect.width);
    var current = element.position;
    // Change vertical alignment
    final align = element.area.areaProperty.alignment;
    switch (align) {
      case text.VerticalAlignment.top:
        current = current.translate(0, 0);
        break;
      case text.VerticalAlignment.bottom:
        current = current.translate(0, rect.height - tp.height);
        break;
      case text.VerticalAlignment.center:
        current = current.translate(0, (rect.height - tp.height) / 2);
        break;
    }
    tp.paint(canvas, current);
  }

  @override
  void buildSvg(XmlDocument xml, AppDocument document, Rect viewportRect) {
    if (!rect.overlaps(rect)) return;
    final style = _getStyle(document);
    final property =
        style?.resolveParagraphProperty(element.area.paragraph.textProperty) ??
            const text.DefinedParagraphProperty();
    final span = property.span;
    String textDecoration = '';
    if (span.underline) textDecoration += 'underline ';
    if (span.lineThrough) textDecoration += 'line-through ';
    if (span.overline) textDecoration += 'overline ';
    textDecoration +=
        '${span.decorationStyle.name} ${span.decorationThickness}px ${span.decorationColor.toHexColor()}';
    final foreignObject =
        xml.getElement('svg')?.createElement('foreignObject', attributes: {
      'x': '${rect.left}px',
      'y': '${rect.top}px',
      'width': '${rect.width}px',
      'height': '${min(rect.height, rect.bottom)}px',
    });
    String alignItems = 'center';
    switch (element.area.areaProperty.alignment) {
      case text.VerticalAlignment.top:
        alignItems = 'flex-start';
        break;
      case text.VerticalAlignment.bottom:
        alignItems = 'flex-end';
        break;
      case text.VerticalAlignment.center:
        alignItems = 'center';
        break;
    }
    String alignContent = 'center';
    switch (property.alignment) {
      case text.HorizontalAlignment.left:
        alignContent = 'flex-start';
        break;
      case text.HorizontalAlignment.right:
        alignContent = 'flex-end';
        break;
      case text.HorizontalAlignment.center:
        alignContent = 'center';
        break;
      case text.HorizontalAlignment.justify:
        alignContent = 'space-between';
        break;
    }
    final div = foreignObject?.createElement('div', attributes: {
      'style': 'font-size: ${span.size}px;'
          'font-style: ${span.italic ? 'italic' : 'normal'};'
          'font-weight: ${span.fontWeight};'
          'font-family: Roboto;'
          'letter-spacing: ${span.letterSpacing}px;'
          'color: #${span.color.toHexColor()};'
          'text-decoration: $textDecoration;'
          'display: flex;'
          'align-items: $alignItems;'
          'justify-content: $alignContent;'
          'height: ${rect.height}px;'
          'width: ${rect.width}px;',
      'xmlns': 'http://www.w3.org/1999/xhtml',
    });
    div?.innerText = element.text;
  }

  @override
  TextRenderer transform(
      {Offset position = Offset.zero,
      double scaleX = 1,
      double scaleY = 1,
      bool relative = false}) {
    final size = Size(rect.width * scaleX, rect.height * scaleY);
    final next = relative ? element.position + position : position;
    return TextRenderer(element.copyWith(position: next), next & size);
  }
}
