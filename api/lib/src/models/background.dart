import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors.dart';
import 'texture.dart';

part 'background.g.dart';
part 'background.freezed.dart';

@Freezed(equal: false)
sealed class Background with _$Background {
  const Background._();

  factory Background.texture({
    required SurfaceTexture texture,
    @Default({}) Map<String, dynamic> extra,
  }) = TextureBackground;

  factory Background.image({
    required String source,
    required double width,
    required double height,
    @Default(1) double scaleX,
    @Default(1) double scaleY,
    @Default({}) Map<String, dynamic> extra,
  }) = ImageBackground;

  factory Background.svg({
    required String source,
    required double width,
    required double height,
    @Default(1) double scaleX,
    @Default(1) double scaleY,
    @Default({}) Map<String, dynamic> extra,
  }) = SvgBackground;

  factory Background.fromJson(Map<String, dynamic> json) =>
      _$BackgroundFromJson(json);

  int get defaultColor => maybeMap(
      texture: (texture) => texture.texture.boxColor,
      orElse: () => BasicColors.white);
}
