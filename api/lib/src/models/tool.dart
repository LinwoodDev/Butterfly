import 'package:freezed_annotation/freezed_annotation.dart';

part 'tool.freezed.dart';
part 'tool.g.dart';

@freezed
class ToolOption with _$ToolOption {
  const factory ToolOption({
    @Default(0) int gridColor,
    @Default(20) double gridXSize,
    @Default(20) double gridYSize,
  }) = _ToolOption;

  factory ToolOption.fromJson(Map<String, dynamic> json) =>
      _$ToolOptionFromJson(json);
}
