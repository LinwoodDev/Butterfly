import 'package:freezed_annotation/freezed_annotation.dart';

part 'export.freezed.dart';
part 'export.g.dart';

@freezed
class ExportPreset with _$ExportPreset {
  const factory ExportPreset({
    @Default('') String name,
    @Default([]) List<AreaPreset> areas,
  }) = _ExportPreset;

  factory ExportPreset.fromJson(Map<String, dynamic> json) =>
      _$ExportPresetFromJson(json);
}

@freezed
class AreaPreset with _$AreaPreset {
  const factory AreaPreset({
    @Default('') String name,
    @Default(1) double quality,
  }) = _AreaPreset;

  factory AreaPreset.fromJson(Map<String, dynamic> json) =>
      _$AreaPresetFromJson(json);
}
