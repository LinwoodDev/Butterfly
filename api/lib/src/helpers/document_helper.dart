import '../models/document.dart';
import 'package:collection/collection.dart';

extension AssetFileTypeHelper on AssetFileType {
  List<String> getFileExtensions() {
    switch (this) {
      case AssetFileType.note:
        return ['bfly', 'json'];
      case AssetFileType.image:
        return ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'ico'];
      case AssetFileType.pdf:
        return ['pdf'];
      case AssetFileType.svg:
        return ['svg'];
    }
  }

  String getMime() {
    switch (this) {
      case AssetFileType.note:
        return 'application/json';
      case AssetFileType.image:
        return 'image/*';
      case AssetFileType.pdf:
        return 'application/pdf';
      case AssetFileType.svg:
        return 'image/svg+xml';
    }
  }

  bool isMimeType(String mimeType) {
    final mime = getMime();
    if (mime == 'image/*') {
      return mimeType.startsWith('image/');
    }
    return mimeType == mime;
  }

  static AssetFileType? fromFileExtension(String ext) {
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
