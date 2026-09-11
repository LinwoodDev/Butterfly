import 'package:dart_leap/dart_leap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class const ColorJsonConverter() extends JsonConverter<SRGBColor, int> {
  @override
  SRGBColor fromJson(int json) {
    return .new(json);
  }

  @override
  int toJson(SRGBColor object) {
    return object.value;
  }
}
