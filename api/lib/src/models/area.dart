import 'dart:math';

import 'converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'area.g.dart';
part 'area.freezed.dart';

@freezed
class Area with _$Area {
  const Area._();
  const factory Area({
    @Default('') String name,
    required double width,
    required double height,
    @DoublePointJsonConverter() required Point<double> position,
  }) = _Area;

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
  // Aspect ratio is the ratio between width and height.
  factory Area.fromPoints(Point<double> first, Point<double> second,
      {double width = 0,
      double height = 0,
      double aspectRatio = 0,
      String name = ''}) {
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
        width: realWidth, height: realHeight, position: position, name: name);
  }

  Point get second => Point(position.x + width, position.y + height);

  Area moveBy(Point<double> offset) => copyWith(position: position + offset);
}
