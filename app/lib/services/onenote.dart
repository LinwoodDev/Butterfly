import 'dart:math';
import 'dart:typed_data';

import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:material_leap/material_leap.dart';
import 'package:onenote_parser/onenote_parser.dart' as one;

Future<void>? _oneNoteInitialization;

const _pixelsPerInch = 96.0;
const _pixelsPerHalfInch = _pixelsPerInch / 2;
const _himetricUnitsPerInch = 2540.0;
const _himetricToPixels = _pixelsPerInch / _himetricUnitsPerInch;

Future<NoteData> parseOneNoteData(
  Uint8List bytes, {
  required String name,
  required bool isPackage,
}) async {
  await (_oneNoteInitialization ??= one.RustLib.init());
  if (isPackage) {
    final notebook = await one.parsePackageBytes(data: bytes);
    return convertOneNoteNotebook(notebook, name: name);
  }
  final section = await one.parseSectionBytes(
    data: bytes,
    fileName: '$name.one',
  );
  return convertOneNoteSection(section, name: name);
}

NoteData convertOneNoteSection(one.OneNoteSection section, {String? name}) {
  final converter = _OneNoteConverter(name ?? section.displayName);
  converter.addSection(section, const []);
  return converter.finish();
}

NoteData convertOneNoteNotebook(
  one.OneNoteNotebook notebook, {
  required String name,
}) {
  final converter = _OneNoteConverter(name);
  converter.addEntries(notebook.entries, const []);
  return converter.finish(
    warnings: notebook.warnings.map((warning) => warning.message).toList(),
  );
}

class _OneNoteConverter {
  NoteData _document;
  final String name;

  _OneNoteConverter(this.name)
    : _document = DocumentDefaults.createDocument(
        name: name,
        createDefaultPage: false,
      );

  void addEntries(List<one.OneNoteSectionEntry> entries, List<String> path) {
    for (final entry in entries) {
      entry.when(
        section: (section) => addSection(section, path),
        sectionGroup: (group) =>
            addEntries(group.entries, [...path, group.displayName]),
      );
    }
  }

  void addSection(one.OneNoteSection section, List<String> path) {
    final sectionPath = [
      ...path,
      section.displayName,
    ].where((part) => part.trim().isNotEmpty).toList();
    for (final series in section.pageSeries) {
      for (final page in series.pages) {
        final builder = _OneNotePageBuilder(_document);
        final converted = builder.convert(page);
        _document = builder.document;
        final title = page.title?.trim();
        final pageName = [
          ...sectionPath,
          if (title != null && title.isNotEmpty) title else 'Untitled page',
        ].join('/');
        final result = _document.addPage(
          converted.copyWith(
            extra: {
              ...converted.extra,
              'onenote:section': section.displayName,
              'onenote:sectionPath': sectionPath,
              'onenote:pageId': page.linkTargetId,
              'onenote:pageLevel': page.level,
              'onenote:author': ?page.author,
              'onenote:createdAt': page.createdAt,
              'onenote:updatedAt': page.updatedAt,
              'onenote:recognizedText': ?page.recognizedText,
              'onenote:warnings': section.warnings
                  .where(
                    (warning) =>
                        warning.pageId == null ||
                        warning.pageId == page.linkTargetId,
                  )
                  .map((warning) => warning.message)
                  .toList(),
            },
          ),
          pageName,
          addNumber: false,
        );
        _document = result.$1;
      }
    }
  }

  NoteData finish({List<String> warnings = const []}) {
    final info = _document.getInfo() ?? const DocumentInfo();
    _document = _document.setInfo(
      info.copyWith(
        extra: {
          ...info.extra,
          'onenote:imported': true,
          'onenote:warnings': warnings,
        },
      ),
    );
    return _document;
  }
}

class _OneNotePageBuilder {
  NoteData document;
  final List<PadElement> _elements = [];
  final List<Background> _backgrounds = [];

  _OneNotePageBuilder(this.document);

