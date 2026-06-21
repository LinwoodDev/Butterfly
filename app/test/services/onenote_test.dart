import 'dart:io';
import 'dart:typed_data';

import 'package:butterfly/services/onenote.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter_test/flutter_test.dart';
import 'package:onenote_parser/onenote_parser.dart' as one;

const _plainStyle = one.OneNoteTextStyle(
  bold: false,
  italic: false,
  underline: false,
  strikethrough: false,
  superscript: false,
  subscript: false,
  fontSize: 12,
  mathFormatting: false,
  hyperlink: false,
  hyperlinkProtected: false,
  hidden: false,
);

const _boldStyle = one.OneNoteTextStyle(
  bold: true,
  italic: false,
  underline: false,
  strikethrough: false,
  superscript: false,
  subscript: false,
  fontSize: 16,
  mathFormatting: false,
  hyperlink: false,
  hyperlinkProtected: false,
  hidden: false,
);

void main() {
  test('reports when xpstopdf is not installed', () async {
    await expectLater(
      convertXpsToPdf(
        Uint8List.fromList([1, 2, 3]),
        executable: 'butterfly-test-missing-xpstopdf',
      ),
      throwsA(isA<XpsToPdfNotInstalledException>()),
    );
  });

  test('passes input and output paths to xpstopdf', () async {
    final pdf = Uint8List.fromList([4, 5, 6]);
    late List<String> arguments;

    final result = await convertXpsToPdf(
      Uint8List.fromList([1, 2, 3]),
      runProcess: (executable, passedArguments) async {
        expect(executable, 'xpstopdf');
        arguments = passedArguments;
        await File(passedArguments.last).writeAsBytes(pdf);
        return ProcessResult(1, 0, '', '');
      },
    );

    expect(arguments, hasLength(2));
    expect(arguments.first, endsWith('input.xps'));
    expect(arguments.last, endsWith('output.pdf'));
    expect(result, pdf);
  });

  test('reports non-zero xpstopdf exits as conversion failures', () async {
    await expectLater(
      convertXpsToPdf(
        Uint8List.fromList([1, 2, 3]),
        runProcess: (_, _) async => ProcessResult(1, 1, '', 'invalid XPS'),
      ),
      throwsA(isA<ProcessException>()),
    );
  });

  test('converts all pages of the same XPS printout only once', () async {
    final firstPageData = Uint8List.fromList([1, 2, 3]);
    final secondPageData = Uint8List.fromList([4, 5, 6]);
    final pdf = Uint8List.fromList([7, 8, 9]);
    var conversions = 0;

    final converted = await convertOneNoteXpsFiles(
      [
        one.OneNoteImage(
          data: firstPageData,
          extension_: 'xps',
          filename: r'Printouts\document.xps',
          displayedPageNumber: 1,
          isBackground: false,
        ),
        one.OneNoteImage(
          data: secondPageData,
          extension_: 'xps',
          filename: 'document.xps',
          displayedPageNumber: 2,
          isBackground: false,
        ),
      ],
      (data, fileName) async {
        conversions++;
        return pdf;
      },
    );

    expect(conversions, 1);
    expect(converted[firstPageData], pdf);
    expect(converted[secondPageData], pdf);
  });

  test('converts OneNote page content and embedded assets', () {
    final richText = one.OneNoteRichText(
      text: 'Hello world',
      textRunIndices: Uint32List.fromList([0, 6]),
      textRunStyles: const [_boldStyle, _plainStyle],
      paragraphStyle: _plainStyle,
      paragraphSpaceBefore: 0.25,
      paragraphSpaceAfter: 0.5,
      paragraphAlignment: 'Center',
      embeddedObjects: const [],
    );
    final outline = one.OneNoteOutline(
      childLevel: 0,
      indents: Float32List(0),
      isLayoutSizeSetByUser: true,
      layoutMaxWidth: 6,
      offsetHorizontal: 1,
      offsetVertical: 2,
      items: [
        one.OneNoteOutlineItem.element(
          one.OneNoteOutlineElement(
            contents: [one.OneNoteContent.richText(richText)],
            childLevel: 0,
            children: const [],
          ),
        ),
      ],
    );
    final imageBytes = Uint8List.fromList([1, 2, 3]);
    final attachmentBytes = Uint8List.fromList([4, 5, 6]);
    final page = one.OneNotePage(
      linkTargetId: 'page-id',
      title: 'Planning',
      level: 1,
      createdAt: '2026-01-02T03:04:05Z',
      updatedAt: '2026-01-03T03:04:05Z',
      author: 'Ada',
      contents: [
        one.OneNotePageContent.outline(outline),
        one.OneNotePageContent.image(
          one.OneNoteImage(
            data: imageBytes,
            extension_: 'png',
            filename: 'diagram.png',
            pictureWidth: 4,
            pictureHeight: 3,
            offsetHorizontal: 2,
            offsetVertical: 4,
            isBackground: false,
          ),
        ),
        one.OneNotePageContent.embeddedFile(
          one.OneNoteEmbeddedFile(
            filename: 'notes.txt',
            fileType: 'txt',
            data: attachmentBytes,
            size: BigInt.from(attachmentBytes.length),
            offsetHorizontal: 0.5,
            offsetVertical: 8,
          ),
        ),
        one.OneNotePageContent.ink(
          const one.OneNoteInk(
            strokes: [
              one.OneNoteInkStroke(
                path: [
                  one.OneNoteInkPoint(x: 1, y: 2),
                  one.OneNoteInkPoint(x: 3, y: 4),
                ],
                transparency: 64,
                height: 100,
                width: 100,
                color: 0x112233,
              ),
            ],
            childGroups: [],
            offsetHorizontal: 10,
            offsetVertical: 20,
          ),
        ),
      ],
    );
    final section = one.OneNoteSection(
      displayName: 'Work',
      pageSeries: [
        one.OneNotePageSeries(pages: [page]),
      ],
      warnings: const [],
    );

    final document = convertOneNoteSection(section, name: 'Imported');
    final convertedPage = document.getPage('Work/Planning');

    expect(document.getMetadata()?.name, 'Imported');
    expect(convertedPage, isNotNull);
    expect(convertedPage!.extra['onenote:author'], 'Ada');

    final label = convertedPage.content.whereType<TextElement>().first;
    expect(label.position.x, 48);
    expect(label.position.y, 108);
    expect(label.constraint.size, 288);
    expect(label.constraint.length, closeTo(12.8, 0.0001));
    expect(
      (label.area.paragraph.property as text.DefinedParagraphProperty)
          .alignment,
      text.HorizontalAlignment.center,
    );
    expect(label.area.paragraph.textSpans, hasLength(2));
    expect(
      (label.area.paragraph.textSpans.first.property
              as text.DefinedSpanProperty)
          .fontWeight,
      text.kFontWeightBold,
    );

    final image = convertedPage.content.whereType<ImageElement>().single;
    expect(image.position.x, 96);
    expect(image.position.y, 192);
    expect(image.width, 192);
    expect(image.height, 144);
    expect(document.getAsset(Uri.parse(image.source).path), imageBytes);

    final attachment = convertedPage.content
        .whereType<TextElement>()
        .firstWhere((element) => element.extra['onenote:attachment'] != null);
    final attachmentPath = attachment.extra['onenote:attachment'] as String;
    expect(document.getAsset(attachmentPath), attachmentBytes);

    final stroke = convertedPage.content.whereType<PenElement>().single;
    expect(stroke.points.first.x, closeTo(480.0378, 0.0001));
    expect(stroke.points.first.y, closeTo(960.0756, 0.0001));
    expect(stroke.property.strokeWidth, closeTo(3.7795, 0.0001));
    expect(stroke.property.thinning, 0);
    expect(stroke.property.streamline, 0);
    expect(stroke.property.paint.previewColor.value, 0xBF332211);
  });

  test('uses leaf offsets for nested page ink', () {
    const stroke = one.OneNoteInkStroke(
      path: [one.OneNoteInkPoint(x: 2540, y: 1270)],
      penTip: 0,
      height: 400,
      width: 100,
    );
    const ink = one.OneNoteInk(
      strokes: [],
      childGroups: [
        one.OneNoteInk(
          strokes: [stroke],
          childGroups: [],
          offsetHorizontal: 2,
          offsetVertical: 3,
        ),
      ],
      offsetHorizontal: 1,
      offsetVertical: 1,
    );
    final section = one.OneNoteSection(
      displayName: 'Ink',
      pageSeries: [
        one.OneNotePageSeries(
          pages: [
            one.OneNotePage(
              linkTargetId: 'ink-page',
              title: 'Nested',
              level: 0,
              createdAt: '',
              updatedAt: '',
              contents: [one.OneNotePageContent.ink(ink)],
            ),
          ],
        ),
      ],
      warnings: const [],
    );

    final document = convertOneNoteSection(section);
    final imported = document
        .getPage('Ink/Nested')!
        .content
        .whereType<PenElement>()
        .single;

    expect(imported.points.single.x, 192);
    expect(imported.points.single.y, 192);
    expect(imported.property.strokeWidth, closeTo(3.7795, 0.0001));
  });

  test('uses converted PDF data for XPS printouts', () {
    final xps = Uint8List.fromList([1, 2, 3]);
    final pdf = Uint8List.fromList([4, 5, 6]);
    final page = one.OneNotePage(
      linkTargetId: 'printout-page',
      title: 'Printout',
      level: 0,
      createdAt: '',
      updatedAt: '',
      contents: [
        one.OneNotePageContent.image(
          one.OneNoteImage(
            data: xps,
            extension_: 'xps',
            filename: 'printout.xps',
            displayedPageNumber: 2,
            pictureWidth: 4,
            pictureHeight: 3,
            isBackground: false,
          ),
        ),
      ],
    );
    final section = one.OneNoteSection(
      displayName: 'Files',
      pageSeries: [
        one.OneNotePageSeries(pages: [page]),
      ],
      warnings: const [],
    );

    final document = convertOneNoteSection(section, xpsFiles: {xps: pdf});
    final convertedPage = document.getPage('Files/Printout')!;
    final printout = convertedPage.content.whereType<PdfElement>().single;

    expect(printout.page, 1);
    expect(printout.width, 192);
    expect(printout.height, 144);
    expect(document.getAsset(Uri.parse(printout.source).path), pdf);
    expect(convertedPage.content.whereType<ImageElement>(), isEmpty);
  });

  test('creates one PDF element per XPS page without image duplicates', () {
    final firstXps = Uint8List.fromList([1, 2, 3]);
    final secondXps = Uint8List.fromList([4, 5, 6]);
    final pdf = Uint8List.fromList([7, 8, 9]);
    final page = one.OneNotePage(
      linkTargetId: 'printout-page',
      title: 'Printout',
      level: 0,
      createdAt: '',
      updatedAt: '',
      contents: [
        for (final (index, data) in [firstXps, secondXps].indexed)
          one.OneNotePageContent.image(
            one.OneNoteImage(
              data: data,
              extension_: 'xps',
              filename: 'document.xps',
              displayedPageNumber: index + 1,
              isBackground: false,
            ),
          ),
      ],
    );
    final section = one.OneNoteSection(
      displayName: 'Files',
      pageSeries: [
        one.OneNotePageSeries(pages: [page]),
      ],
      warnings: const [],
    );

    final document = convertOneNoteSection(
      section,
      xpsFiles: {firstXps: pdf, secondXps: pdf},
    );
    final content = document.getPage('Files/Printout')!.content;

    expect(content.whereType<PdfElement>().map((element) => element.page), [
      0,
      1,
    ]);
    expect(content.whereType<ImageElement>(), isEmpty);
  });

  test('skips XPS printouts without converted PDF data', () {
    final xps = Uint8List.fromList([1, 2, 3]);
    final page = one.OneNotePage(
      linkTargetId: 'printout-page',
      title: 'Printout',
      level: 0,
      createdAt: '',
      updatedAt: '',
      contents: [
        one.OneNotePageContent.image(
          one.OneNoteImage(
            data: xps,
            extension_: 'xps',
            displayedPageNumber: 1,
            isBackground: false,
          ),
        ),
      ],
    );
    final section = one.OneNoteSection(
      displayName: 'Files',
      pageSeries: [
        one.OneNotePageSeries(pages: [page]),
      ],
      warnings: const [],
    );

    final document = convertOneNoteSection(section, xpsFiles: {xps: null});

    expect(document.getPage('Files/Printout')!.content, isEmpty);
  });

  test('positions embedded ink relative to its bounding box', () {
    const ink = one.OneNoteInk(
      strokes: [
        one.OneNoteInkStroke(
          path: [one.OneNoteInkPoint(x: 2540, y: 5080)],
          height: 100,
          width: 100,
        ),
      ],
      childGroups: [],
      boundingBox: one.OneNoteInkBoundingBox(
        x: 2540,
        y: 5080,
        width: 1000,
        height: 1000,
      ),
      offsetHorizontal: 20,
      offsetVertical: 20,
    );
    final outline = one.OneNoteOutline(
      childLevel: 0,
      indents: Float32List(0),
      isLayoutSizeSetByUser: true,
      layoutMaxWidth: 5,
      offsetHorizontal: 2,
      offsetVertical: 3,
      items: [
        one.OneNoteOutlineItem.element(
          const one.OneNoteOutlineElement(
            contents: [one.OneNoteContent.ink(ink)],
            childLevel: 0,
            children: [],
          ),
        ),
      ],
    );
    final section = one.OneNoteSection(
      displayName: 'Ink',
      pageSeries: [
        one.OneNotePageSeries(
          pages: [
            one.OneNotePage(
              linkTargetId: 'embedded-page',
              title: 'Embedded',
              level: 0,
              createdAt: '',
              updatedAt: '',
              contents: [one.OneNotePageContent.outline(outline)],
            ),
          ],
        ),
      ],
      warnings: const [],
    );

    final document = convertOneNoteSection(section);
    final point = document
        .getPage('Ink/Embedded')!
        .content
        .whereType<PenElement>()
        .single
        .points
        .single;

    expect(point.x, 96);
    expect(point.y, 144);
  });

  test('reserves embedded ink bounding box height in outline flow', () {
    const ink = one.OneNoteInk(
      strokes: [
        one.OneNoteInkStroke(
          path: [one.OneNoteInkPoint(x: 0, y: 0)],
          height: 100,
          width: 100,
        ),
      ],
      childGroups: [],
      boundingBox: one.OneNoteInkBoundingBox(
        x: 0,
        y: 0,
        width: 2540,
        height: 2540,
      ),
    );
    final outline = one.OneNoteOutline(
      childLevel: 0,
      indents: Float32List(0),
      isLayoutSizeSetByUser: true,
      layoutMaxWidth: 5,
      items: [
        one.OneNoteOutlineItem.element(
          one.OneNoteOutlineElement(
            contents: [
              const one.OneNoteContent.ink(ink),
              one.OneNoteContent.richText(
                one.OneNoteRichText(
                  text: 'After ink',
                  textRunIndices: Uint32List(0),
                  textRunStyles: const [],
                  paragraphStyle: _plainStyle,
                  paragraphSpaceBefore: 0,
                  paragraphSpaceAfter: 0,
                  paragraphAlignment: 'Left',
                  embeddedObjects: const [],
                ),
              ),
            ],
            childLevel: 0,
            children: const [],
          ),
        ),
      ],
    );
    final section = one.OneNoteSection(
      displayName: 'Ink',
      pageSeries: [
        one.OneNotePageSeries(
          pages: [
            one.OneNotePage(
              linkTargetId: 'flow-page',
              title: 'Flow',
              level: 0,
              createdAt: '',
              updatedAt: '',
              contents: [one.OneNotePageContent.outline(outline)],
            ),
          ],
        ),
      ],
      warnings: const [],
    );

    final document = convertOneNoteSection(section);
    final label = document
        .getPage('Ink/Flow')!
        .content
        .whereType<TextElement>()
        .single;

    expect(label.position.y, 96);
  });

  test('reconstructs OneNote delta ink packets', () {
    const ink = one.OneNoteInk(
      strokes: [
        one.OneNoteInkStroke(
          path: [
            one.OneNoteInkPoint(x: 2540, y: 2540),
            one.OneNoteInkPoint(x: 254, y: 0),
            one.OneNoteInkPoint(x: 0, y: 254),
            one.OneNoteInkPoint(x: -127, y: 0),
          ],
          height: 100,
          width: 100,
        ),
      ],
      childGroups: [],
    );
    final section = one.OneNoteSection(
      displayName: 'Ink',
      pageSeries: [
        one.OneNotePageSeries(
          pages: [
            one.OneNotePage(
              linkTargetId: 'delta-page',
              title: 'Delta',
              level: 0,
              createdAt: '',
              updatedAt: '',
              contents: [one.OneNotePageContent.ink(ink)],
            ),
          ],
        ),
      ],
      warnings: const [],
    );

    final document = convertOneNoteSection(section);
    final points = document
        .getPage('Ink/Delta')!
        .content
        .whereType<PenElement>()
        .single
        .points;

    expect(points.map((point) => point.x), [
      closeTo(96, 0.0001),
      closeTo(105.6, 0.0001),
      closeTo(105.6, 0.0001),
      closeTo(100.8, 0.0001),
    ]);
    expect(points.map((point) => point.y), [
      closeTo(96, 0.0001),
      closeTo(96, 0.0001),
      closeTo(105.6, 0.0001),
      closeTo(105.6, 0.0001),
    ]);
  });

  test('keeps notebook section groups in page names', () {
    final page = one.OneNotePage(
      linkTargetId: 'page-id',
      title: 'Ideas',
      level: 0,
      createdAt: '',
      updatedAt: '',
      contents: const [],
    );
    final notebook = one.OneNoteNotebook(
      entries: [
        one.OneNoteSectionEntry.sectionGroup(
          one.OneNoteSectionGroup(
            displayName: 'Projects',
            entries: [
              one.OneNoteSectionEntry.section(
                one.OneNoteSection(
                  displayName: 'Butterfly',
                  pageSeries: [
                    one.OneNotePageSeries(pages: [page]),
                  ],
                  warnings: const [],
                ),
              ),
            ],
          ),
        ),
      ],
      warnings: const [],
    );

    final document = convertOneNoteNotebook(notebook, name: 'Notebook');

    expect(document.getPages(), ['Projects/Butterfly/Ideas']);
    expect(document.getInfo()?.extra['onenote:imported'], isTrue);
  });
}
