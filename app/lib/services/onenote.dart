import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:material_leap/material_leap.dart';
import 'package:onenote_parser/onenote_parser.dart' as one;

import 'onenote_library.dart';

Future<void>? _oneNoteInitialization;

const _pixelsPerInch = 96.0;
const _pixelsPerHalfInch = _pixelsPerInch / 2;
const _himetricUnitsPerInch = 2540.0;
const _himetricToPixels = _pixelsPerInch / _himetricUnitsPerInch;

typedef OneNoteXpsConverter =
    Future<Uint8List?> Function(Uint8List data, String fileName);
typedef XpsProcessRunner =
    Future<ProcessResult> Function(String executable, List<String> arguments);

class XpsToPdfNotInstalledException implements Exception {
  const XpsToPdfNotInstalledException();

  @override
  String toString() => 'xpstopdf is not installed';
}

Future<Uint8List> convertXpsToPdf(
  Uint8List data, {
  String executable = 'xpstopdf',
  XpsProcessRunner runProcess = _runProcess,
}) async {
  if (kIsWeb) throw const XpsToPdfNotInstalledException();
  final directory = await Directory.systemTemp.createTemp('butterfly_xps_');
  final input = File('${directory.path}/input.xps');
  final output = File('${directory.path}/output.pdf');
  final arguments = [input.path, output.path];
  try {
    await input.writeAsBytes(data);
    ProcessResult result;
    try {
      result = await runProcess(executable, arguments);
    } on ProcessException catch (error) {
      if (error.errorCode == 2) {
        throw const XpsToPdfNotInstalledException();
      }
      rethrow;
    } on UnsupportedError {
      throw const XpsToPdfNotInstalledException();
    }
    if (result.exitCode != 0 || !await output.exists()) {
      throw ProcessException(
        executable,
        arguments,
        result.stderr.toString(),
        result.exitCode,
      );
    }
    return output.readAsBytes();
  } finally {
    try {
      await directory.delete(recursive: true);
    } catch (_) {}
  }
}

Future<ProcessResult> _runProcess(String executable, List<String> arguments) =>
    Process.run(executable, arguments);

bool isPdfData(Uint8List data) {
  const header = [0x25, 0x50, 0x44, 0x46, 0x2D]; // %PDF-
  final searchLength = min(data.length, 1024);
  for (var offset = 0; offset <= searchLength - header.length; offset++) {
    var matches = true;
    for (var index = 0; index < header.length; index++) {
      if (data[offset + index] != header[index]) {
        matches = false;
        break;
      }
    }
    if (matches) return true;
  }
  return false;
}

Future<NoteData> parseOneNoteData(
  Uint8List bytes, {
  required String name,
  required bool isPackage,
  OneNoteXpsConverter? convertXps,
}) async {
  await (_oneNoteInitialization ??= _initializeOneNoteParser());
  if (isPackage) {
    final notebook = await one.parsePackageBytes(data: bytes);
    final xpsFiles = await convertOneNoteXpsFiles(
      _notebookImages(notebook),
      convertXps,
    );
    return convertOneNoteNotebook(notebook, name: name, xpsFiles: xpsFiles);
  }
  final section = await one.parseSectionBytes(
    data: bytes,
    fileName: '$name.one',
  );
  final xpsFiles = await convertOneNoteXpsFiles(
    _sectionImages(section),
    convertXps,
  );
  return convertOneNoteSection(section, name: name, xpsFiles: xpsFiles);
}

Future<void> _initializeOneNoteParser() async {
  await ensureOneNoteLibraryAvailable();
  await one.RustLib.init();
}

NoteData convertOneNoteSection(
  one.OneNoteSection section, {
  String? name,
  Map<Uint8List, Uint8List?>? xpsFiles,
}) {
  final converter = _OneNoteConverter(
    name ?? section.displayName,
    xpsFiles ?? HashMap.identity(),
  );
  converter.addSection(section, const []);
  return converter.finish();
}