  DocumentPage convert(one.OneNotePage page) {
    for (final content in page.contents) {
      content.when(
        outline: _addOutline,
        image: (image) => _addImage(image, const Point(0, 0)),
        embeddedFile: (file) => _addEmbeddedFile(file, const Point(0, 0)),
        ink: (ink) => _addInk(ink, const Point(0, 0), embedded: false),
        unknown: () {},
      );
    }
    return DocumentPage(
      layers: [
        DocumentLayer(
          name: 'OneNote',
          content: _elements,
          id: createUniqueId(),
        ),
      ],
      backgrounds: _backgrounds.isEmpty
          ? DocumentDefaults.createPage().backgrounds
          : _backgrounds,
    );
  }

  void _addOutline(one.OneNoteOutline outline) {
    final outlineWidth = (outline.layoutMaxWidth ?? 13) * _pixelsPerHalfInch;
    final origin = Point<double>(
      (outline.offsetHorizontal ?? 0) * _pixelsPerHalfInch,
      (outline.offsetVertical ?? 0) * _pixelsPerHalfInch,
    );
    var y = origin.y;
    for (final item in outline.items) {
      y = _addOutlineItem(
        item,
        Point(origin.x, y),
        outlineWidth,
        outline.indents,
        0,
        outline.childLevel,
      );
    }
  }

  double _addOutlineItem(
    one.OneNoteOutlineItem item,
    Point<double> position,
    double outlineWidth,
    Float32List indents,
    int parentLevel,
    int currentLevel,
  ) {
    return item.when(
      group: (group) {
        var y = position.y;
        for (final child in group.items) {
          y = _addOutlineItem(
            child,
            Point(position.x, y),
            outlineWidth,
            indents,
            parentLevel,
            currentLevel + group.childLevel,
          );
        }
        return y;
      },
      element: (element) {
        final indent = _outlineIndent(indents, parentLevel, currentLevel);
        var y = position.y;
        final x = position.x + indent;
        final availableWidth = max(1.0, outlineWidth - indent);
        for (final content in element.contents) {
          y += _addContent(content, Point(x, y), availableWidth);
        }
        for (final child in element.children) {
          y = _addOutlineItem(
            child,
            Point(position.x, y),
            outlineWidth,
            indents,
            currentLevel,
            currentLevel + element.childLevel,
          );
        }
        return y;
      },
    );
  }

  double _addContent(
    one.OneNoteContent content,
    Point<double> position,
    double availableWidth,
  ) {
    return content.when(
      richText: (value) => _addRichText(value, position, availableWidth),
      table: (value) => _addTable(value, position, availableWidth),
      image: (value) => _addImage(value, position),
      embeddedFile: (value) => _addEmbeddedFile(value, position),
      ink: (value) => _addInk(value, position, embedded: true),
      unknown: () => 0,
    );
  }

  double _addRichText(
    one.OneNoteRichText value,
    Point<double> position,
    double availableWidth,
  ) {
    final spaceBefore = value.paragraphSpaceBefore * _pixelsPerHalfInch;
    final spaceAfter = value.paragraphSpaceAfter * _pixelsPerHalfInch;
    if (value.text.isEmpty) {
      return spaceBefore + spaceAfter;
    }
    final spans = _createSpans(value);
    final paragraphStyle = value.paragraphStyle;
    final fontSize = _fontSize(
      value.textRunStyles.isEmpty
          ? paragraphStyle
          : value.textRunStyles.reduce(
              (current, style) =>
                  _fontSize(style) > _fontSize(current) ? style : current,
            ),
    );
    final explicitLines = '\n'.allMatches(value.text).length + 1;
    final estimatedLineWidth = max(fontSize * 0.55, 1);
    final wrappedLines =
        (value.text.length * estimatedLineWidth / availableWidth).ceil();
    final lineCount = max(explicitLines, wrappedLines);
    final height =
        spaceBefore + spaceAfter + lineCount * max(fontSize * 1.2, 1);
    _elements.add(
      TextElement(
        position: Point(position.x, position.y + spaceBefore),
        area: text.TextArea(
          paragraph: text.TextParagraph(
            property: text.ParagraphProperty.defined(
              alignment: _alignment(value.paragraphAlignment),
              span: _spanProperty(paragraphStyle),
            ),
            textSpans: spans,
          ),
        ),
        constraint: ElementConstraint(
          size: availableWidth,
          length: max(1, height - spaceBefore - spaceAfter),
          includeArea: false,
        ),
        extra: {
          'onenote:paragraphSpaceBefore': spaceBefore,
          'onenote:paragraphSpaceAfter': spaceAfter,
          'onenote:font': ?paragraphStyle.font,
        },
      ),
    );
    return max(height, 16);
  }

