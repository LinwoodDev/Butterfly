import 'dart:math';

import 'converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'pack.dart';
import 'point.dart';
import 'property.dart';
import 'text.dart';

part 'element.freezed.dart';
part 'element.g.dart';

@freezed
class ElementConstraint with _$ElementConstraint {
  const factory ElementConstraint({
    @Default(0) double size,
    @Default(0) double length,
    @Default(true) bool includeArea,
  }) = _ElementConstraint;

  factory ElementConstraint.fromJson(Map<String, dynamic> json) =>
      _$ElementConstraintFromJson(json);
}

@freezed
@immutable
class ElementConstraints with _$ElementConstraints {
  const factory ElementConstraints.scaled(
      {@Default(1) double scaleX,
      @Default(1) double scaleY}) = ScaledElementConstraints;
  const factory ElementConstraints.fixed(double height, double width) =
      FixedElementConstraints;
  const factory ElementConstraints.dynamic({
    @Default(0) double height,
    @Default(0) double width,
    @Default(0) double aspectRatio,
    @Default(true) bool includeArea,
  }) = DynamicElementConstraints;

  factory ElementConstraints.fromJson(Map<String, dynamic> json) =>
      _$ElementConstraintsFromJson(json);
}

abstract class PathElement {
  List<PathPoint> get points;
  PathProperty get property;
}

@Freezed(equal: false)
class PadElement with _$PadElement {
  @Implements<PathElement>()
  const factory PadElement.pen({
    @Default('') String layer,
    double? zoom,
    @Default([]) List<PathPoint> points,
    @Default(PenProperty()) PenProperty property,
  }) = PenElement;

  const factory PadElement.text({
    @Default('') String layer,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
        Point<double> position,
    @Default(PackAssetLocation()) PackAssetLocation styleSheet,
    required TextArea area,
    @Default(ElementConstraint(size: 1000)) ElementConstraint constraint,
  }) = TextElement;

  const factory PadElement.image({
    @Default('') String layer,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
        Point<double> position,
    @Default(ScaledElementConstraints(scaleX: 1, scaleY: 1))
        ElementConstraints? constraints,
    required String source,
    required double width,
    required double height,
  }) = ImageElement;

  const factory PadElement.svg({
    @Default('') String layer,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
        Point<double> position,
    @Default(ScaledElementConstraints(scaleX: 1, scaleY: 1))
        ElementConstraints? constraints,
    required String data,
    required double width,
    required double height,
  }) = SvgElement;

  const factory PadElement.shape({
    @Default('') String layer,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
        Point<double> firstPosition,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
        Point<double> secondPosition,
    @Default(ShapeProperty(shape: RectangleShape())) ShapeProperty property,
  }) = ShapeElement;

  factory PadElement.fromJson(Map<String, dynamic> json) =>
      _$PadElementFromJson(json);
}
