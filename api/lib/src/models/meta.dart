import 'package:freezed_annotation/freezed_annotation.dart';

import '../converter/core.dart';

part 'meta.freezed.dart';
part 'meta.g.dart';

const kFileVersion = 13;
const kBreakingChangesVersion = 7;

@freezed
@JsonSerializable()
class FileMetadata with _$FileMetadata {
  const new({
    this.fileVersion,
    required this.type,
    this.createdAt,
    this.updatedAt,
    this.name = '',
    this.description = '',
    this.author = '',
    this.directory = '',
    this.fileName = '',
    this.version = '',
  });

  final int? fileVersion;
  final NoteFileType type;
  @DateTimeJsonConverter()
  final DateTime? createdAt;
  @DateTimeJsonConverter()
  final DateTime? updatedAt;
  final String name;
  final String description;
  final String author;
  final String directory;
  final String fileName;
  final String version;

  factory FileMetadata.fromJson(Map<String, dynamic> json) =>
      _$FileMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$FileMetadataToJson(this);
}

enum NoteFileType { document, template, pack }
