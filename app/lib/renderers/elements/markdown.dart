part of '../renderer.dart';

class MarkdownRenderer extends Renderer<MarkdownElement> {
  @override
  Rect rect = Rect.zero;
  TextPainter? _tp;
  MarkdownContext? context;

  MarkdownRenderer(super.element, [this.context]);

  void _createPainter(NoteData document, DocumentPage page) {
    _tp ??= context?.textPainter ?? TextPainter();
    _tp?.text = _buildParagraph();
    _tp?.textDirection = TextDirection.ltr;
    _tp?.textScaleFactor = 1.0;
  }

  List<md.Node> _parse() => md.Document().parse(element.text);

  TextSpan _buildParagraph() => TextSpan(
        children: _parse().map(_createSpan).toList(),
      );

  TextSpan _createSpan(md.Node node) {
    return TextSpan(text: node.textContent);
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
  void dispose() {
    if (context == null) _tp?.dispose();
  }

  @override
  FutureOr<void> build(Canvas canvas, Size size, NoteData document,
      DocumentPage page, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    _tp?.layout(maxWidth: rect.width);
    _tp?.paint(canvas, element.getOffset(rect.height).toOffset());
  }
}
