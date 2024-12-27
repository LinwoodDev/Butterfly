import 'package:butterfly_api/src/converter/color.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'view.freezed.dart';
part 'view.g.dart';

@freezed
sealed class ViewOption with _$ViewOption {
  const factory ViewOption({
    @Default(SRGBColor.black) @ColorJsonConverter() SRGBColor gridColor,
    @Default(20) double gridXSize,
    @Default(20) double gridYSize,
  }) = _ViewOption;

  factory ViewOption.fromJson(Map<String, dynamic> json) =>
      _$ViewOptionFromJson(json);
}
