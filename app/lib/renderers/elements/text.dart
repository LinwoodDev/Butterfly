part of '../renderer.dart';

abstract class GenericTextRenderer<T extends LabelElement> extends Renderer<T> {
  @override
  Rect rect;
  TextPainter? _tp;
  LabelContext? get context;
  final Map<int, (ui.Image, double)> _renderedLatex = {};

  GenericTextRenderer(super.element, [super.layer])
    : rect = Rect.fromCenter(
        center: element.position.toOffset(),
        width: 0,
        height: 0,
      );

  double get scale => element.scale;

  text.TextParagraph getParagraph(NoteData document);

  void _createTool(
    text.TextParagraph paragraph,
    NoteData document,
    DocumentPage page,
  ) {
    _tp ??= context?.textPainter ?? TextPainter();
    _tp?.textDirection = TextDirection.ltr;
    _tp?.textScaler = TextScaler.linear(scale);
    final styleSheet = _getStyle();
    final style =
        styleSheet.resolveParagraphProperty(paragraph.property) ??
        const text.DefinedParagraphProperty();
    final dimensions = <PlaceholderDimensions>[];
    _tp?.text = switch (paragraph) {
      text.TextParagraph p => TextSpan(
        children: p.textSpans
            .mapIndexed(
              (i, e) => _createSpan(document, dimensions, i, e, style),
            )
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
    int index,
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
      case text.MathTextSpan():
        final (element, scale) = _renderedLatex[index] ?? (null, 1.0);
        final size =
            Size(
              element?.width.toDouble() ?? 0,
              element?.height.toDouble() ?? 0,
            ) /
            scale;
        dimensions.add(
          PlaceholderDimensions(
            size: size,
            alignment: PlaceholderAlignment.middle,
            baseline: TextBaseline.alphabetic,
          ),
        );
        return WidgetSpan(
          child: RawImage(image: element),
          style: style,
          alignment: PlaceholderAlignment.middle,
          baseline: TextBaseline.alphabetic,
        );
    }
  }

  @override
  Future<void> setup(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    final paragraph = getParagraph(document);
    await super.setup(transformCubit, document, assetService, page);
    _createTool(paragraph, document, page);
    _updateRect(document);
  }

  @override
  Future<void> updateView(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    _renderedLatex.clear();
    final paragraph = getParagraph(document);
    await _renderLatex(paragraph, transformCubit.state);
  }

  @override
  bool onAreaUpdate(NoteData document, DocumentPage page, Area? area) {
    super.onAreaUpdate(document, page, area);
    _tp?.layout(maxWidth: element.getMaxWidth(area));
    _updateRect(document);
    return true;
  }

  void _updateRect(NoteData document) {
    rect = Rect.fromLTWH(
      element.position.x,
      element.position.y,
      _tp?.width ?? 0,
      element.getHeight(_tp?.height ?? 0),
    );
  }

  Widget _buildLatexElement(
    text.TextStyleSheet? styleSheet,
    text.DefinedParagraphProperty paragraphStyle,
    text.MathTextSpan span,
  ) => Padding(
    padding: const EdgeInsets.all(1),
    child: Math.tex(
      span.text,
      textStyle:
          (styleSheet.resolveSpanProperty(span.property) ??
                  const text.DefinedSpanProperty())
              .toFlutter(paragraphStyle, element.foreground),
    ),
  );

  Future<void> _renderLatex(
    text.TextParagraph paragraph,
    CameraTransform transform,
  ) async {
    final styleSheet = _getStyle();
    final paragraphStyle =
        styleSheet.resolveParagraphProperty(paragraph.property) ??
        const text.DefinedParagraphProperty();
    for (int i = 0; i < paragraph.textSpans.length; i++) {
      final span = paragraph.textSpans[i];
      if (span is text.MathTextSpan && !_renderedLatex.containsKey(i)) {
        final widget = _buildLatexElement(styleSheet, paragraphStyle, span);
        final pixelRatio = transform.pixelRatio * transform.size;
        final image = await renderWidget(
          widget,
          pixelRatio: scale * pixelRatio,
        );
        _renderedLatex[i] = (image, pixelRatio);
      }
    }
  }

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    final tp = _tp;
    if (tp == null || tp.text == null) return;
    tp.layout(maxWidth: rect.width);
    tp.paint(canvas, element.getOffset(rect.height).toOffset());
    final placeholders = tp.inlinePlaceholderBoxes ?? [];
    final orderedRendered = _renderedLatex.entries
        .sorted((a, b) => a.key.compareTo(b.key))
        .map((e) => e.value)
        .toList();
    for (int i = 0; i < placeholders.length; i++) {
      if (i >= orderedRendered.length) continue;
      final placeholder = placeholders[i];
      final (image, _) = orderedRendered[i];
      final rect = placeholder.toRect().shift(element.position.toOffset());
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        rect,
        Paint(),
      );
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
    if (!rect.overlaps(viewportRect) || svg == null) return;
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
  Future<void> onVisible(
    CurrentIndexCubit currentIndexCubit,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) async {
    final paragraph = getParagraph(blocState.data);
    final document = blocState.data;
    final page = blocState.page;
    await _renderLatex(paragraph, renderTransform);
    _createTool(paragraph, document, page);
    _updateRect(document);
  }

  @override
  void onHidden(
    CurrentIndexCubit currentIndexCubit,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    ui.Size size,
  ) {
    for (final (image, _) in _renderedLatex.values) {
      image.dispose();
    }
  }

  @override
  void dispose() {
    if (context == null) _tp?.dispose();
    for (final (image, _) in _renderedLatex.values) {
      image.dispose();
    }
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