  List<text.InlineSpan> _createSpans(one.OneNoteRichText value) {
    final indices = value.textRunIndices.map((index) => index.toInt()).toList();
    final styles = value.textRunStyles;
    if (indices.isEmpty || styles.isEmpty) {
      return [_inlineSpan(value.text, value.paragraphStyle)];
    }

    final spans = <text.InlineSpan>[];
    var cursor = 0;
    for (var i = 0; i < min(indices.length, styles.length); i++) {
      final start = indices[i].clamp(cursor, value.text.length);
      if (start > cursor) {
        spans.add(
          _inlineSpan(
            value.text.substring(cursor, start),
            value.paragraphStyle,
          ),
        );
      }
      final end = i + 1 < indices.length
          ? indices[i + 1].clamp(start, value.text.length)
          : value.text.length;
      if (end > start) {
        spans.add(_inlineSpan(value.text.substring(start, end), styles[i]));
      }
      cursor = end;
    }
    if (cursor < value.text.length) {
      spans.add(
        _inlineSpan(value.text.substring(cursor), value.paragraphStyle),
      );
    }
    return spans;
  }

  text.InlineSpan _inlineSpan(String value, one.OneNoteTextStyle style) {
    final property = _spanProperty(style);
    if (style.mathFormatting) {
      return text.InlineSpan.math(text: value, property: property);
    }
    return text.InlineSpan.text(text: value, property: property);
  }

  text.DefinedSpanProperty _spanProperty(one.OneNoteTextStyle style) =>
      text.DefinedSpanProperty(
        size: _fontSize(style),
        fontWeight: style.bold ? text.kFontWeightBold : text.kFontWeightNormal,
        italic: style.italic,
        underline: style.underline,
        lineThrough: style.strikethrough,
      );

  double _addTable(
    one.OneNoteTable table,
    Point<double> position,
    double availableWidth,
  ) {
    final rows = table.rows
        .map(
          (row) => row.cells
              .map(
                (cell) =>
                    cell.contents.map(_outlineElementText).join(' ').trim(),
              )
              .join('\t'),
        )
        .join('\n');
    if (rows.isEmpty) return 0;
    final height = max(24.0, table.rowCount * 24.0);
    final tableWidth = table.columnWidths.isEmpty
        ? availableWidth
        : min(
            availableWidth,
            table.columnWidths.fold<double>(0, (sum, width) => sum + width) *
                _pixelsPerHalfInch,
          );
    _elements.add(
      TextElement(
        position: position,
        area: text.TextArea(
          paragraph: text.TextParagraph(
            textSpans: [text.InlineSpan.text(text: rows)],
          ),
        ),
        constraint: ElementConstraint(
          size: tableWidth,
          length: height,
          includeArea: false,
        ),
        extra: {
          'onenote:tableRows': table.rowCount,
          'onenote:tableColumns': table.columnCount,
          'onenote:tableBordersVisible': table.bordersVisible,
          'onenote:columnWidths': table.columnWidths.toList(),
        },
      ),
    );
    return height;
  }

  String _outlineElementText(one.OneNoteOutlineElement element) => [
    ...element.contents.map(_contentText),
    ...element.children.map(
      (child) => child.when(
        group: (group) => group.items.map(_outlineItemText).join(' '),
        element: _outlineElementText,
      ),
    ),
  ].where((value) => value.trim().isNotEmpty).join(' ');

  String _outlineItemText(one.OneNoteOutlineItem item) => item.when(
    group: (group) => group.items.map(_outlineItemText).join(' '),
    element: _outlineElementText,
  );

  String _contentText(one.OneNoteContent content) => content.when(
    richText: (value) => value.text,
    table: (value) => value.rows
        .map(
          (row) => row.cells
              .map((cell) => cell.contents.map(_outlineElementText).join(' '))
              .join(' '),
        )
        .join(' '),
    image: (value) => value.altText ?? value.ocrText ?? '',
    embeddedFile: (value) => value.filename,
    ink: (value) => _inkText(value),
    unknown: () => '',
  );

