import 'package:freezed_annotation/freezed_annotation.dart';

part 'palette.g.dart';
part 'palette.freezed.dart';

@freezed
class ColorPalette with _$ColorPalette {
  const factory ColorPalette(
      {required String name, @Default([]) List<int> colors}) = _ColorPalette;
  factory ColorPalette.fromJson(Map<String, dynamic> json) =>
      _$ColorPaletteFromJson(json);
}