NoteData convertOneNoteNotebook(
  one.OneNoteNotebook notebook, {
  required String name,
  Map<Uint8List, Uint8List?>? xpsFiles,
}) {
  final converter = _OneNoteConverter(name, xpsFiles ?? HashMap.identity());
  converter.addEntries(notebook.entries, const []);
  return converter.finish(
    warnings: notebook.warnings.map((warning) => warning.message).toList(),
  );
}

@visibleForTesting
Future<Map<Uint8List, Uint8List?>> convertOneNoteXpsFiles(
  List<one.OneNoteImage> images,
  OneNoteXpsConverter? converter,
) async {
  const equality = ListEquality<int>();
  final result = HashMap<Uint8List, Uint8List?>(
    equals: equality.equals,
    hashCode: equality.hash,
  );
  final convertedPrintouts = <String, Uint8List?>{};
  for (final image in images) {
    final data = image.data;
    if (data == null ||
        data.isEmpty ||
        _fileExtension(image.extension_ ?? image.filename) != 'xps' ||
        result.containsKey(data)) {
      continue;
    }
    final fileName = image.filename?.trim();
    final printoutKey = fileName == null || fileName.isEmpty
        ? null
        : fileName.replaceAll(r'\', '/').split('/').last.toLowerCase();
    if (printoutKey != null && convertedPrintouts.containsKey(printoutKey)) {
      result[data] = convertedPrintouts[printoutKey];
      continue;
    }
    final converted = await (converter ?? _defaultXpsConverter)(
      data,
      fileName ?? 'printout.xps',
    );
    result[data] = converted;
    if (printoutKey != null) {
      convertedPrintouts[printoutKey] = converted;
    }
  }
  return result;
}

Future<Uint8List?> _defaultXpsConverter(Uint8List data, String _) =>
    convertXpsToPdf(data);

List<one.OneNoteImage> _notebookImages(one.OneNoteNotebook notebook) {
  final images = <one.OneNoteImage>[];

  void addEntries(List<one.OneNoteSectionEntry> entries) {
    for (final entry in entries) {
      entry.when(
        section: (section) => images.addAll(_sectionImages(section)),
        sectionGroup: (group) => addEntries(group.entries),
      );
    }
  }

  addEntries(notebook.entries);
  return images;
}

List<one.OneNoteImage> _sectionImages(one.OneNoteSection section) {
  final images = <one.OneNoteImage>[];

  late void Function(one.OneNoteContent) addContent;
  late void Function(one.OneNoteOutlineElement) addOutlineElement;
  late void Function(one.OneNoteOutlineItem) addOutlineItem;

  addOutlineElement = (element) {
    for (final content in element.contents) {
      addContent(content);
    }
    for (final child in element.children) {
      addOutlineItem(child);
    }
  };

  addOutlineItem = (item) {
    item.when(
      group: (group) {
        for (final item in group.items) {
          addOutlineItem(item);
        }
      },
      element: addOutlineElement,
    );
  };

  addContent = (content) {
    content.when(
      richText: (_) {},
      table: (table) {
        for (final row in table.rows) {
          for (final cell in row.cells) {
            for (final element in cell.contents) {
              addOutlineElement(element);
            }
          }
        }
      },
      image: images.add,
      embeddedFile: (_) {},
      ink: (_) {},
      unknown: () {},
    );
  };

  for (final series in section.pageSeries) {
    for (final page in series.pages) {
      for (final content in page.contents) {
        content.when(
          outline: (outline) {
            for (final item in outline.items) {
              addOutlineItem(item);
            }
          },
          image: images.add,
          embeddedFile: (_) {},
          ink: (_) {},
          unknown: () {},
        );
      }
    }
  }
  return images;
}

String _fileExtension(String? value) {
  final extension = value?.split('/').last.split('.').last.toLowerCase() ?? '';
  final cleaned = extension.replaceAll(RegExp('[^a-z0-9]'), '');
  return cleaned.isEmpty ? 'bin' : cleaned;
}

class _OneNoteConverter {
  NoteData _document;
  final String name;
  final Map<Uint8List, Uint8List?> xpsFiles;

  _OneNoteConverter(this.name, this.xpsFiles)
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
        final builder = _OneNotePageBuilder(_document, xpsFiles);
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
  final Map<Uint8List, Uint8List?> xpsFiles;
  final List<PadElement> _elements = [];
  final List<Background> _backgrounds = [];

  _OneNotePageBuilder(this.document, this.xpsFiles);

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

    if (value.embeddedObjects.isNotEmpty) {
      final height = _addEmbeddedObjects(
        value.embeddedObjects,
        Point(position.x, position.y + spaceBefore),
        availableWidth,
      );
      return spaceBefore + height + spaceAfter;
    }

    if (value.text.isEmpty) {
      return spaceBefore + spaceAfter;
    }

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

  double _addEmbeddedObjects(
    List<one.OneNoteEmbeddedObject> objects,
    Point<double> origin,
    double availableWidth,
  ) {
    var x = origin.x;
    var y = origin.y;
    var lineHeight = 0.0;
    var maximumY = origin.y;

    void newLine() {
      y += max(lineHeight, 16);
      x = origin.x;
      lineHeight = 0;
    }

    for (final object in objects) {
      object.when(
        ink: (embedded) {
          final inkBox = embedded.ink.boundingBox;
          final displayBox = embedded.displayBoundingBox;

          // InkBoundingBox is in HIMETRIC.
          // Embedded display dimensions are already display/pixel-like units.
          final width = inkBox != null
              ? inkBox.width * _himetricToPixels
              : displayBox?.width ?? 0;

          final height = inkBox != null
              ? inkBox.height * _himetricToPixels
              : displayBox?.height ?? 0;

          if (x > origin.x &&
              availableWidth.isFinite &&
              x + width > origin.x + availableWidth) {
            newLine();
          }

          _addInkAt(
            embedded.ink,
            Point(x, y),
            true,
            displayBox,
            displayBoundingBoxScale: 1,
          );

          x += width;
          lineHeight = max(lineHeight, height);
          maximumY = max(maximumY, y + height);
        },
        inkSpace: (space) {
          // These values use OneNote half-inch layout units.
          x += space.width * _pixelsPerHalfInch;
          lineHeight = max(lineHeight, space.height * _pixelsPerHalfInch);
        },
        inkLineBreak: () {
          newLine();
        },
      );
    }

    maximumY = max(maximumY, y + lineHeight);
    return max(16, maximumY - origin.y);
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
    if (extension == 'xps') {
      final pdf = xpsFiles[data];
      final pageNumber = image.displayedPageNumber;
      if (pdf != null && pageNumber != null) {
        final importedPdf = document.importPdf(pdf);
        document = importedPdf.$1;
        _elements.add(
          PdfElement(
            source: Uri.file(importedPdf.$2, windows: false).toString(),
            position: position,
            width: width,
            height: height,
            page: pageNumber,
            extra: {
              'onenote:filename': ?image.filename,
              'onenote:altText': ?image.altText,
              'onenote:ocrText': ?image.ocrText,
              'onenote:displayedPageNumber': pageNumber,
            },
          ),
        );
      }
      return image.offsetHorizontal != null || image.offsetVertical != null
          ? 0
          : height;
    }

    final imported = document.importImage(data, extension);
    document = imported.$1;
    final path = imported.$2;
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
    one.OneNoteInkBoundingBox? displayBoundingBox, {
    double displayBoundingBoxScale = _himetricToPixels,
  }) {
    final inkBoundingBox = ink.boundingBox;
    final boundingBox = inkBoundingBox ?? displayBoundingBox;

    final boundingBoxScale = inkBoundingBox != null
        ? _himetricToPixels
        : displayBoundingBoxScale;

    final origin = embedded
        ? Point<double>(
            fallback.x - (boundingBox?.x ?? 0) * boundingBoxScale,
            fallback.y - (boundingBox?.y ?? 0) * boundingBoxScale,
          )
        : Point<double>(
            fallback.x + (ink.offsetHorizontal ?? 0) * _pixelsPerHalfInch,
            fallback.y + (ink.offsetVertical ?? 0) * _pixelsPerHalfInch,
          );

    var maxY = embedded && boundingBox != null
        ? fallback.y + boundingBox.height * boundingBoxScale
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
    return _fileExtension(value);
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