  double _addImage(one.OneNoteImage image, Point<double> fallback) {
    final data = image.data;
    if (data == null || data.isEmpty) {
      final description = image.altText ?? image.ocrText;
      if (description == null || description.isEmpty) return 0;
      return _addPlainText(
        description,
        fallback,
        extra: {'onenote:image': true},
      );
    }
    final extension = _cleanExtension(image.extension_ ?? image.filename);
    String path;
    final imported = document.importImage(data, extension);
    document = imported.$1;
    path = imported.$2;
    final width =
        (image.pictureWidth ?? image.layoutMaxWidth ?? 4) * _pixelsPerHalfInch;
    final height =
        (image.pictureHeight ?? image.layoutMaxHeight ?? 3) *
        _pixelsPerHalfInch;
    final position = Point<double>(
      image.offsetHorizontal != null
          ? image.offsetHorizontal! * _pixelsPerHalfInch
          : fallback.x,
      image.offsetVertical != null
          ? image.offsetVertical! * _pixelsPerHalfInch
          : fallback.y,
    );
    final source = Uri.file(path, windows: false).toString();
    if (image.isBackground) {
      _backgrounds.add(
        Background.image(
          source: source,
          width: width,
          height: height,
          extra: {
            'onenote:filename': ?image.filename,
            'onenote:altText': ?image.altText,
            'onenote:ocrText': ?image.ocrText,
          },
        ),
      );
    } else {
      _elements.add(
        ImageElement(
          source: source,
          position: position,
          width: width,
          height: height,
          extra: {
            'onenote:filename': ?image.filename,
            'onenote:altText': ?image.altText,
            'onenote:ocrText': ?image.ocrText,
            'onenote:hyperlink': ?image.hyperlinkUrl,
          },
        ),
      );
    }
    return image.offsetHorizontal != null || image.offsetVertical != null
        ? 0
        : height;
  }

  double _addEmbeddedFile(
    one.OneNoteEmbeddedFile file,
    Point<double> fallback,
  ) {
    final extension = _cleanExtension(
      file.fileType.isNotEmpty ? file.fileType : file.filename,
    );
    String path;
    final imported = document.importAsset('attachments', file.data, extension);
    document = imported.$1;
    path = imported.$2;
    final position = Point<double>(
      file.offsetHorizontal != null
          ? file.offsetHorizontal! * _pixelsPerHalfInch
          : fallback.x,
      file.offsetVertical != null
          ? file.offsetVertical! * _pixelsPerHalfInch
          : fallback.y,
    );
    final height = _addPlainText(
      '📎 ${file.filename}',
      position,
      extra: {
        'onenote:attachment': path,
        'onenote:fileType': file.fileType,
        'onenote:size': file.size.toString(),
      },
    );
    return file.offsetHorizontal != null || file.offsetVertical != null
        ? 0
        : height;
  }

  double _addInk(
    one.OneNoteInk ink,
    Point<double> fallback, {
    required bool embedded,
  }) {
    final maxY = _addInkAt(ink, fallback, embedded, ink.boundingBox);
    return max(0, maxY - fallback.y);
  }

