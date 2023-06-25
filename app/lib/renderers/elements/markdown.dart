part of '../renderer.dart';

class MarkdownRenderer extends Renderer<MarkdownElement> {
  @override
  Rect rect = Rect.zero;
  TextPainter? _tp;
  MarkdownContext? context;

  MarkdownRenderer(super.element, [this.context]);

  void _createPainter(NoteData document, DocumentPage page) {
    _tp ??= context?.textPainter ?? TextPainter();
    _tp?.text = _buildParagraph(document);
    _tp?.textDirection = TextDirection.ltr;
    _tp?.textScaleFactor = element.scale;
  }

  List<md.Node> _parse() => md.Document(
        extensionSet: md.ExtensionSet.gitHubWeb,
        inlineSyntaxes: [
          md.LineBreakSyntax(),
        ],
        withDefaultBlockSyntaxes: true,
        withDefaultInlineSyntaxes: true,
        encodeHtml: true,
      ).parse(element.text);

  TextSpan _buildParagraph(NoteData document) {
    final styleSheet = element.styleSheet.resolveStyle(document);

    return TextSpan(
      children: context == null
          ? _parse()
              .mapIndexed((i, e) => _createSpan(e, styleSheet, i != 0))
              .toList()
          : null,
      text: context == null ? null : element.text,
      style: TextStyle(color: Color(element.foreground)),
    );
  }

  TextSpan _createSpan(final md.Node node, text.TextStyleSheet? styleSheet,
      [bool root = false]) {
    if (node is md.Element) {
      final tag = node.tag;
      final paragraphStyle = styleSheet?.getParagraphProperty(tag);
      final spanStyle = styleSheet?.getSpanProperty(tag);
      TextStyle? style;
      if (paragraphStyle != null) {
        style = paragraphStyle.span.toFlutter(null, element.foreground);
      } else {
        style = spanStyle?.toFlutter(null, element.foreground);
      }
      return TextSpan(
        style: style,
        text: root ? '\n' : null,
        children:
            node.children?.map((e) => _createSpan(e, styleSheet)).toList(),
      );
    }
    return TextSpan(text: node.textContent);
  }

  @override
  FutureOr<void> setup(
      NoteData document, AssetService assetService, DocumentPage page) async {
    _createPainter(document, page);
    _updateRect();
    await super.setup(document, assetService, page);
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
  void dispose() {
    if (context == null) _tp?.dispose();
  }

  @override
  FutureOr<void> build(Canvas canvas, Size size, NoteData document,
      DocumentPage page, DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    _tp?.layout(maxWidth: rect.width);
    _tp?.paint(canvas, element.getOffset(rect.height).toOffset());
  }
}
