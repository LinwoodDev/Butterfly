import 'package:butterfly/api/file_system_io.dart';
import 'package:butterfly/api/file_system_web.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:flutter/foundation.dart';

abstract class DocumentFileSystem {
  Future<List<AppDocumentFile>> getDocuments();

  Future<AppDocumentFile?> getDocument(String path);

  Future<AppDocumentFile> createDocument(String name,
          {List<ColorPalette> palettes = const []}) =>
      importDocument(AppDocument(
          name: name, palettes: palettes, createdAt: DateTime.now()));

  Future<bool> hasDocument(String name);

  Future<AppDocumentFile> updateDocument(String path, AppDocument document);

  Future<void> deleteDocument(String path);

  Future<AppDocumentFile> importDocument(AppDocument document);

  static DocumentFileSystem fromPlatform() {
    if (kIsWeb) {
      return WebDocumentFileSystem();
    } else {
      return IODocumentFileSystem();
    }
  }
}
