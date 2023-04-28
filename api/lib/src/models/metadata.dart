import 'package:freezed_annotation/freezed_annotation.dart';

part 'metadata.freezed.dart';
part 'metadata.g.dart';

@freezed
class FileMetadata with _$FileMetadata {
  const factory FileMetadata({
    required int version,
    required NoteFileType type,
    @Default('') String name,
    @Default('') String description,
    @Default('') String thumbnail,
  }) = _FileMetadata;

  factory FileMetadata.fromJson(Map<String, dynamic> json) =>
      _$FileMetadataFromJson(json);
}

enum NoteFileType {
  document,
  template,
  pack,
}
