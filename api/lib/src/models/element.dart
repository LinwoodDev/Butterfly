import 'dart:math';

import '../converter/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors.dart';
import 'pack.dart';
import 'point.dart';
import 'property.dart';
import 'text.dart';

part 'element.freezed.dart';
part 'element.g.dart';

enum PatternTemplate {
  plain,
  ruled,
  quad,
  music,
  plainDark,
  ruledDark,
  quadDark,
  musicDark
}

extension PatternTemplateExtension on PatternTemplate {
  // camelCase to snake_case
  String get asset =>
      'templates/${name.replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match.group(1)?.toLowerCase()}')}.png';

  bool get dark => [
        PatternTemplate.plainDark,
        PatternTemplate.ruledDark,
        PatternTemplate.quadDark,
        PatternTemplate.musicDark
      ].contains(this);

  PatternTexture create() {
    switch (this) {
      case PatternTemplate.plain:
        return const PatternTexture(
          boxColor: kColorLight,
        );
      case PatternTemplate.ruled:
        return const PatternTexture(
          boxColor: kColorLight,
          boxHeight: 20,
        );
      case PatternTemplate.quad:
        return const PatternTexture(
          boxColor: kColorLight,
          boxHeight: 20,
          boxWidth: 20,
        );
      case PatternTemplate.music:
        return const PatternTexture(
            boxColor: kColorLight,
            boxHeight: 20,
            boxYColor: kColorBlack,
            boxYSpace: 30,
            boxYCount: 5);
      case PatternTemplate.plainDark:
        return const PatternTexture(
          boxColor: kColorDark,
        );
      case PatternTemplate.ruledDark:
        return const PatternTexture(boxColor: kColorDark, boxHeight: 20);
      case PatternTemplate.quadDark:
        return const PatternTexture(
          boxColor: kColorDark,
          boxWidth: 20,
          boxHeight: 20,
        );
      case PatternTemplate.musicDark:
        return const PatternTexture(
            boxColor: kColorDark,
            boxYColor: kColorWhite,
            boxHeight: 20,
            boxYSpace: 30,
            boxYCount: 5);
    }
  }
}

@freezed
sealed class SurfaceTexture with _$SurfaceTexture {
  const factory SurfaceTexture.pattern(
      {@Default(0) double boxWidth,
      @Default(0) double boxHeight,
      @Default(1) int boxXCount,
      @Default(1) int boxYCount,
      @Default(0) double boxXSpace,
      @Default(0) double boxYSpace,
      @Default(kColorBlue) int boxXColor,
      @Default(kColorRed) int boxYColor,
      @Default(kColorWhite) int boxColor,
      @Default(0.5) double boxXStroke,
      @Default(0.5) double boxYStroke}) = PatternTexture;

  factory SurfaceTexture.fromJson(Map<String, dynamic> json) =>
      _$SurfaceTextureFromJson(json);
}

@freezed
sealed class ElementConstraint with _$ElementConstraint {
  const factory ElementConstraint({
    @Default(0) double size,
    @Default(0) double length,
    @Default(true) bool includeArea,
  }) = _ElementConstraint;

  factory ElementConstraint.fromJson(Map<String, dynamic> json) =>
      _$ElementConstraintFromJson(json);
}

abstract class SourcedElement {
  String get source;
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

mixin LabelElement {
  String get layer;
  Point<double> get position;
  double get scale;
  PackAssetLocation get styleSheet;
  ElementConstraint get constraint;

  AreaProperty get areaProperty {
    final element = this as PadElement;
    return element.maybeMap(
      markdown: (e) => e.areaProperty,
      text: (e) => e.area.areaProperty,
      orElse: () => throw UnimplementedError(),
    );
  }

  String get text {
    final element = this as PadElement;
    return element.maybeMap(
      markdown: (e) => e.text,
      text: (e) => e.area.paragraph.text,
      orElse: () => throw UnimplementedError(),
    );
  }
}

@Freezed(equal: false)
class PadElement with _$PadElement {
  @Implements<PathElement>()
  factory PadElement.pen({
    @Default(0) double rotation,
    @Default('') String layer,
    double? zoom,
    @Default([]) List<PathPoint> points,
    @Default(PenProperty()) PenProperty property,
  }) = PenElement;

  @With<LabelElement>()
  factory PadElement.text({
    @Default(0) double rotation,
    @Default('') String layer,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> position,
    @Default(1.0) double scale,
    @Default(PackAssetLocation()) PackAssetLocation styleSheet,
    required TextArea area,
    @Default(ElementConstraint(size: 1000)) ElementConstraint constraint,
    @Default(kColorBlack) int foreground,
  }) = TextElement;

  @With<LabelElement>()
  factory PadElement.markdown({
    @Default(0) double rotation,
    @Default('') String layer,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> position,
    @Default(1.0) double scale,
    @Default(PackAssetLocation()) PackAssetLocation styleSheet,
    @Default(AreaProperty()) AreaProperty areaProperty,
    required String text,
    @Default(ElementConstraint(size: 1000)) ElementConstraint constraint,
    @Default(kColorBlack) int foreground,
  }) = MarkdownElement;

  @Implements<SourcedElement>()
  factory PadElement.image({
    @Default(0) double rotation,
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

  @Implements<SourcedElement>()
  factory PadElement.svg({
    @Default(0) double rotation,
    @Default('') String layer,
    @DoublePointJsonConverter()
    @Default(Point(0.0, 0.0))
    Point<double> position,
    @Default(ScaledElementConstraints(scaleX: 1, scaleY: 1))
    ElementConstraints? constraints,
    required String source,
    required double width,
    required double height,
  }) = SvgElement;

  factory PadElement.shape({
    @Default(0) double rotation,
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
