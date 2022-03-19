part of 'element.dart';

class EraserElement extends PathElement {
  @override
  final PathProperty property;

  const EraserElement(
      {String layer = '',
      List<PathPoint> points = const [],
      this.property = const PathProperty()})
      : super(points: points, layer: layer);
  EraserElement.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : property = PathProperty.fromJson(json),
        super.fromJson(json);

  @override
  Paint buildPaint([bool preview = false]) => Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white
    ..strokeCap = StrokeCap.round
    ..blendMode = preview ? BlendMode.srcOver : BlendMode.clear;

  @override
  EraserElement copyWith(
          {String? layer, List<PathPoint>? points, PathProperty? property}) =>
      EraserElement(
        layer: layer ?? this.layer,
        points: points ?? this.points,
        property: property ?? this.property,
      );

  @override
  ElementType get type => ElementType.eraser;
}
