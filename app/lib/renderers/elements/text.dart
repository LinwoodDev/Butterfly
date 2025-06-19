part of '../renderer.dart';

abstract class GenericTextRenderer<T extends LabelElement> extends Renderer<T> {
  @override
  Rect rect;
  TextPainter? _tp;
  LabelContext? get context;

  GenericTextRenderer(super.element, [super.layer])
    : rect = Rect.fromCenter(
        center: element.position.toOffset(),
        width: 0,
        height: 0,
      );

  double get scale => element.scale;

  text.TextParagraph getParagraph(NoteData document);

  void _createTool(NoteData document, DocumentPage page) {
    _tp ??= context?.textPainter ?? TextPainter();
    _tp?.textDirection = TextDirection.ltr;
    _tp?.textScaler = TextScaler.linear(scale);
    final paragraph = getParagraph(document);
    final styleSheet = _getStyle();
    final style =
        styleSheet.resolveParagraphProperty(paragraph.property) ??
        const text.DefinedParagraphProperty();
    final dimensions = <PlaceholderDimensions>[];
    _tp?.text = switch (paragraph) {
      text.TextParagraph p => TextSpan(
        children: p.textSpans
            .map((e) => _createSpan(document, dimensions, e, style))
            .toList(),
        style: style.span.toFlutter(null, element.foreground),
      ),
    };
    _tp?.setPlaceholderDimensions(dimensions);
    _tp?.textAlign = style.alignment.toFlutter();
    _tp?.layout(maxWidth: element.getMaxWidth(area));
  }

  text.TextStyleSheet? _getStyle() => element.styleSheet?.item;

  InlineSpan _createSpan(
    NoteData document,
    List<PlaceholderDimensions> dimensions,
    text.InlineSpan span, [
    text.DefinedParagraphProperty? parent,
  ]) {
    final styleSheet = _getStyle();
    final style = styleSheet
        .resolveSpanProperty(span.property)
        ?.toFlutter(parent, element.foreground);
    switch (span) {
      case text.TextSpan():
        return TextSpan(text: span.text, style: style);
      case text.LatexTextSpan():
        final widget = Math.tex(
          span.text,
          textStyle: style,
          mathStyle: MathStyle.text,
        );
        dimensions.add(
          PlaceholderDimensions(
            size: Size(120, 50),
            alignment: PlaceholderAlignment.middle,
          ),
        );
        return WidgetSpan(child: widget, style: style);
    }
  }

  @override
  FutureOr<void> setup(
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    _createTool(document, page);
    await super.setup(document, assetService, page);
    _updateRect(document);
  }

  @override
  bool onAreaUpdate(NoteData document, DocumentPage page, Area? area) {
    super.onAreaUpdate(document, page, area);
    _updateRect(document);
    return true;
  }

  void _updateRect(NoteData document) {
    _tp?.layout(maxWidth: element.getMaxWidth(area));
    rect = Rect.fromLTWH(
      element.position.x,
      element.position.y,
      _tp?.width ?? 0,
      element.getHeight(_tp?.height ?? 0),
    );
  }

  @override
  FutureOr<void> build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    if (_tp?.plainText.isNotEmpty ?? false) {
      _tp?.layout(maxWidth: rect.width);
      _tp?.paint(canvas, element.getOffset(rect.height).toOffset());
    }
  }

  String _convertTextToHtml(String inputText) {
    // Escape HTML tags
    inputText = inputText.replaceAll('&', '&amp;');
    inputText = inputText.replaceAll('<', '&lt;');
    inputText = inputText.replaceAll('>', '&gt;');
    inputText = inputText.replaceAll('"', '&quot;');
    inputText = inputText.replaceAll("'", '&#x27;');
    // Replace newline characters with <br> tags
    inputText = inputText.replaceAll('\n', '<br>');

    return inputText;
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) {
    final svg = xml.getElement('svg');
    if (!rect.overlaps(rect) || svg == null) return;
    final paragraph = getParagraph(document);

    _tp?.layout(maxWidth: rect.width);
    final styles = element.styleSheet?.item;
    final textElement = svg.createElement(
      'text',
      attributes: {
        'x': '${rect.left}px',
        'y': '${rect.top}px',
        'width': '${rect.width}px',
        'height': '${rect.height}px',
      },
    );
    final paragraphStyle = styles.resolveParagraphProperty(paragraph.property);
    textElement.setAttribute('text-anchor', paragraphStyle?.alignment.name);
    // Add spans as html elements
    for (final span in paragraph.textSpans) {
      final style = styles.resolveSpanProperty(span.property);
      textElement.createElement('tspan')
        ..setAttribute('style', style?.toCss())
        ..innerText = _convertTextToHtml(span.text);
    }
  }

  @override
  void dispose() {
    if (context == null) _tp?.dispose();
  }

  InlineSpan? get span => _tp?.text;
}

class TextRenderer extends GenericTextRenderer<TextElement> {
  @override
  final TextContext? context;

  TextRenderer(super.element, [super.layer, this.context]);

  @override
  TextRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) => TextRenderer(
    element.copyWith(
      position: position.toPoint(),
      rotation: rotation,
      scale: element.scale * max(scaleX, scaleY),
    ),
    layer,
    context,
  );

  @override
  void dispose() {
    if (context == null) _tp?.dispose();
  }

  @override
  InlineSpan? get span => _tp?.text;

  @override
  text.TextParagraph getParagraph(NoteData document) => element.area.paragraph;
}
