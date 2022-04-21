import 'package:butterfly/models/colors.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'background.freezed.dart';
part 'background.g.dart';

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
        return const Background.box();
      case BackgroundTemplate.ruled:
        return const Background.box(
          boxHeight: 20,
        );
      case BackgroundTemplate.quad:
        return const Background.box(
          boxHeight: 20,
          boxWidth: 20,
        );
      case BackgroundTemplate.music:
        return const BoxBackground(
            boxHeight: 20, boxYColor: kColorBlack, boxYSpace: 30, boxYCount: 5);
      case BackgroundTemplate.plainDark:
        return const Background.box(
          boxColor: kColorBlack,
        );
      case BackgroundTemplate.ruledDark:
        return const Background.box(boxColor: kColorBlack, boxHeight: 20);
      case BackgroundTemplate.quadDark:
        return const Background.box(
          boxColor: kColorBlack,
          boxWidth: 20,
          boxHeight: 20,
        );
      case BackgroundTemplate.musicDark:
        return const Background.box(
            boxColor: kColorBlack,
            boxYColor: kColorWhite,
            boxHeight: 20,
            boxYSpace: 30,
            boxYCount: 5);
    }
  }

  String getLocalizedName(BuildContext context) {
    switch (this) {
      case BackgroundTemplate.plain:
        return AppLocalizations.of(context)!.plain;
      case BackgroundTemplate.ruled:
        return AppLocalizations.of(context)!.ruled;
      case BackgroundTemplate.quad:
        return AppLocalizations.of(context)!.quad;
      case BackgroundTemplate.music:
        return AppLocalizations.of(context)!.music;
      case BackgroundTemplate.plainDark:
        return AppLocalizations.of(context)!.plainDark;
      case BackgroundTemplate.ruledDark:
        return AppLocalizations.of(context)!.ruledDark;
      case BackgroundTemplate.quadDark:
        return AppLocalizations.of(context)!.quadDark;
      case BackgroundTemplate.musicDark:
        return AppLocalizations.of(context)!.musicDark;
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
