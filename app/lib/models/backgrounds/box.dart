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
  BoxBackground.fromJson(Map<String, dynamic> json)
      : boxWidth = json['boxWidth'] ?? 0,
        boxHeight = json['boxHeight'] ?? 0,
        boxXCount = json['boxXCount'] ?? 0,
        boxYCount = json['boxYCount'] ?? 0,
        boxXSpace = json['boxXSpace'] ?? 0,
        boxYSpace = json['boxYSpace'] ?? 0,
        boxXColor = json['boxXColor'] != null ? Color(json['boxXColor']) : Colors.blue,
        boxYColor = json['boxYColor'] != null ? Color(json['boxYColor']) : Colors.red,
        boxColor = json['boxColor'] != null ? Color(json['boxColor']) : Colors.white,
        boxXStroke = json['boxXStroke'] ?? .5,
        boxYStroke = json['boxYStroke'] ?? .5;

  Map<String, dynamic> toJson() => {
        'boxWidth': boxWidth,
        'boxHeight': boxHeight,
        'boxXCount': boxXCount,
        'boxYCount': boxYCount,
        'boxXSpace': boxXSpace,
        'boxYSpace': boxYSpace,
        'boxXColor': boxXColor.value,
        'boxYColor': boxYColor.value,
        'boxColor': boxColor.value,
        'boxXStroke': boxXStroke,
        'boxYStroke': boxYStroke,
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
