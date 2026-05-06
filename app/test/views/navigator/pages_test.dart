import 'package:butterfly/views/navigator/pages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('page navigator path helpers', () {
    test('shows nested page as file inside its folder', () {
      final pages = [('folder/page', '0.folder/page')];

      expect(buildPageEntitiesForLocation(pages, ''), [
        (path: 'folder', name: 'folder', isFile: false),
      ]);
      expect(buildPageEntitiesForLocation(pages, 'folder'), [
        (path: '0.folder/page', name: 'page', isFile: true),
      ]);
    });

    test('shows only the next folder level for deeper pages', () {
      final pages = [
        (
          'section/subsection/chapter/page',
          '0.section/subsection/chapter/page',
        ),
      ];

      expect(buildPageEntitiesForLocation(pages, 'section'), [
        (path: 'section/subsection', name: 'subsection', isFile: false),
      ]);
    });

    test('resolves leaf renames relative to the current folder', () {
      expect(resolvePageRename('', 'folder/page'), 'folder/page');
      expect(resolvePageRename('folder', 'renamed'), 'folder/renamed');
      expect(
        resolvePageRename('folder', 'subfolder/renamed'),
        'folder/subfolder/renamed',
      );
    });

    test('resolves absolute and parent renames out of the current folder', () {
      expect(resolvePageRename('folder/', '/renamed/'), 'renamed');
      expect(resolvePageRename('folder', '../renamed'), 'renamed');
      expect(
        resolvePageRename('section/subsection', '../renamed'),
        'section/renamed',
      );
      expect(
        resolvePageRename('section/subsection', '../../renamed'),
        'renamed',
      );
    });
  });
}
