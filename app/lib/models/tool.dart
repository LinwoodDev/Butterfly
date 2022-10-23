import 'dart:ui';

import 'package:butterfly/models/converter.dart';
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

@freezed
class ToolState with _$ToolState {
  const factory ToolState({
    @Default(false) bool rulerEnabled,
    @Default(false) bool gridEnabled,
    @Default(Offset.zero) @OffsetJsonConverter() Offset rulerPosition,
    @Default(0) double rulerAngle,
  }) = _ToolState;

  factory ToolState.fromJson(Map<String, dynamic> json) =>
      _$ToolStateFromJson(json);
}
