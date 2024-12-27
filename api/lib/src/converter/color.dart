import 'package:dart_leap/dart_leap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ColorJsonConverter extends JsonConverter<SRGBColor, int> {
  const ColorJsonConverter();

  @override
  SRGBColor fromJson(int json) {
    return SRGBColor(json);
  }

  @override
  int toJson(SRGBColor object) {
    return object.value;
  }
}
