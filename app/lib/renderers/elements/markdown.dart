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
  'lio',
};

@immutable
class MarkdownTableData {
  final List<List<String>> rows;
  final int headerRows;

  const MarkdownTableData(this.rows, this.headerRows);

  int get columns =>
      rows.fold<int>(0, (maximum, row) => max(maximum, row.length));
}

List<MarkdownTableData> parseMarkdownTables(String source) {
  final nodes = md.Document(
    extensionSet: md.ExtensionSet.gitHubWeb,
    inlineSyntaxes: [md.LineBreakSyntax(), MathInlineSyntax()],
    withDefaultBlockSyntaxes: true,
    withDefaultInlineSyntaxes: true,
    encodeHtml: true,
  ).parse(source);
  return nodes
      .whereType<md.Element>()
      .where((node) => node.tag == 'table')
      .map(_tableData)
      .where((table) => table.rows.isNotEmpty && table.columns > 0)
      .toList(growable: false);
}

MarkdownTableData _tableData(md.Element table) {
  final rows = <List<String>>[];
  var headerRows = 0;

  void visit(md.Node node, {bool header = false}) {
    if (node is! md.Element) return;
    final isHeader = header || node.tag == 'thead';
    if (node.tag == 'tr') {
      final cells = (node.children ?? const <md.Node>[])
          .whereType<md.Element>()
          .where((cell) => cell.tag == 'th' || cell.tag == 'td')
          .map((cell) => cell.textContent.trim())
          .toList(growable: false);
      if (cells.isNotEmpty) {
        rows.add(cells);
        if (isHeader ||
            node.children?.any(
                  (cell) => cell is md.Element && cell.tag == 'th',
                ) ==
                true) {
          headerRows++;
        }
      }
      return;
    }
    for (final child in node.children ?? const <md.Node>[]) {
      visit(child, header: isHeader);
    }
  }

  visit(table);
  return MarkdownTableData(rows, headerRows);
}

class _MarkdownTableLayout {
  final MarkdownTableData table;
  final int textOffset;

  const _MarkdownTableLayout(this.table, this.textOffset);
}

class MarkdownRenderer extends GenericTextRenderer<MarkdownElement> {
  @override
  final MarkdownContext? context;
  final List<_MarkdownTableLayout> _tables = [];

  MarkdownRenderer(super.element, [super.layer, this.context]);

  List<md.Node> _parse() => md.Document(
    extensionSet: md.ExtensionSet.gitHubWeb,
    inlineSyntaxes: [md.LineBreakSyntax(), MathInlineSyntax()],
    withDefaultBlockSyntaxes: true,
    withDefaultInlineSyntaxes: true,
    encodeHtml: true,
  ).parse(element.text);

  List<text.InlineSpan> _convertToSpan(
    md.Node node,
    text.TextStyleSheet? styleSheet, [
    bool paragraph = false,
    text.SpanProperty? span,
  ]) {
    if (node is! md.Element) {
      return [
        text.InlineSpan.text(
          text: node.textContent,
          property: span ?? const text.SpanProperty.undefined(),
        ),
      ];
    }
    final tag = node.tag;
    paragraph = paragraph || kParagraphTags.contains(tag);
    final style =
        styleSheet?.getSpanProperty(tag) ??
        styleSheet?.getParagraphProperty(tag)?.span;
    List<text.InlineSpan> children = switch (tag) {
      'math' => [
        text.MathTextSpan(
          text: node.textContent,
          property: style ?? const text.SpanProperty.undefined(),
        ),
      ],
      _ =>
        (node.children
                ?.expand((e) => _convertToSpan(e, styleSheet, false, style))
                .toList() ??
            []),
    };
    return [...children, if (paragraph) const text.InlineSpan.text(text: '\n')];
  }

  text.TextParagraph _convertToParagraph(
    Iterable<md.Node> node,
    text.TextStyleSheet? styleSheet,
  ) {
    final style = styleSheet?.getParagraphProperty('p');
    _tables.clear();
    final spans = <text.InlineSpan>[];
    var textOffset = 0;
    for (final child in node) {
      final converted =
          context == null && child is md.Element && child.tag == 'table'
          ? _convertTable(child, textOffset)
          : _convertToSpan(child, styleSheet);
      spans.addAll(converted);
      textOffset += converted.fold<int>(0, (sum, span) => sum + span.length);
    }
    return text.TextParagraph(
      textSpans: context != null
          ? [text.InlineSpan.text(text: element.text)]
          : spans,
      property: style ?? const text.ParagraphProperty.undefined(),
    );
  }

  List<text.InlineSpan> _convertTable(md.Element node, int textOffset) {
    final table = _tableData(node);
    if (table.rows.isEmpty || table.columns == 0) return const [];
    _tables.add(_MarkdownTableLayout(table, textOffset));
    return [
      text.InlineSpan.text(
        text: List.filled(table.rows.length, '\u00a0\n').join(),
        property: const text.DefinedSpanProperty(size: 24),
      ),
    ];
  }

  double _tableWidth(MarkdownTableData table) {
    final preferredWidth = table.columns * 120 * scale;
    final maximumWidth = element.getMaxWidth(area);
    return maximumWidth.isFinite
        ? min(preferredWidth, maximumWidth)
        : preferredWidth;
  }