  double _addInkAt(
    one.OneNoteInk ink,
    Point<double> fallback,
    bool embedded,
    one.OneNoteInkBoundingBox? displayBoundingBox,
  ) {
    final boundingBox = ink.boundingBox ?? displayBoundingBox;
    final origin = embedded
        ? Point<double>(
            fallback.x - (boundingBox?.x ?? 0) * _himetricToPixels,
            fallback.y - (boundingBox?.y ?? 0) * _himetricToPixels,
          )
        : Point<double>(
            fallback.x + (ink.offsetHorizontal ?? 0) * _pixelsPerHalfInch,
            fallback.y + (ink.offsetVertical ?? 0) * _pixelsPerHalfInch,
          );
    var maxY = embedded && boundingBox != null
        ? fallback.y + boundingBox.height * _himetricToPixels
        : origin.y;
    for (final stroke in ink.strokes) {
      final decoded = _decodeInkPath(stroke.path);
      if (decoded.isEmpty) continue;
      final color = _inkColor(stroke.color, stroke.transparency);
      final points = decoded
          .map(
            (point) => PathPoint(
              origin.x + point.x * _himetricToPixels,
              origin.y + point.y * _himetricToPixels,
            ),
          )
          .toList();
      maxY = max(maxY, points.map((point) => point.y).reduce(max));
      _elements.add(
        PenElement(
          points: points,
          property: PenProperty(
            strokeWidth: _inkStrokeWidth(stroke),
            thinning: 0,
            smoothing: 0,
            streamline: 0,
            paint: ElementPaint.solid(color: color),
          ),
          extra: {
            'onenote:penTip': ?stroke.penTip,
            'onenote:embeddedInk': embedded,
            'onenote:inkWidth': stroke.width,
            'onenote:inkHeight': stroke.height,
            'onenote:transparency': ?stroke.transparency,
            'onenote:recognizedText': ?stroke.recognizedText,
          },
        ),
      );
    }
    for (final child in ink.childGroups) {
      maxY = max(
        maxY,
        _addInkAt(
          child,
          fallback,
          embedded,
          ink.boundingBox ?? displayBoundingBox,
        ),
      );
    }
    return maxY;
  }

  double _addPlainText(
    String value,
    Point<double> position, {
    Map<String, dynamic> extra = const {},
  }) {
    const height = 24.0;
    _elements.add(
      TextElement(
        position: position,
        area: text.TextArea(
          paragraph: text.TextParagraph(
            textSpans: [text.InlineSpan.text(text: value)],
          ),
        ),
        constraint: const ElementConstraint(size: height),
        extra: extra,
      ),
    );
    return height;
  }

  String _inkText(one.OneNoteInk ink) => [
    ...ink.strokes.map((stroke) => stroke.recognizedText ?? ''),
    ...ink.childGroups.map(_inkText),
  ].where((value) => value.isNotEmpty).join(' ');

  text.HorizontalAlignment _alignment(String value) {
    final normalized = value.toLowerCase();
    if (normalized.contains('center')) return text.HorizontalAlignment.center;
    if (normalized.contains('right')) return text.HorizontalAlignment.right;
    if (normalized.contains('justify')) {
      return text.HorizontalAlignment.justify;
    }
    return text.HorizontalAlignment.left;
  }

  double _fontSize(one.OneNoteTextStyle style) =>
      ((style.fontSize ?? 18) / 2 * _pixelsPerInch / 72).clamp(1, 512);

  SRGBColor _inkColor(int? value, int? transparency) {
    final color = value ?? 0;
    final red = color & 0xFF;
    final green = (color >> 8) & 0xFF;
    final blue = (color >> 16) & 0xFF;
    final alpha = 255 - (transparency ?? 0).clamp(0, 255);
    return SRGBColor((alpha << 24) | (red << 16) | (green << 8) | blue);
  }

  double _inkStrokeWidth(one.OneNoteInkStroke stroke) {
    final width = stroke.penTip == 1
        ? max(stroke.width, stroke.height)
        : stroke.width;
    return width.abs() * _himetricToPixels;
  }

  List<Point<double>> _decodeInkPath(List<one.OneNoteInkPoint> encoded) {
    if (encoded.isEmpty) return const [];
    var x = encoded.first.x;
    var y = encoded.first.y;
    final points = <Point<double>>[Point(x, y)];
    for (var i = 1; i < encoded.length; i++) {
      x += encoded[i].x;
      y += encoded[i].y;
      points.add(Point(x, y));
    }
    return points;
  }

  String _cleanExtension(String? value) {
    final extension =
        value?.split('/').last.split('.').last.toLowerCase() ?? '';
    final cleaned = extension.replaceAll(RegExp('[^a-z0-9]'), '');
    return cleaned.isEmpty ? 'bin' : cleaned;
  }

  double _outlineIndent(
    Float32List indents,
    int parentLevel,
    int currentLevel,
  ) {
    var width = 0.0;
    for (var level = parentLevel + 1; level <= currentLevel; level++) {
      width +=
          (level < indents.length ? indents[level] : 0.75) * _pixelsPerHalfInch;
    }
    return width;
  }
}
