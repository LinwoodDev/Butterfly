import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      'templates/' +
      name.replaceAllMapped(
          RegExp(r'([A-Z])'), (match) => '_${match.group(1)?.toLowerCase()}') +
      '.png';

  bool get dark => [
        BackgroundTemplate.plainDark,
        BackgroundTemplate.ruledDark,
        BackgroundTemplate.quadDark,
        BackgroundTemplate.musicDark
      ].contains(this);

  BoxBackground create() {
    switch (this) {
      case BackgroundTemplate.plain:
        return const BoxBackground();
      case BackgroundTemplate.ruled:
        return const BoxBackground(
          boxHeight: 20,
        );
      case BackgroundTemplate.quad:
        return const BoxBackground(
          boxHeight: 20,
          boxWidth: 20,
        );
      case BackgroundTemplate.music:
        return const BoxBackground(
            boxHeight: 20,
            boxYColor: Colors.black,
            boxYSpace: 30,
            boxYCount: 5);
      case BackgroundTemplate.plainDark:
        return const BoxBackground(
          boxColor: Colors.black,
        );
      case BackgroundTemplate.ruledDark:
        return const BoxBackground(boxColor: Colors.black, boxHeight: 20);
      case BackgroundTemplate.quadDark:
        return const BoxBackground(
          boxColor: Colors.black,
          boxWidth: 20,
          boxHeight: 20,
        );
      case BackgroundTemplate.musicDark:
        return const BoxBackground(
            boxColor: Colors.black,
            boxYColor: Colors.white,
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

@immutable
class BoxBackground extends Equatable {
  final double boxWidth,
      boxHeight,
      boxXSpace,
      boxYSpace,
      boxXStroke,
      boxYStroke;
  final Color boxXColor, boxYColor, boxColor;
  final int boxXCount, boxYCount;
  const BoxBackground(
      {this.boxWidth = 0,
      this.boxHeight = 0,
      this.boxXCount = 1,
      this.boxYCount = 1,
      this.boxXSpace = 0,
      this.boxYSpace = 0,
      this.boxXColor = Colors.blue,
      this.boxYColor = Colors.red,
      this.boxColor = Colors.white,
      this.boxXStroke = .5,
      this.boxYStroke = .5});
  BoxBackground.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : boxWidth = json['width'] ?? 0,
        boxHeight = json['height'] ?? 0,
        boxXCount = json['xCount'] ?? 1,
        boxYCount = json['yCount'] ?? 1,
        boxXSpace = json['xSpace'] ?? 0,
        boxYSpace = json['ySpace'] ?? 0,
        boxXColor =
            json['xColor'] != null ? Color(json['xColor']) : Colors.blue,
        boxYColor = json['yColor'] != null ? Color(json['yColor']) : Colors.red,
        boxColor = json['color'] != null ? Color(json['color']) : Colors.white,
        boxXStroke = json['xStroke'] ?? .5,
        boxYStroke = json['yStroke'] ?? .5;

  Map<String, dynamic> toJson() => {
        'width': boxWidth,
        'height': boxHeight,
        'xCount': boxXCount,
        'yCount': boxYCount,
        'xSpace': boxXSpace,
        'ySpace': boxYSpace,
        'xColor': boxXColor.value,
        'yColor': boxYColor.value,
        'color': boxColor.value,
        'xStroke': boxXStroke,
        'yStroke': boxYStroke,
      };
  BoxBackground copyWith({
    double? boxWidth,
    double? boxHeight,
    int? boxXCount,
    int? boxYCount,
    double? boxXSpace,
    double? boxYSpace,
    Color? boxXColor,
    Color? boxYColor,
    Color? boxColor,
    double? boxXStroke,
    double? boxYStroke,
  }) =>
      BoxBackground(
        boxWidth: boxWidth ?? this.boxWidth,
        boxHeight: boxHeight ?? this.boxHeight,
        boxXCount: boxXCount ?? this.boxXCount,
        boxYCount: boxYCount ?? this.boxYCount,
        boxXSpace: boxXSpace ?? this.boxXSpace,
        boxYSpace: boxYSpace ?? this.boxYSpace,
        boxXColor: boxXColor ?? this.boxXColor,
        boxYColor: boxYColor ?? this.boxYColor,
        boxColor: boxColor ?? this.boxColor,
        boxXStroke: boxXStroke ?? this.boxXStroke,
        boxYStroke: boxYStroke ?? this.boxYStroke,
      );
  @override
  List<Object> get props => [
        boxWidth,
        boxHeight,
        boxXCount,
        boxYCount,
        boxXSpace,
        boxYSpace,
        boxXColor,
        boxYColor,
        boxColor,
        boxXStroke,
        boxYStroke,
      ];
}
