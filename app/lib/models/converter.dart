import 'package:butterfly/models/document.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DocumentJsonConverter
    extends JsonConverter<AppDocument, Map<String, dynamic>> {
  const DocumentJsonConverter();

  @override
  AppDocument fromJson(Map<String, dynamic> json) {
    return AppDocument.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(AppDocument object) {
    return object.toJson();
  }
}
