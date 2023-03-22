import 'document.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'converter.dart';

part 'template.g.dart';
part 'template.freezed.dart';

// 16:9
const kThumbnailWidth = 640;
const kThumbnailHeight = 360;

@freezed
class DocumentTemplate with _$DocumentTemplate {
  String get name => document.name;
  String get description => document.description;

  const DocumentTemplate._();

  const factory DocumentTemplate(
      {@DocumentJsonConverter() required AppDocument document,
      @Default('') String thumbnail,
      @Default('/') String folder}) = _DocumentTemplate;

  factory DocumentTemplate.fromJson(Map<String, dynamic> json) =>
      _$DocumentTemplateFromJson(json);
}
