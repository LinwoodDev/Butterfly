import 'package:freezed_annotation/freezed_annotation.dart';

part 'export.freezed.dart';
part 'export.g.dart';

@freezed
class ExportPreset with _$ExportPreset {
  const factory ExportPreset({
    @Default('') String name,
    @Default([]) List<String> areas,
    @Default(1) double quality,
  }) = _ExportPreset;

  factory ExportPreset.fromJson(Map<String, dynamic> json) =>
      _$ExportPresetFromJson(json);
}
