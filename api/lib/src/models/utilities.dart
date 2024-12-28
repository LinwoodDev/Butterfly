import 'package:freezed_annotation/freezed_annotation.dart';

part 'utilities.g.dart';
part 'utilities.freezed.dart';

@freezed
sealed class UtilitiesState with _$UtilitiesState {
  const factory UtilitiesState({
    @Default(false) bool lockCollection,
    @Default(false) bool lockZoom,
    @Default(false) bool lockHorizontal,
    @Default(false) bool lockVertical,
    @Default(false) bool fullSelection,
  }) = _UtilitiesState;

  factory UtilitiesState.fromJson(Map<String, dynamic> json) =>
      _$UtilitiesStateFromJson(json);
}
