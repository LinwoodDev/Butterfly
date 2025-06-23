import 'package:butterfly_api/butterfly_api.dart';
import 'package:lw_file_system_api/lw_file_system_api.dart';

enum AssetFileType {
  note,
  textNote,
  page,
  image,
  markdown,
  pdf,
  svg,
  xopp,
  archive,
}

extension AssetLocationFileTypeExtension on AssetLocation {
  AssetFileType? get fileType =>
      AssetFileTypeHelper.fromFileExtension(fileExtension);
}
