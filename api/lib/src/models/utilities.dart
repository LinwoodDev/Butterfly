import 'package:freezed_annotation/freezed_annotation.dart';

part 'utilities.freezed.dart';
part 'utilities.g.dart';

@freezed
@JsonSerializable()
final class UtilitiesState with _$UtilitiesState {
  @override
  final bool lockCollection,
      lockLayer,
      lockZoom,
      lockHorizontal,
      lockVertical,
      fullSelection;

  const UtilitiesState({
    this.lockCollection = false,
    this.lockLayer = false,
    this.lockZoom = false,
    this.lockHorizontal = false,
    this.lockVertical = false,
    this.fullSelection = false,
  });

  factory UtilitiesState.fromJson(Map<String, dynamic> json) =>
      _$UtilitiesStateFromJson(json);

  Map<String, Object?> toJson() => _$UtilitiesStateToJson(this);
}
