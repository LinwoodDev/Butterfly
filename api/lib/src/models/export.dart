import 'package:freezed_annotation/freezed_annotation.dart';

import 'area.dart';

part 'export.freezed.dart';
part 'export.g.dart';

@freezed
@JsonSerializable()
class const ExportPadding({
  final double top = 0,
  final double right = 0,
  final double bottom = 0,
  final double left = 0,
}) with _$ExportPadding {
  static ExportPadding fromJson(Map json) =>
      _$ExportPaddingFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$ExportPaddingToJson(this);
}

@freezed
sealed class ExportOptions with _$ExportOptions {
  const ExportOptions._();

  const factory ExportOptions.image({
    required double width,
    required double height,
    @Default(0) double x,
    @Default(0) double y,
    @Default(1) double scale,
    @Default(0) double rotation,
    @Default(ExportPadding()) ExportPadding padding,
    @Default(1) double quality,
    @Default(true) bool renderBackground,
  }) = ImageExportOptions;

  const factory ExportOptions.svg({
    required double width,
    required double height,
    @Default(0) double x,
    @Default(0) double y,
    @Default(1) double scale,
    @Default(0) double rotation,
    @Default(ExportPadding()) ExportPadding padding,
    @Default(true) bool renderBackground,
  }) = SvgExportOptions;

  factory ExportOptions.fromJson(Map<String, dynamic> json) =>
      _$ExportOptionsFromJson(json);

  ImageExportOptions toImageOptions() => switch (this) {
    ImageExportOptions e => e,
    SvgExportOptions e => ImageExportOptions(
      width: e.width,
      height: e.height,
      x: e.x,
      y: e.y,
      scale: e.scale,
      rotation: e.rotation,
      padding: e.padding,
      renderBackground: e.renderBackground,
    ),
  };
}

@freezed
sealed class ExportPreset with _$ExportPreset {
  const factory ExportPreset({
    @Default('') String name,
    @Default([]) List<AreaPreset> areas,
  }) = _ExportPreset;

  factory ExportPreset.fromJson(Map<String, dynamic> json) =>
      _$ExportPresetFromJson(json);
}

@freezed
@JsonSerializable()
class const AreaPreset({
  final String page = '',
  final String name = '',
  final double quality = 1,
  final Area? area,
}) with _$AreaPreset {
  static AreaPreset fromJson(Map json) =>
      _$AreaPresetFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$AreaPresetToJson(this);
}
