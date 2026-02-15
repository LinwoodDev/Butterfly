import 'package:butterfly_api/src/converter/color.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors.dart';

part 'texture.g.dart';
part 'texture.freezed.dart';

enum PatternBackground { light, dark }

enum PatternTemplate {
  plain,
  plainDark,
  ruled,
  ruledDark,
  ruledSimple,
  ruledSimpleDark,
  quad,
  quadDark,
  quadSimple,
  quadSimpleDark,
  music,
  musicDark,
  dotted,
  dottedDark,
}

const templateDirectory = 'templates/';

extension PatternTemplateExtension on PatternTemplate {
  // camelCase to snake_case
  String get asset => '$templateDirectory$assetName';
  String get assetName =>
      '${name.replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match.group(1)?.toLowerCase()}')}.png';

  PatternBackground get background => switch (this) {
    PatternTemplate.plain ||
    PatternTemplate.ruled ||
    PatternTemplate.ruledSimple ||
    PatternTemplate.quad ||
    PatternTemplate.quadSimple ||
    PatternTemplate.music ||
    PatternTemplate.dotted => PatternBackground.light,
    PatternTemplate.plainDark ||
    PatternTemplate.ruledDark ||
    PatternTemplate.ruledSimpleDark ||
    PatternTemplate.quadDark ||
    PatternTemplate.quadSimpleDark ||
    PatternTemplate.musicDark ||
    PatternTemplate.dottedDark => PatternBackground.dark,
  };

  PatternTexture create() {
    switch (this) {
      case PatternTemplate.plain:
        return const PatternTexture(boxColor: SRGBColor.white);
      case PatternTemplate.ruled:
        return const PatternTexture(boxColor: SRGBColor.white, boxHeight: 40);
      case PatternTemplate.ruledSimple:
        return const PatternTexture(
          boxColor: SRGBColor.white,
          boxHeight: 40,
          boxXColor: BasicColors.dark,
          boxYColor: BasicColors.dark,
        );
      case PatternTemplate.quad:
        return const PatternTexture(
          boxColor: SRGBColor.white,
          boxHeight: 40,
          boxWidth: 40,
        );
      case PatternTemplate.quadSimple:
        return const PatternTexture(
          boxColor: SRGBColor.white,
          boxHeight: 40,
          boxWidth: 40,
          boxXColor: BasicColors.dark,
          boxYColor: BasicColors.dark,
        );
      case PatternTemplate.music:
        return const PatternTexture(
          boxColor: SRGBColor.white,
          boxHeight: 40,
          boxYColor: SRGBColor.black,
          boxYSpace: 80,
          boxYCount: 5,
        );
      case PatternTemplate.dotted:
        return const PatternTexture(
          boxColor: SRGBColor.white,
          boxWidth: 40,
          boxHeight: 40,
          boxXCount: 1,
          boxYCount: 2,
          boxXStroke: 5,
          boxYStroke: 35,
          boxXColor: BasicColors.light,
          boxYColor: SRGBColor.white,
        );
      case PatternTemplate.plainDark:
        return const PatternTexture(boxColor: SRGBColor.black);
      case PatternTemplate.ruledDark:
        return const PatternTexture(boxColor: SRGBColor.black, boxHeight: 40);
      case PatternTemplate.ruledSimpleDark:
        return const PatternTexture(
          boxColor: SRGBColor.black,
          boxHeight: 40,
          boxXColor: BasicColors.dark,
          boxYColor: BasicColors.dark,
        );
      case PatternTemplate.quadDark:
        return const PatternTexture(
          boxColor: SRGBColor.black,
          boxWidth: 40,
          boxHeight: 40,
        );
      case PatternTemplate.quadSimpleDark:
        return const PatternTexture(
          boxColor: SRGBColor.black,
          boxWidth: 40,
          boxHeight: 40,
          boxXColor: BasicColors.dark,
          boxYColor: BasicColors.dark,
        );
      case PatternTemplate.musicDark:
        return const PatternTexture(
          boxColor: SRGBColor.black,
          boxYColor: SRGBColor.white,
          boxHeight: 40,
          boxYSpace: 80,
          boxYCount: 5,
        );
      case PatternTemplate.dottedDark:
        return const PatternTexture(
          boxColor: SRGBColor.black,
          boxWidth: 40,
          boxHeight: 40,
          boxXCount: 1,
          boxYCount: 2,
          boxXStroke: 5,
          boxYStroke: 35,
          boxXColor: BasicColors.dark,
          boxYColor: SRGBColor.black,
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
