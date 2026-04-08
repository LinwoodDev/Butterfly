import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:test/test.dart';

DocumentPage _pageWithLayer(String layerId) =>
    DocumentPage(layers: [DocumentLayer(id: layerId)]);

void main() {
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
}
