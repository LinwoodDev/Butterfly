part of '../renderer.dart';

const kParagraphTags = {
  'p',
  'h1',
  'h2',
  'h3',
  'h4',
  'h5',
  'h6',
  'blockquote',
  'br',
  'lio'
};

class MarkdownRenderer extends GenericTextRenderer<MarkdownElement> {
  @override
  final MarkdownContext? context;

  MarkdownRenderer(super.element, [super.layer, this.context]);

  List<md.Node> _parse() => md.Document(
        extensionSet: md.ExtensionSet.gitHubWeb,
        inlineSyntaxes: [
          md.LineBreakSyntax(),
        ],
        withDefaultBlockSyntaxes: true,
        withDefaultInlineSyntaxes: true,
        encodeHtml: true,
      ).parse(element.text);

  List<text.TextSpan> _convertToSpan(
      md.Node node, text.TextStyleSheet? styleSheet,
      [bool paragraph = false, text.SpanProperty? span]) {
    if (node is! md.Element) {
      return [
        text.TextSpan.text(
            text: node.textContent,
            property: span ?? const text.SpanProperty.undefined())
      ];
    }
    final tag = node.tag;
    paragraph = paragraph || kParagraphTags.contains(tag);
    final style = styleSheet?.getSpanProperty(tag) ??
        styleSheet?.getParagraphProperty(tag)?.span;
    return [
      ...(node.children
              ?.expand(
                (e) => _convertToSpan(e, styleSheet, false, style),
              )
              .toList() ??
          []),
      if (paragraph) const text.TextSpan.text(text: '\n'),
    ];
  }

  text.TextParagraph _convertToParagraph(
      Iterable<md.Node> node, text.TextStyleSheet? styleSheet) {
    final style = styleSheet?.getParagraphProperty('p');
    return text.TextParagraph(
      textSpans: context != null
          ? [
              text.TextSpan.text(
                text: element.text,
              ),
            ]
          : node
              .expandIndexed(
                (i, e) => _convertToSpan(e, styleSheet),
              )
              .toList(growable: false),
      property: style ?? const text.ParagraphProperty.undefined(),
    );
  }

  @override
  MarkdownRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) =>
      MarkdownRenderer(
          element.copyWith(
            position: position.toPoint(),
            rotation: rotation,
            scale: element.scale * max(scaleX, scaleY),
          ),
          layer,
          context);

  @override
  text.TextParagraph getParagraph(NoteData document) {
    final parsed = _parse();
    final styleSheet = element.styleSheet?.item;
    return _convertToParagraph(parsed, styleSheet);
  }
}
