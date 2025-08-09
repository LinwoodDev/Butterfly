import 'package:markdown/markdown.dart';

/// Syntax for inline LaTeX expressions in Markdown.
/// Can be used to render LaTeX expressions.
/// Use `$...$` for inline LaTeX.
class MathInlineSyntax extends InlineSyntax {
  static const _pattern = r'(\$)(?!\$)((?:.|\n)*?[^$])\1(?!\$)';

  MathInlineSyntax() : super(_pattern);

  @override
  bool onMatch(InlineParser parser, Match match) {
    final text = match[2] ?? '';
    if (text.isEmpty) return false;

    // Create a new node for the LaTeX expression
    final latexNode = Element('math', [Text(text)]);

    // Add the LaTeX node to the parser's current node
    parser.addNode(latexNode);

    // Return true to indicate that the match was handled
    return true;
  }
}
