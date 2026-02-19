import 'dart:math';

import '../converter/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'area.g.dart';
part 'area.freezed.dart';

const double _kSquareRatio = 1.0;
const double _kAPortraitRatio = 1 / sqrt2;
const double _kLandscapeRatio = sqrt2;

enum AspectRatioPreset { square, portrait, landscape }

extension RatioPresetExtension on AspectRatioPreset {
  double get ratio => switch (this) {
    AspectRatioPreset.square => _kSquareRatio,
    AspectRatioPreset.portrait => _kAPortraitRatio,
    AspectRatioPreset.landscape => _kLandscapeRatio,
  };
}

enum AreaSizePreset {
  a3(width: 297, height: 420),
  a4(width: 210, height: 297),
  a5(width: 148, height: 210),
  letter(width: 215.9, height: 279.4),
  legal(width: 215.9, height: 355.6),
  ledger(width: 431.8, height: 279.4),
  photo4x6(width: 101.6, height: 152.4),
  photo5x7(width: 127, height: 177.8),
  photo8x10(width: 203.2, height: 254),
  screenHd(width: 1280, height: 720),
  screenFullHd(width: 1920, height: 1080),
  screenQhd(width: 2560, height: 1440),
  screen4k(width: 3840, height: 2160);

  final double width, height;

  const AreaSizePreset({required this.width, required this.height});
}

extension AreaSizePresetExtension on AreaSizePreset {
  String get label => switch (this) {
    AreaSizePreset.a3 => 'A3',
    AreaSizePreset.a4 => 'A4',
    AreaSizePreset.a5 => 'A5',
    AreaSizePreset.letter => 'Letter',
    AreaSizePreset.legal => 'Legal',
    AreaSizePreset.ledger => 'Ledger',
    AreaSizePreset.photo4x6 => 'Photo 4×6',
    AreaSizePreset.photo5x7 => 'Photo 5×7',
    AreaSizePreset.photo8x10 => 'Photo 8×10',
    AreaSizePreset.screenHd => 'HD (1280×720)',
    AreaSizePreset.screenFullHd => 'Full HD (1920×1080)',
    AreaSizePreset.screenQhd => 'QHD (2560×1440)',
    AreaSizePreset.screen4k => '4K (3840×2160)',
  };
}

@freezed
sealed class Area with _$Area {
  const Area._();
  const factory Area({
    @Default('') String name,
    required double width,
    required double height,
    @DoublePointJsonConverter() required Point<double> position,
    @Default({}) Map<String, dynamic> extra,
  }) = _Area;

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
  // Aspect ratio is the ratio between width and height.
  factory Area.fromPoints(
    Point<double> first,
    Point<double> second, {
    double width = 0,
    double height = 0,
    double aspectRatio = 0,
    String name = '',
  }) {
    double realWidth = width;
    double realHeight = height;
    if (realWidth == 0) {
      realWidth = (second.x - first.x).abs();
    }
    if (realHeight == 0) {
      realHeight = (second.y - first.y).abs();
    }
    if (aspectRatio != 0 && height == 0) {
      realHeight = realWidth / aspectRatio;
    }
    if (aspectRatio != 0 && width == 0) {
      realWidth = realHeight * aspectRatio;
    }
    final position = Point<double>(
      first.x > second.x ? second.x : first.x,
      first.y > second.y ? second.y : first.y,
    );
    return Area(
      width: realWidth,
      height: realHeight,
      position: position,
      name: name,
    );
  }

  Point get second => Point(position.x + width, position.y + height);

  Area moveBy(Point<double> offset) => copyWith(position: position + offset);
}
