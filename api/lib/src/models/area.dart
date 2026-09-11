import 'dart:math';

import 'package:dart_leap/dart_leap.dart';

import '../converter/core.dart';
import '../converter/color.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'area.g.dart';
part 'area.freezed.dart';

const double _kSquareRatio = 1.0;
const double _kAPortraitRatio = 1 / sqrt2;
const double _kLandscapeRatio = sqrt2;

enum AspectRatioPreset { square, portrait, landscape }

extension RatioPresetExtension on AspectRatioPreset {
  double get ratio => switch (this) {
    .square => _kSquareRatio,
    .portrait => _kAPortraitRatio,
    .landscape => _kLandscapeRatio,
  };
}

enum AreaSizePreset({
  required final double width,
  required final double height,
}) {
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
  screen4k(width: 3840, height: 2160),
}

extension AreaSizePresetExtension on AreaSizePreset {
  String get label => switch (this) {
    .a3 => 'A3',
    .a4 => 'A4',
    .a5 => 'A5',
    .letter => 'Letter',
    .legal => 'Legal',
    .ledger => 'Ledger',
    .photo4x6 => 'Photo 4×6',
    .photo5x7 => 'Photo 5×7',
    .photo8x10 => 'Photo 8×10',
    .screenHd => 'HD (1280×720)',
    .screenFullHd => 'Full HD (1920×1080)',
    .screenQhd => 'QHD (2560×1440)',
    .screen4k => '4K (3840×2160)',
  };
}

@freezed
@JsonSerializable()
class const Area({
  final String name = '',
  required final double width,
  required final double height,
  @DoublePointJsonConverter() required final Point<double> position,
  final bool isInitial = false,
  @ColorJsonConverter() final SRGBColor? color,
}) with _$Area {
  static Area fromJson(Map json) =>
      _$AreaFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$AreaToJson(this);
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
      isInitial: false,
    );
  }
}

extension AreaProperties on Area {
  Point<double> get second => .new(position.x + width, position.y + height);

  Area moveBy(Point<double> offset) => copyWith(position: position + offset);

  List<String> get parts => name.split('/');

  List<String> get groups {
    final parts = this.parts;
    if (parts.length <= 1) return [];
    return parts.sublist(0, parts.length - 1);
  }

  String get group => groups.join('/');

  String get shortName {
    final parts = this.parts;
    return parts.isEmpty ? '' : parts.last;
  }
}
