import 'package:dart_leap/dart_leap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'element.dart';
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

  @Implements<SourcedElement>()
  factory Background.image({
    required String source,
    required double width,
    required double height,
    @Default(1) double scaleX,
    @Default(1) double scaleY,
    @Default({}) Map<String, dynamic> extra,
  }) = ImageBackground;

  @Implements<SourcedElement>()
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

  SRGBColor get defaultColor => switch (this) {
    TextureBackground e => e.texture.boxColor,
    _ => SRGBColor.white,
  };
}
