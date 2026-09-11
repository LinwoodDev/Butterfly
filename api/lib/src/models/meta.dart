import 'package:freezed_annotation/freezed_annotation.dart';

import '../converter/core.dart';

part 'meta.freezed.dart';
part 'meta.g.dart';

const kFileVersion = 13;
const kBreakingChangesVersion = 7;

@freezed
@JsonSerializable()
class const FileMetadata({
  final int? fileVersion,
  required final NoteFileType type,
  @DateTimeJsonConverter() final DateTime? createdAt,
  @DateTimeJsonConverter() final DateTime? updatedAt,
  final String name = '',
  final String description = '',
  final String author = '',
  final String directory = '',
  final String fileName = '',
  final String version = '',
}) with _$FileMetadata {
  static FileMetadata fromJson(Map json) =>
      _$FileMetadataFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$FileMetadataToJson(this);
}

enum NoteFileType { document, template, pack }
