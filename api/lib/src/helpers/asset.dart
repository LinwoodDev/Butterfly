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
      };

  List<String> getFileExtensions() => switch (this) {
        AssetFileType.note => ['bfly'],
        AssetFileType.image => ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'ico'],
        AssetFileType.pdf => ['pdf'],
        AssetFileType.svg => ['svg'],
        AssetFileType.markdown => ['md', 'markdown'],
        AssetFileType.page => [],
        AssetFileType.xopp => ['xopp'],
      };

  String getMime() => switch (this) {
        AssetFileType.note => 'application/zip',
        AssetFileType.image => 'image/*',
        AssetFileType.markdown => 'text/markdown',
        AssetFileType.pdf => 'application/pdf',
        AssetFileType.svg => 'image/svg+xml',
        AssetFileType.page => 'application/json',
        AssetFileType.xopp => 'application/zip',
      };

  bool isMimeType(String mimeType) {
    final mime = getMime();
    return RegExp(mime).hasMatch(mime);
  }

  static AssetFileType? fromFileExtension(String? ext) {
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
