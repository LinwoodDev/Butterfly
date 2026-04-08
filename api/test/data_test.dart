import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:test/test.dart';

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
  });
}
