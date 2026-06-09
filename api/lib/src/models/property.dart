import 'package:butterfly_api/src/converter/color.dart';
import 'package:dart_leap/dart_leap.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'property.g.dart';
part 'property.freezed.dart';

abstract class PathProperty implements Property {
  @override
  double get strokeWidth;
  double get thinning;
  double get smoothing;
  double get streamline;
}

enum HorizontalAlignment { left, center, right, justify }

enum VerticalAlignment { top, center, bottom }

enum StrokeStyle { solid, dotted }

@freezed
sealed class ElementPaint with _$ElementPaint {
  const ElementPaint._();

  const factory ElementPaint.solid({
    @Default(SRGBColor.black) @ColorJsonConverter() SRGBColor color,
  }) = SolidElementPaint;

  const factory ElementPaint.texture({
    required String source,
    @Default(SRGBColor.white) @ColorJsonConverter() SRGBColor tint,
    @Default(1) double scale,
  }) = TextureElementPaint;

  const factory ElementPaint.gradient({
    @Default(SRGBColor.black) @ColorJsonConverter() SRGBColor start,
    @Default(SRGBColor.white) @ColorJsonConverter() SRGBColor end,
    @Default(0) double angle,
  }) = GradientElementPaint;

  factory ElementPaint.fromJson(Map<String, dynamic> json) =>
      _$ElementPaintFromJson(json);

  SRGBColor get previewColor => switch (this) {
    SolidElementPaint(:final color) => color,
    TextureElementPaint(:final tint) => tint,
    GradientElementPaint(:final start) => start,
  };

  ElementPaint withAlpha(int alpha) => switch (this) {
    SolidElementPaint(:final color) => ElementPaint.solid(
      color: color.withValues(a: alpha),
    ),
    TextureElementPaint(:final source, :final tint, :final scale) =>
      ElementPaint.texture(
        source: source,
        tint: tint.withValues(a: alpha),
        scale: scale,
      ),
    GradientElementPaint(:final start, :final end, :final angle) =>
      ElementPaint.gradient(
        start: start.withValues(a: alpha),
        end: end.withValues(a: alpha),
        angle: angle,
      ),
  };
}

@freezed
sealed class Property with _$Property {
  @Implements<PathProperty>()
  const factory Property.pen({
    @Default(5) double strokeWidth,
    @Default(0.4) double thinning,
    @Default(ElementPaint.solid()) ElementPaint paint,
    @Default(ElementPaint.solid(color: SRGBColor.transparent))
    ElementPaint fillPaint,
    @Default(0.5) double smoothing,
    @Default(0.3) double streamline,
  }) = PenProperty;

  const factory Property.shape({
    @Default(5) double strokeWidth,
    required PathShape shape,
    @Default(ElementPaint.solid()) ElementPaint paint,
    @Default(StrokeStyle.solid) StrokeStyle strokeStyle,
    @Default(1.0) double dashMultiplier,
    @Default(1.0) double gapMultiplier,
  }) = ShapeProperty;

  const factory Property.polygon({
    @Default(5) double strokeWidth,
    @Default(ElementPaint.solid()) ElementPaint paint,
    @Default(ElementPaint.solid(color: SRGBColor.transparent))
    ElementPaint fillPaint,
  }) = PolygonProperty;

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
}

@freezed
sealed class PathShape with _$PathShape {
  const PathShape._();
  const factory PathShape.circle({
    @Default(ElementPaint.solid(color: SRGBColor.transparent))
    ElementPaint fillPaint,
  }) = CircleShape;
  const factory PathShape.rectangle({
    @Default(ElementPaint.solid(color: SRGBColor.transparent))
    ElementPaint fillPaint,
    @Default(0) double topLeftCornerRadius,
    @Default(0) double topRightCornerRadius,
    @Default(0) double bottomLeftCornerRadius,
    @Default(0) double bottomRightCornerRadius,
  }) = RectangleShape;
  const factory PathShape.line() = LineShape;
  const factory PathShape.triangle({
    @Default(ElementPaint.solid(color: SRGBColor.transparent))
    ElementPaint fillPaint,
  }) = TriangleShape;

  factory PathShape.fromJson(Map<String, dynamic> json) =>
      _$PathShapeFromJson(json);
}
