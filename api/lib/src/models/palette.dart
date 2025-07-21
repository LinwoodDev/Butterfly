import 'package:butterfly_api/src/converter/color.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'palette.g.dart';
part 'palette.freezed.dart';

@freezed
sealed class ColorPalette with _$ColorPalette {
  const factory ColorPalette({
    required String name,
    @Default([]) @ColorJsonConverter() List<SRGBColor> colors,
  }) = _ColorPalette;
  factory ColorPalette.fromJson(Map<String, dynamic> json) =>
      _$ColorPaletteFromJson(json);
}
