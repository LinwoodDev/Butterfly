import 'package:collection/collection.dart';

import '../models/asset.dart';

extension AssetFileTypeHelper on AssetFileType {
  List<String> getUniformTypeIdentifiers() => switch (this) {
    .note => ['dev.linwood.butterfly.note'],
    .textNote => ['dev.linwood.butterfly.textnote'],
    .image => ['public.image'],
    .pdf => ['com.adobe.pdf'],
    .svg => ['public.svg-image'],
    .markdown => ['public.plain-text'],
    .page => [],
    .xopp => ['dev.linwood.butterfly.xopp'],
    .oneNote => ['com.microsoft.onenote.one'],
    .oneNotePackage => ['com.microsoft.onenote.onepkg'],
    .rawText => ['public.plain-text'],
    .archive => ['public.archive'],
  };

  List<String> getFileExtensions() => switch (this) {
    .note => ['bfly'],
    .textNote => ['tbfly'],
    .image => ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'ico', 'webp'],
    .pdf => ['pdf'],
    .svg => ['svg'],
    .markdown => ['md', 'markdown'],
    .page => [],
    .xopp => ['xopp'],
    .oneNote => ['one'],
    .oneNotePackage => ['onepkg'],
    .rawText => ['txt'],
    .archive => ['zip'],
  };

  List<String> getMimeTypes() => switch (this) {
    .note => [
      'application/x-butterfly',
      'application/octet-stream',
      'application/zip',
    ],
    .textNote => ['application/x-text-butterfly', 'application/json'],
    .image => [
      'image/png',
      'image/jpeg',
      'image/gif',
      'image/bmp',
      'image/x-icon',
      'image/webp',
    ],
    .markdown => ['text/markdown'],
    .pdf => ['application/pdf'],
    .svg => ['image/svg+xml'],
    .page => ['application/x-butterfly-page', 'application/json'],
    .xopp => ['application/zip'],
    .oneNote => [
      'application/onenote',
      'application/msonenote',
      'application/x-onenote',
    ],
    .oneNotePackage => [
      'application/onenote',
      'application/msonenote',
      'application/x-onenote',
    ],
    .archive => [
      'application/zip',
      'application/x-tar',
      'application/x-gzip',
      'application/x-bzip2',
      'application/x-7z-compressed',
    ],
    .rawText => ['text/plain'],
  };

  bool isMimeType(String mimeType) => getMimeTypes().contains(mimeType);

  bool isNote() => this == .note || this == .textNote;

  static AssetFileType? fromFileExtension(String? ext) {
    if (ext?.startsWith('.') ?? false) {
      ext = ext?.substring(1);
    }
    ext = ext?.toLowerCase();
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
