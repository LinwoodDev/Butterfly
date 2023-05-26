import 'dart:math';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tool.g.dart';
part 'tool.freezed.dart';

@freezed
class ToolState with _$ToolState {
  const factory ToolState({
    @Default(false) bool rulerEnabled,
    @Default(false) bool gridEnabled,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> rulerPosition,
    @Default(0) double rulerAngle,
  }) = _ToolState;

  factory ToolState.fromJson(Map<String, dynamic> json) =>
      _$ToolStateFromJson(json);
}
