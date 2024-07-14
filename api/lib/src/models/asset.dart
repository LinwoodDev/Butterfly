import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:lw_file_system_api/lw_file_system_api.dart';

enum AssetFileType { note, page, image, markdown, pdf, svg, xopp, archive }

extension AppDocumentLoadExtension on FileSystemFile {
  NoteData load({bool disableMigrations = false}) =>
      NoteData.fromData(Uint8List.fromList(data),
          disableMigrations: disableMigrations);
}
