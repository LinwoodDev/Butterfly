import 'package:freezed_annotation/freezed_annotation.dart';

import '../converter/core.dart';

part 'meta.freezed.dart';
part 'meta.g.dart';

const kFileVersion = 8;
const kBreakingChangesVersion = 7;

@freezed
class FileMetadata with _$FileMetadata {
  const factory FileMetadata({
    int? fileVersion,
    required NoteFileType type,
    @DateTimeJsonConverter() DateTime? createdAt,
    @DateTimeJsonConverter() DateTime? updatedAt,
    @Default('') String name,
    @Default('') String description,
    @Default('') String author,
    @Default('') String directory,
    @Default('') String version,
  }) = _FileMetadata;

  factory FileMetadata.fromJson(Map<String, dynamic> json) =>
      _$FileMetadataFromJson(json);
}

enum NoteFileType {
  document,
  template,
  pack,
}
