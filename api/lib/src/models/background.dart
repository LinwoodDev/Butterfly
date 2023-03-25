import 'colors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'background.g.dart';
part 'background.freezed.dart';

enum BackgroundTemplate {
  plain,
  ruled,
  quad,
  music,
  plainDark,
  ruledDark,
  quadDark,
  musicDark
}

extension BackgroundTemplateExtension on BackgroundTemplate {
  // camelCase to snake_case
  String get asset =>
      'templates/${name.replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match.group(1)?.toLowerCase()}')}.png';

  bool get dark => [
        BackgroundTemplate.plainDark,
        BackgroundTemplate.ruledDark,
        BackgroundTemplate.quadDark,
        BackgroundTemplate.musicDark
      ].contains(this);

  Background create() {
    switch (this) {
      case BackgroundTemplate.plain:
        return const Background.box(
          boxColor: kColorLight,
        );
      case BackgroundTemplate.ruled:
        return const Background.box(
          boxColor: kColorLight,
          boxHeight: 20,
        );
      case BackgroundTemplate.quad:
        return const Background.box(
          boxColor: kColorLight,
          boxHeight: 20,
          boxWidth: 20,
        );
      case BackgroundTemplate.music:
        return const BoxBackground(
            boxColor: kColorLight,
            boxHeight: 20,
            boxYColor: kColorBlack,
            boxYSpace: 30,
            boxYCount: 5);
      case BackgroundTemplate.plainDark:
        return const Background.box(
          boxColor: kColorDark,
        );
      case BackgroundTemplate.ruledDark:
        return const Background.box(boxColor: kColorDark, boxHeight: 20);
      case BackgroundTemplate.quadDark:
        return const Background.box(
          boxColor: kColorDark,
          boxWidth: 20,
          boxHeight: 20,
        );
      case BackgroundTemplate.musicDark:
        return const Background.box(
            boxColor: kColorDark,
            boxYColor: kColorWhite,
            boxHeight: 20,
            boxYSpace: 30,
            boxYCount: 5);
    }
  }
}

@freezed
class Background with _$Background {
  const factory Background.empty() = EmptyBackground;
  const factory Background.box(
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
      @Default(0.5) double boxYStroke}) = BoxBackground;

  factory Background.fromJson(Map<String, dynamic> json) =>
      _$BackgroundFromJson(json);
}
