import 'package:flutter/material.dart';

@immutable
class BoxBackground {
  final double boxWidth, boxHeight, boxXSpace, boxYSpace;
  final int boxXCount, boxYCount;
  const BoxBackground(
      {this.boxWidth = 0,
      this.boxHeight = 0,
      this.boxXCount = 0,
      this.boxYCount = 0,
      this.boxXSpace = 0,
      this.boxYSpace = 0});
  BoxBackground.fromJson(Map<String, dynamic> json)
      : boxWidth = json['boxWidth'] ?? 0,
        boxHeight = json['boxHeight'] ?? 0,
        boxXCount = json['boxXCount'] ?? 0,
        boxYCount = json['boxYCount'] ?? 0,
        boxXSpace = json['boxXSpace'] ?? 0,
        boxYSpace = json['boxYSpace'] ?? 0;

  Map<String, dynamic> toJson() => {
        'boxWidth': boxWidth,
        'boxHeight': boxHeight,
        'boxXCount': boxXCount,
        'boxYCount': boxYCount,
        'boxXSpace': boxXSpace,
        'boxYSpace': boxYSpace,
      };
  BoxBackground copyWith(
          {double? boxWidth,
          double? boxHeight,
          int? boxXCount,
          int? boxYCount,
          double? boxXSpace,
          double? boxYSpace}) =>
      BoxBackground(
        boxWidth: boxWidth ?? this.boxWidth,
        boxHeight: boxHeight ?? this.boxHeight,
        boxXCount: boxXCount ?? this.boxXCount,
        boxYCount: boxYCount ?? this.boxYCount,
        boxXSpace: boxXSpace ?? this.boxXSpace,
        boxYSpace: boxYSpace ?? this.boxYSpace,
      );
}
