import 'package:butterfly_api/src/converter/color.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors.dart';

part 'texture.g.dart';
part 'texture.freezed.dart';

enum PatternTemplate {
  plain,
  ruled,
  quad,
  music,
  plainDark,
  ruledDark,
  quadDark,
  musicDark,
}

extension PatternTemplateExtension on PatternTemplate {
  // camelCase to snake_case
  String get asset =>
      'templates/${name.replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match.group(1)?.toLowerCase()}')}.png';

  bool get dark => [
    PatternTemplate.plainDark,
    PatternTemplate.ruledDark,
    PatternTemplate.quadDark,
    PatternTemplate.musicDark,
  ].contains(this);

  PatternTexture create() {
    switch (this) {
      case PatternTemplate.plain:
        return const PatternTexture(boxColor: BasicColors.light);
      case PatternTemplate.ruled:
        return const PatternTexture(boxColor: BasicColors.light, boxHeight: 40);
      case PatternTemplate.quad:
        return const PatternTexture(
          boxColor: BasicColors.light,
          boxHeight: 40,
          boxWidth: 40,
        );
      case PatternTemplate.music:
        return const PatternTexture(
          boxColor: BasicColors.light,
          boxHeight: 40,
          boxYColor: SRGBColor.black,
          boxYSpace: 80,
          boxYCount: 5,
        );
      case PatternTemplate.plainDark:
        return const PatternTexture(boxColor: BasicColors.dark);
      case PatternTemplate.ruledDark:
        return const PatternTexture(boxColor: BasicColors.dark, boxHeight: 40);
      case PatternTemplate.quadDark:
        return const PatternTexture(
          boxColor: BasicColors.dark,
          boxWidth: 40,
          boxHeight: 40,
        );
      case PatternTemplate.musicDark:
        return const PatternTexture(
          boxColor: BasicColors.dark,
          boxYColor: SRGBColor.white,
          boxHeight: 40,
          boxYSpace: 80,
          boxYCount: 5,
        );
    }
  }
}

@freezed
sealed class SurfaceTexture with _$SurfaceTexture {
  const factory SurfaceTexture.pattern({
    @Default(0) double boxWidth,
    @Default(0) double boxHeight,
    @Default(1) int boxXCount,
    @Default(1) int boxYCount,
    @Default(0) double boxXSpace,
    @Default(0) double boxYSpace,
    @Default(BasicColors.blue) @ColorJsonConverter() SRGBColor boxXColor,
    @Default(BasicColors.red) @ColorJsonConverter() SRGBColor boxYColor,
    @Default(SRGBColor.white) @ColorJsonConverter() SRGBColor boxColor,
    @Default(0.5) double boxXStroke,
    @Default(0.5) double boxYStroke,
  }) = PatternTexture;

  factory SurfaceTexture.fromJson(Map<String, dynamic> json) =>
      _$SurfaceTextureFromJson(json);
}
