import 'package:collection/collection.dart';

import '../models/asset.dart';

extension AssetFileTypeHelper on AssetFileType {
  List<String> getUniformTypeIdentifiers() => switch (this) {
    AssetFileType.note => ['dev.linwood.butterfly.note'],
    AssetFileType.image => ['public.image'],
    AssetFileType.pdf => ['com.adobe.pdf'],
    AssetFileType.svg => ['public.svg-image'],
    AssetFileType.markdown => ['public.plain-text'],
    AssetFileType.page => [],
    AssetFileType.xopp => ['dev.linwood.butterfly.xopp'],
    AssetFileType.archive => ['public.archive'],
  };

  List<String> getFileExtensions() => switch (this) {
    AssetFileType.note => ['bfly'],
    AssetFileType.image => ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'ico'],
    AssetFileType.pdf => ['pdf'],
    AssetFileType.svg => ['svg'],
    AssetFileType.markdown => ['md', 'markdown'],
    AssetFileType.page => [],
    AssetFileType.xopp => ['xopp'],
    AssetFileType.archive => ['zip'],
  };

  List<String> getMimeTypes() => switch (this) {
    AssetFileType.note => [
      'application/x-butterfly',
      'application/octet-stream',
      'application/zip',
    ],
    AssetFileType.image => ['image/*'],
    AssetFileType.markdown => ['text/markdown'],
    AssetFileType.pdf => ['application/pdf'],
    AssetFileType.svg => ['image/svg+xml'],
    AssetFileType.page => ['application/json'],
    AssetFileType.xopp => ['application/zip'],
    AssetFileType.archive => [
      'application/zip',
      'application/x-tar',
      'application/x-gzip',
      'application/x-bzip2',
      'application/x-7z-compressed',
    ],
  };

  bool isMimeType(String mimeType) {
    final mime = getMimeTypes();
    return mime.any((m) {
      return RegExp(m).hasMatch(mimeType);
    });
  }

  static AssetFileType? fromFileExtension(String? ext) {
    if (ext?.startsWith('.') ?? false) {
      ext = ext?.substring(1);
    }
    return AssetFileType.values.firstWhereOrNull(
      (type) => type.getFileExtensions().contains(ext),
    );
  }

  static AssetFileType? fromMime(String mime) {
    return AssetFileType.values.firstWhereOrNull(
      (type) => type.isMimeType(mime),
    );
  }
}
