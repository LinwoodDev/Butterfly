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
  BoxBackground.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : boxWidth = json['width'] ?? 0,
        boxHeight = json['height'] ?? 0,
        boxXCount = json['xCount'] ?? 0,
        boxYCount = json['yCount'] ?? 0,
        boxXSpace = json['xSpace'] ?? 0,
        boxYSpace = json['ySpace'] ?? 0,
        boxXColor = json['xColor'] != null ? Color(json['xColor']) : Colors.blue,
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
}
