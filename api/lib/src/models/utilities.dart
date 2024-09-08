import 'dart:math';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'utilities.g.dart';
part 'utilities.freezed.dart';

@freezed
sealed class UtilitiesState with _$UtilitiesState {
  const factory UtilitiesState({
    @Default(false) bool lockLayer,
    @Default(false) bool lockZoom,
    @Default(false) bool lockHorizontal,
    @Default(false) bool lockVertical,
    @Default(false) bool rulerEnabled,
    @Default(false) bool gridEnabled,
    @Default(false) bool fullSelection,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> rulerPosition,
    @Default(0) double rulerAngle,
  }) = _UtilitiesState;

  factory UtilitiesState.fromJson(Map<String, dynamic> json) =>
      _$UtilitiesStateFromJson(json);
}
