import 'package:freezed_annotation/freezed_annotation.dart';

import '../converter/core.dart';

part 'meta.freezed.dart';
part 'meta.g.dart';

@freezed
class FileMetadata with _$FileMetadata {
  const factory FileMetadata({
    required int version,
    required NoteFileType type,
    @DateTimeJsonConverter() required DateTime createdAt,
    @DateTimeJsonConverter() DateTime? updatedAt,
    @Default('') String name,
    @Default('') String description,
    @Default('') String directory,
  }) = _FileMetadata;

  factory FileMetadata.fromJson(Map<String, dynamic> json) =>
      _$FileMetadataFromJson(json);
}

enum NoteFileType {
  document,
  template,
  pack,
}
