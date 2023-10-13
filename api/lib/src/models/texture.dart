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
  musicDark
}

extension PatternTemplateExtension on PatternTemplate {
  // camelCase to snake_case
  String get asset =>
      'templates/${name.replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match.group(1)?.toLowerCase()}')}.png';

  bool get dark => [
        PatternTemplate.plainDark,
        PatternTemplate.ruledDark,
        PatternTemplate.quadDark,
        PatternTemplate.musicDark
      ].contains(this);

  PatternTexture create() {
    switch (this) {
      case PatternTemplate.plain:
        return const PatternTexture(
          boxColor: kColorLight,
        );
      case PatternTemplate.ruled:
        return const PatternTexture(
          boxColor: kColorLight,
          boxHeight: 40,
        );
      case PatternTemplate.quad:
        return const PatternTexture(
          boxColor: kColorLight,
          boxHeight: 40,
          boxWidth: 40,
        );
      case PatternTemplate.music:
        return const PatternTexture(
            boxColor: kColorLight,
            boxHeight: 40,
            boxYColor: kColorBlack,
            boxYSpace: 80,
            boxYCount: 5);
      case PatternTemplate.plainDark:
        return const PatternTexture(
          boxColor: kColorDark,
        );
      case PatternTemplate.ruledDark:
        return const PatternTexture(boxColor: kColorDark, boxHeight: 40);
      case PatternTemplate.quadDark:
        return const PatternTexture(
          boxColor: kColorDark,
          boxWidth: 40,
          boxHeight: 40,
        );
      case PatternTemplate.musicDark:
        return const PatternTexture(
            boxColor: kColorDark,
            boxYColor: kColorWhite,
            boxHeight: 40,
            boxYSpace: 80,
            boxYCount: 5);
    }
  }
}

@freezed
sealed class SurfaceTexture with _$SurfaceTexture {
  const factory SurfaceTexture.pattern(
      {@Default(0) double boxWidth,
      @Default(0) double boxHeight,
      @Default(1) int boxXCount,
      @Default(1) int boxYCount,
      @Default(0) double boxXSpace,
      @Default(0) double boxYSpace,
      @Default(kColorBlue) int boxXColor,
      @Default(kColorRed) int boxYColor,
      @Default(kColorWhite) int boxColor,
      @Default(0.5) double boxXStroke,
      @Default(0.5) double boxYStroke}) = PatternTexture;

  factory SurfaceTexture.fromJson(Map<String, dynamic> json) =>
      _$SurfaceTextureFromJson(json);
}
