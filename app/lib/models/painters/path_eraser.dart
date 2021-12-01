import 'painter.dart';

class PathEraserPainter extends Painter {
  final double strokeWidth, strokeMultiplier;
  final bool includeEraser;

  const PathEraserPainter(
      {this.strokeWidth = 5,
      this.strokeMultiplier = 10,
      String name = '',
      this.includeEraser = false})
      : super(name: name);
  PathEraserPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : strokeWidth = json['strokeWidth'] ?? 5,
        strokeMultiplier = json['strokeMultiplier'] ?? 1,
        includeEraser = json['includeEraser'] ?? false,
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'type': 'path-eraser',
      'strokeWidth': strokeWidth,
      'strokeMultiplier': strokeMultiplier,
      'includeEraser': includeEraser
    });

  PathEraserPainter copyWith(
          {String? name,
          double? strokeWidth,
          double? strokeMultiplier,
          bool? includeEraser}) =>
      PathEraserPainter(
        name: name ?? this.name,
        strokeWidth: strokeWidth ?? this.strokeWidth,
        strokeMultiplier: strokeMultiplier ?? this.strokeMultiplier,
        includeEraser: includeEraser ?? this.includeEraser,
      );
}
