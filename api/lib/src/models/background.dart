import 'package:freezed_annotation/freezed_annotation.dart';

import 'element.dart';

part 'background.g.dart';
part 'background.freezed.dart';

@Freezed(equal: false)
sealed class Background with _$Background {
  factory Background.motif({
    required Motif motif,
  }) = MotifBackground;

  factory Background.image({
    required String source,
    required double width,
    required double height,
    @Default(1) double scaleX,
    @Default(1) double scaleY,
  }) = ImageBackground;

  factory Background.svg({
    required String source,
    required double width,
    required double height,
    @Default(1) double scaleX,
    @Default(1) double scaleY,
  }) = SvgBackground;

  factory Background.fromJson(Map<String, dynamic> json) =>
      _$BackgroundFromJson(json);
}
