import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:test/test.dart';

DocumentPage _pageWithLayer(String layerId) =>
    DocumentPage(layers: [DocumentLayer(id: layerId)]);

void main() {
  group('AssetFileType helpers', () {
    test('fromFileExtension handles uppercase and dotted PDF extensions', () {
      expect(AssetFileTypeHelper.fromFileExtension('PDF'), AssetFileType.pdf);
      expect(AssetFileTypeHelper.fromFileExtension('.PDF'), AssetFileType.pdf);
    });
  });

  group('NoteData page operations', () {
    test('addPage keeps existing page when name collides', () {
      var data = NoteData(Archive());
      const firstPage = DocumentPage(
        layers: [DocumentLayer(id: 'first-layer')],
      );
      const secondPage = DocumentPage(
        layers: [DocumentLayer(id: 'second-layer')],
      );

      final (withFirstPage, firstPageName) = data.addPage(
        firstPage,
        'Page',
        addNumber: false,
      );
      data = withFirstPage;

      final (withSecondPage, secondPageName) = data.addPage(
        secondPage,
        'Page',
        addNumber: false,
      );
      data = withSecondPage;

      expect(firstPageName, isNot(equals(secondPageName)));
      expect(data.getPages().length, 2);
      expect(data.getPage(firstPageName)?.layers.first.id, 'first-layer');
      expect(data.getPage(secondPageName)?.layers.first.id, 'second-layer');
      expect(data.getPages(), contains('Page 2'));
    });

    test('renamePage does not overwrite existing target name', () {
      var data = NoteData(Archive());
      const firstPage = DocumentPage(
        layers: [DocumentLayer(id: 'first-layer')],
      );
      const secondPage = DocumentPage(
        layers: [DocumentLayer(id: 'second-layer')],
      );

      final (withFirstPage, firstPageName) = data.setPage(firstPage, 'A');
      data = withFirstPage;
      final (withSecondPage, secondPageName) = data.setPage(secondPage, 'B');
      data = withSecondPage;

      final (renamedData, renamedPageName) = data.renamePage(
        secondPageName,
        'A',
      );
      data = renamedData;

      expect(data.getPages().length, 2);
      expect(renamedPageName, isNot(equals(firstPageName)));
      expect(data.getPage('A')?.layers.first.id, 'first-layer');
      expect(data.getPage(renamedPageName)?.layers.first.id, 'second-layer');
      expect(data.getPages(), contains('A 2'));
    });

    test('setPage updates existing page when using display name', () {
      var data = NoteData(Archive());
      final firstPage = _pageWithLayer('first-layer');
      final secondPage = _pageWithLayer('updated-layer');

      final (withFirstPage, firstPageName) = data.setPage(firstPage, 'Main');
      data = withFirstPage;
      final (updatedData, updatedPageName) = data.setPage(secondPage, 'Main');
      data = updatedData;

      expect(firstPageName, updatedPageName);
      expect(data.getPages().length, 1);
      expect(data.getPage('Main')?.layers.first.id, 'updated-layer');
    });

    test('reorderPage keeps display names and updates indices', () {
      var data = NoteData(Archive());
      final firstPage = _pageWithLayer('first-layer');
      final secondPage = _pageWithLayer('second-layer');

      final (withFirstPage, firstPageName) = data.setPage(firstPage, 'A');
      data = withFirstPage;
      final (withSecondPage, secondPageName) = data.setPage(secondPage, 'B');
      data = withSecondPage;

      final moveToEndIndex = data.getPages().length;
      data = data.reorderPage(firstPageName, moveToEndIndex);

      final pagesWithNames = data.getPagesWithNames();
      expect(pagesWithNames.map((e) => e.$1).toList(), ['B', 'A']);
      expect(data.getPage('A')?.layers.first.id, 'first-layer');
      expect(data.getPage('B')?.layers.first.id, 'second-layer');
      expect(data.getPageIndex(secondPageName), 1);
    });

    test('renamePage returns unchanged data if source page is missing', () {
      var data = NoteData(Archive());
      final firstPage = _pageWithLayer('first-layer');
      (data, _) = data.setPage(firstPage, 'Only');

      final (renamedData, renamedName) = data.renamePage('missing', 'New Name');

      expect(identical(renamedData, data), isTrue);
      expect(renamedName, 'missing');
      expect(data.getPages(), ['Only']);
    });

    test('addPage with empty name increments numeric names', () {
      var data = NoteData(Archive());

      final (firstData, firstName) = data.addPage(_pageWithLayer('one'), '');
      data = firstData;
      final (secondData, secondName) = data.addPage(_pageWithLayer('two'), '');
      data = secondData;

      expect(firstName, isNot(equals(secondName)));
      expect(data.getPages(), ['1', '2']);
    });

    test('addPage does not append 1 when provided name is unique', () {
      var data = NoteData(Archive());

      // Start with a single untitled page (display name is '').
      (data, _) = data.setPage(_pageWithLayer('untitled-layer'), '');

      final (updatedData, newPageName) = data.addPage(
        _pageWithLayer('second-layer'),
        'Page 2',
      );
      data = updatedData;

      expect(newPageName, endsWith('.Page 2'));
      expect(data.getPages(), contains('Page 2'));
      expect(data.getPages(), isNot(contains('Page 2 1')));
      expect(data.getPage('Page 2')?.layers.first.id, 'second-layer');
    });
  });

  group('NoteData metadata conversion', () {
    test('NoteFile display reads text thumbnails and metadata', () async {
      final bytes = await File('test/assets/study.tbfly').readAsBytes();

      final display = NoteFile(bytes).display();

      expect(display, isNotNull);
      expect(display!.getMetadata()?.name, 'Study');
      expect(display.getThumbnail(), isNotNull);
      expect(display.getThumbnail(), isNotEmpty);
    });

    test('createTemplate sets template metadata and thumbnail', () {
      var data = NoteData(Archive());
      data = data.setMetadata(
        FileMetadata(
          type: NoteFileType.document,
          name: 'Original',
          description: 'Before',
          directory: 'docs',
          createdAt: DateTime.utc(2025, 1, 1),
          updatedAt: DateTime.utc(2025, 1, 1),
          fileVersion: kFileVersion,
        ),
      );
      final thumbnail = Uint8List.fromList([9, 8, 7]);

      final template = data.createTemplate(
        name: 'Template Name',
        description: 'Template Description',
        directory: 'templates',
        thumbnail: thumbnail,
      );

      final metadata = template.getMetadata();
      expect(metadata, isNotNull);
      expect(metadata!.type, NoteFileType.template);
      expect(metadata.name, 'Template Name');
      expect(metadata.description, 'Template Description');
      expect(metadata.directory, 'templates');
      expect(template.getThumbnail(), equals(thumbnail));
    });

    test('createDocument with disablePages removes all pages', () {
      var data = NoteData(Archive());
      (data, _) = data.setPage(_pageWithLayer('one'), 'Page 1');
      (data, _) = data.setPage(_pageWithLayer('two'), 'Page 2');

      final createdAt = DateTime.utc(2026, 4, 8);
      final document = data.createDocument(
        name: 'Doc Name',
        createdAt: createdAt,
        disablePages: true,
      );

      final metadata = document.getMetadata();
      expect(metadata, isNotNull);
      expect(metadata!.type, NoteFileType.document);
      expect(metadata.name, 'Doc Name');
      expect(metadata.createdAt!.isAtSameMomentAs(createdAt), isTrue);
      expect(document.getPages(), isEmpty);
    });
  });

  group('NoteData assets', () {
    test('getValidAssets returns usable full paths for text export', () {
      var data = NoteData(Archive());
      final bytes = Uint8List.fromList([1, 2, 3, 4]);
      (data, _) = data.importImage(bytes, 'png');

      final assets = data.getValidAssets().toList();
      expect(assets.length, 1);
      expect(assets.first, startsWith('$kImagesArchiveDirectory/'));

      final textData = data.exportAsText();
      final exportedAssets = textData['assets'] as Map<String, dynamic>?;
      expect(exportedAssets, isNotNull);
      expect(exportedAssets!.length, 1);
      expect(
        exportedAssets.keys.first,
        startsWith('$kImagesArchiveDirectory/'),
      );
    });

    test('getAllAssets contains imported image and pdf entries', () {
      var data = NoteData(Archive());
      final imageBytes = Uint8List.fromList([1, 2, 3]);
      final pdfBytes = Uint8List.fromList([4, 5, 6]);
      final (withImage, imagePath) = data.importImage(imageBytes, 'png');
      data = withImage;
      final (withPdf, pdfPath) = data.importPdf(pdfBytes);
      data = withPdf;

      final assets = data.getAllAssets();
      expect(assets.keys, contains(imagePath));
      expect(assets.keys, contains(pdfPath));
      expect(assets[imagePath], equals(imageBytes));
      expect(assets[pdfPath], equals(pdfBytes));
    });

    test('getAllAssets contains imported texture entries', () {
      var data = NoteData(Archive());
      final textureBytes = Uint8List.fromList([8, 9, 10]);
      final (withTexture, texturePath) = data.importTexture(
        textureBytes,
        'png',
      );
      data = withTexture;

      final assets = data.getAllAssets();
      expect(texturePath, startsWith('$kTexturesArchiveDirectory/'));
      expect(assets.keys, contains(texturePath));
      expect(assets[texturePath], equals(textureBytes));
      expect(data.containsTexture(textureBytes, 'png'), isTrue);
    });

    test('importImage reuses existing asset path for identical content', () {
      var data = NoteData(Archive());
      final bytes = Uint8List.fromList([7, 7, 7, 7]);

      final (firstData, firstPath) = data.importImage(bytes, 'png');
      data = firstData;
      final (secondData, secondPath) = data.importImage(bytes, 'png');
      data = secondData;

      expect(firstPath, secondPath);
      expect(data.getAllAssets().length, 1);
      expect(data.containsImage(bytes, 'png'), isTrue);
    });
  });

  group('NoteData parent packs', () {
    test('pack assets fall back to parent pack', () {
      var parent = NoteData(Archive())
          .setPalette('parent', const ColorPalette(colors: [SRGBColor.black]))
          .setPalette('shared', const ColorPalette(colors: [SRGBColor.red]));
      final child = NoteData(
        Archive(),
        parent: parent,
      ).setPalette('child', const ColorPalette(colors: [SRGBColor.white]));

      expect(child.getPalettes(), containsAll(['parent', 'shared', 'child']));
      expect(child.getPalette('parent')?.colors, [SRGBColor.black]);
      expect(child.getPalette('child')?.colors, [SRGBColor.white]);
    });

    test('tool preset override only applies when the type matches parent', () {
      var parent = NoteData(Archive())
          .setToolPreset('matching', Tool.pen(name: 'parent pen'))
          .setToolPreset('different', Tool.eraser(name: 'parent eraser'));
      var child = NoteData(Archive(), parent: parent)
          .setToolPreset('matching', Tool.pen(name: 'child pen'))
          .setToolPreset('different', Tool.pen(name: 'child pen'));

      expect(child.getToolPreset('matching'), isA<PenTool>());
      expect(child.getToolPreset('matching')?.name, 'child pen');
      expect(child.getToolPreset('different'), isA<EraserTool>());
      expect(child.getToolPreset('different')?.name, 'parent eraser');
    });
  });

  group('ElementPaint migration', () {
    test('file version 12 colors migrate to explicit paint fields', () {
      var data = NoteData(Archive());
      data = data.setMetadata(
        FileMetadata(
          type: NoteFileType.document,
          fileVersion: 12,
          name: 'Legacy paint',
        ),
      );
      data = data.setAsset(
        '$kPagesArchiveDirectory/0.Legacy.json',
        utf8.encode(
          jsonEncode({
            'layers': [
              {
                'id': 'layer',
                'content': [
                  {
                    'type': 'pen',
                    'property': {
                      'type': 'pen',
                      'color': 0xFFFF0000,
                      'fill': 0x8000FF00,
                    },
                  },
                  {
                    'type': 'shape',
                    'property': {
                      'type': 'shape',
                      'color': 0xFF111111,
                      'shape': {'type': 'circle', 'fillColor': 0xFF0000FF},
                    },
                  },
                ],
              },
            ],
          }),
        ),
      );

      final migrated = NoteData.fromArchive(data.export());
      final page = migrated.getPage('Legacy')!;
      final pen = page.content[0] as PenElement;
      final shape = page.content[1] as ShapeElement;

      expect(
        pen.property.paint,
        ElementPaint.solid(color: SRGBColor(0xFFFF0000)),
      );
      expect(
        pen.property.fillPaint,
        ElementPaint.solid(color: SRGBColor(0x8000FF00)),
      );
      expect(
        shape.property.paint,
        ElementPaint.solid(color: SRGBColor(0xFF111111)),
      );
      expect(
        (shape.property.shape as CircleShape).fillPaint,
        ElementPaint.solid(color: SRGBColor(0xFF0000FF)),
      );
    });
  });
}