  void _updateTableRectWidth() {
    if (_tables.isEmpty) return;
    final tableWidth = _tables.fold<double>(
      rect.width,
      (width, layout) => max(width, _tableWidth(layout.table)),
    );
    rect = Rect.fromLTWH(rect.left, rect.top, tableWidth, rect.height);
  }

  @override
  Future<void> setup(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    await super.setup(transformCubit, document, assetService, page);
    _updateTableRectWidth();
  }

  @override
  bool onAreaUpdate(NoteData document, DocumentPage page, Area? area) {
    final updated = super.onAreaUpdate(document, page, area);
    _updateTableRectWidth();
    return updated;
  }

  List<({MarkdownTableData table, Rect rect})> _tableRects() {
    final painter = _tp;
    if (painter == null) return const [];
    final result = <({MarkdownTableData table, Rect rect})>[];
    final paintOffset = element.getOffset(rect.height).toOffset();
    for (final layout in _tables) {
      final boxes = <TextBox>[];
      for (var row = 0; row < layout.table.rows.length; row++) {
        final offset = layout.textOffset + row * 2;
        boxes.addAll(
          painter.getBoxesForSelection(
            TextSelection(baseOffset: offset, extentOffset: offset + 1),
          ),
        );
      }
      if (boxes.isEmpty) continue;
      result.add((
        table: layout.table,
        rect: Rect.fromLTRB(
          paintOffset.dx,
          paintOffset.dy + boxes.first.top,
          paintOffset.dx + rect.width,
          paintOffset.dy + boxes.last.bottom,
        ),
      ));
    }
    return result;
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
    _updateTableRectWidth();
    super.build(
      canvas,
      size,
      document,
      page,
      info,
      transform,
      colorScheme,
      foreground,
    );
    if (context != null) return;
    for (final layout in _tableRects()) {
      final tableElement = TableElement(
        firstPosition: layout.rect.topLeft.toPoint(),
        secondPosition: layout.rect.bottomRight.toPoint(),
        rows: layout.table.rows.length,
        columns: layout.table.columns,
        border: TableBorderProperty(width: scale, color: element.foreground),
      );
      final renderer = TableRenderer(tableElement);
      renderer.build(
        canvas,
        size,
        document,
        page,
        info,
        transform,
        colorScheme,
        foreground,
      );
      _paintTableText(canvas, renderer, layout.table);
    }
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) {
    _updateTableRectWidth();
    super.buildSvg(xml, document, page, viewportRect);
    if (context != null) return;
    final svg = xml.getElement('svg');
    if (svg == null) return;
    for (final layout in _tableRects()) {
      final tableElement = TableElement(
        firstPosition: layout.rect.topLeft.toPoint(),
        secondPosition: layout.rect.bottomRight.toPoint(),
        rows: layout.table.rows.length,
        columns: layout.table.columns,
        border: TableBorderProperty(width: scale, color: element.foreground),
      );
      final renderer = TableRenderer(tableElement);
      renderer.buildSvg(xml, document, page, viewportRect);
      for (var row = 0; row < layout.table.rows.length; row++) {
        for (var column = 0; column < layout.table.rows[row].length; column++) {
          final bounds = renderer.cellRect(row, column).deflate(4 * scale);
          svg
                  .createElement(
                    'text',
                    attributes: {
                      'x': '${bounds.left}',
                      'y': '${bounds.center.dy}',
                      'fill': element.foreground.toHexString(alpha: false),
                      'fill-opacity': '${element.foreground.a / 255}',
                      'font-size': '${12 * scale}',
                      'font-weight': row < layout.table.headerRows
                          ? 'bold'
                          : 'normal',
                      'dominant-baseline': 'middle',
                    },
                  )
                  .innerText =
              layout.table.rows[row][column];
        }
      }
    }
  }

  void _paintTableText(
    Canvas canvas,
    TableRenderer renderer,
    MarkdownTableData table,
  ) {
    for (var row = 0; row < table.rows.length; row++) {
      for (var column = 0; column < table.rows[row].length; column++) {
        final bounds = renderer.cellRect(row, column).deflate(4 * scale);
        if (bounds.isEmpty) continue;
        final painter = TextPainter(
          text: TextSpan(
            text: table.rows[row][column],
            style: TextStyle(
              color: element.foreground.toColor(),
              fontSize: 12 * scale,
              fontWeight: row < table.headerRows
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          textDirection: TextDirection.ltr,
          maxLines: 1,
          ellipsis: '…',
        )..layout(maxWidth: bounds.width);
        canvas.save();
        canvas.clipRect(bounds);
        painter.paint(
          canvas,
          Offset(bounds.left, bounds.center.dy - painter.height / 2),
        );
        canvas.restore();
        painter.dispose();
      }
    }
  }

  @override
  MarkdownRenderer _transform({
    required Offset position,
    required double rotation,
    required double shear,
    double scaleX = 1,
    double scaleY = 1,
  }) => MarkdownRenderer(
    element.copyWith(
      position: position.toPoint(),
      rotation: rotation,
      shear: shear,
      scale: element.scale * max(scaleX, scaleY),
    ),
    layer,
    context,
  );

  @override
  text.TextParagraph getParagraph(NoteData document) {
    final parsed = _parse();
    final styleSheet = element.styleSheet?.item;
    return _convertToParagraph(parsed, styleSheet);
  }
}
