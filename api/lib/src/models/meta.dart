import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../converter/core.dart';

part 'meta.freezed.dart';
part 'meta.g.dart';

const kFileVersion = 13;
const kBreakingChangesVersion = 7;
const templateDateFormatExample = '{date:dd.MM.yyyy}';
const templateTimeFormatExample = '{time:HH-mm}';
final _templateDateTimePattern = RegExp(r'\{(?:date|time):([^{}]+)\}');

/// Resolves the supported placeholders in a template's document file name.
///
/// Each placeholder contains an ICU date format, for example
/// `{date:dd.MM.yyyy}` or `{time:HH-mm}`. The caller remains responsible for
/// validating that the formatted result is a valid file name.
String resolveTemplateFileName(String pattern, DateTime dateTime) {
  final resolved = pattern.replaceAllMapped(_templateDateTimePattern, (match) {
    final format = match.group(1)!;
    return DateFormat(format).format(dateTime);
  });
  if (resolved.contains('{date:') || resolved.contains('{time:')) {
    throw FormatException('Invalid template date or time formatter', pattern);
  }
  return resolved.trim();
}

@freezed
sealed class FileMetadata with _$FileMetadata {
  const factory FileMetadata({
    int? fileVersion,
    required NoteFileType type,
    @DateTimeJsonConverter() DateTime? createdAt,
    @DateTimeJsonConverter() DateTime? updatedAt,
    @Default('') String name,
    @Default('') String description,
    @Default('') String author,
    @Default('') String directory,
    @Default('') String fileName,
    @Default('') String version,
  }) = _FileMetadata;

  factory FileMetadata.fromJson(Map<String, dynamic> json) =>
      _$FileMetadataFromJson(json);
}

enum NoteFileType { document, template, pack }
