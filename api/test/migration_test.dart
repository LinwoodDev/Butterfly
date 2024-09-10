import 'dart:io';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:test/test.dart';

void main() {
  group('Document migration', () {
    test('Migrate from v1', () async {
      final bytes = await File('test/assets/document_v1.bfly').readAsBytes();
      final data = NoteData.fromData(bytes);
      expect(data.getPages().length, 1);

      final page = data.getPage();
      expect(page, isNotNull);
      expect(page!.content.length, 2);
      expect(page.content[0], isA<PathElement>());
      expect(page.content[1], isA<ShapeElement>());

      final info = data.getInfo();
      expect(info, isNotNull);
      expect(info!.tools.length, 10);
      expect(info.tools[0], isA<SelectTool>());
      expect(info.tools[1], isA<PenTool>());
      expect(info.tools[2], isA<PathEraserTool>());
      expect(info.tools[3], isA<UndoTool>());
      expect(info.tools[4], isA<RedoTool>());
      expect(info.tools[5], isA<AreaTool>());
      expect(info.tools[6], isA<CollectionTool>());
      expect(info.tools[7], isA<ShapeTool>());
      expect(info.tools[8], isA<StampTool>());
      expect(info.tools[9], isA<LaserTool>());
    });
  });
}
