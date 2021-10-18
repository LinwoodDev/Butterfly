import 'package:flutter/material.dart';

@immutable
class BoxBackground {
  final double boxWidth, boxHeight, boxXSpace, boxYSpace, boxXStroke, boxYStroke;
  final Color boxXColor, boxYColor, boxColor;
  final int boxXCount, boxYCount;
  const BoxBackground(
      {this.boxWidth = 0,
      this.boxHeight = 0,
      this.boxXCount = 0,
      this.boxYCount = 0,
      this.boxXSpace = 0,
      this.boxYSpace = 0,
      this.boxXColor = Colors.blue,
      this.boxYColor = Colors.red,
      this.boxColor = Colors.white,
      this.boxXStroke = .5,
      this.boxYStroke = .5});
  BoxBackground.fromJson(Map<String, dynamic> json, [int? apiVersion])
      : boxWidth = json['width'] ?? 0,
        boxHeight = json['height'] ?? 0,
        boxXCount = json['x-count'] ?? 0,
        boxYCount = json['y-count'] ?? 0,
        boxXSpace = json['x-space'] ?? 0,
        boxYSpace = json['y-space'] ?? 0,
        boxXColor = json['x-color'] != null ? Color(json['x-color']) : Colors.blue,
        boxYColor = json['y-color'] != null ? Color(json['y-color']) : Colors.red,
        boxColor = json['color'] != null ? Color(json['color']) : Colors.white,
        boxXStroke = json['x-stroke'] ?? .5,
        boxYStroke = json['y-stroke'] ?? .5;

  Map<String, dynamic> toJson() => {
        'width': boxWidth,
        'height': boxHeight,
        'x-count': boxXCount,
        'y-count': boxYCount,
        'x-space': boxXSpace,
        'y-space': boxYSpace,
        'x-color': boxXColor.value,
        'y-color': boxYColor.value,
        'color': boxColor.value,
        'x-stroke': boxXStroke,
        'y-stroke': boxYStroke,
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
}
