import 'dart:math';

import 'package:butterfly_api/butterfly_api.dart';
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

const defaultGradientStops = [
  ElementGradientStop(offset: 0, color: SRGBColor.black),
  ElementGradientStop(offset: 1, color: SRGBColor.white),
];

@freezed
sealed class ElementPaint with _$ElementPaint {
  const ElementPaint._();

  const factory ElementPaint.solid({
    @Default(SRGBColor.black) @ColorJsonConverter() SRGBColor color,
    @Default(0) double blur,
  }) = SolidElementPaint;

  const factory ElementPaint.image({
    required String source,
    @Default(SRGBColor.white) @ColorJsonConverter() SRGBColor tint,
    @Default(0.25) double scale,
    @Default(0) double blur,
  }) = ImageElementPaint;

  const factory ElementPaint.svg({
    required String source,
    @Default(SRGBColor.white) @ColorJsonConverter() SRGBColor tint,
    @Default(0.25) double scale,
    @Default(0) double blur,
  }) = SvgElementPaint;

  const factory ElementPaint.gradient({
    @Default(ElementGradient.linear()) ElementGradient gradient,
    @Default(0) double blur,
  }) = GradientElementPaint;

  factory ElementPaint.fromJson(Map<String, dynamic> json) =>
      _$ElementPaintFromJson(json);

  SRGBColor get previewColor => switch (this) {
    SolidElementPaint(:final color) => color,
    ImageElementPaint(:final tint) => tint,
    SvgElementPaint(:final tint) => tint,
    GradientElementPaint(:final gradient) =>
      gradient.stops.firstOrNull?.color ?? SRGBColor.black,
  };

  ElementPaint withAlpha(int alpha) => switch (this) {
    SolidElementPaint(:final color, :final blur) => ElementPaint.solid(
      color: color.withValues(a: alpha),
      blur: blur,
    ),
    ImageElementPaint(:final source, :final tint, :final scale, :final blur) =>
      ElementPaint.image(
        source: source,
        tint: tint.withValues(a: alpha),
        scale: scale,
        blur: blur,
      ),
    SvgElementPaint(:final source, :final tint, :final scale, :final blur) =>
      ElementPaint.svg(
        source: source,
        tint: tint.withValues(a: alpha),
        scale: scale,
        blur: blur,
      ),
    GradientElementPaint p => p.copyWith.gradient(
      stops: p.gradient.stops
          .map((stop) => stop.copyWith(color: stop.color.withValues(a: alpha)))
          .toList(),
    ),
  };
}

@freezed
sealed class ElementGradient with _$ElementGradient {
  const factory ElementGradient.linear({
    @DoublePointJsonConverter() @Default(Point(0, 0)) Point<double> start,
    @DoublePointJsonConverter() @Default(Point(1, 0)) Point<double> end,
    @Default(defaultGradientStops) List<ElementGradientStop> stops,
    //@Default(GradientUnits.objectBoundingBox) GradientUnits units,
    //@Default(GradientSpreadMethod.pad) GradientSpreadMethod spreadMethod,
    //GradientTransform? transform,
  }) = LinearElementGradient;

  const factory ElementGradient.radial({
    @DoublePointJsonConverter() @Default(Point(0.5, 0.5)) Point<double> center,
    @Default(0.5) double radius,

    @DoublePointJsonConverter() Point<double>? focal,

    double? focalRadius,

    @Default(defaultGradientStops) List<ElementGradientStop> stops,
    //@Default(GradientUnits.objectBoundingBox) GradientUnits units,
    //@Default(GradientSpreadMethod.pad) GradientSpreadMethod spreadMethod,
    //GradientTransform? transform,
  }) = RadialElementGradient;

  factory ElementGradient.fromJson(Map<String, dynamic> json) =>
      _$ElementGradientFromJson(json);
}

@freezed
sealed class ElementGradientStop with _$ElementGradientStop {
  const factory ElementGradientStop({
    @Default(0) double offset,
    @Default(SRGBColor.black) @ColorJsonConverter() SRGBColor color,
  }) = _ElementGradientStop;

  factory ElementGradientStop.fromJson(Map<String, dynamic> json) =>
      _$ElementGradientStopFromJson(json);
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
