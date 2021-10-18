import 'painter.dart';

class PathEraserPainter extends Painter {
  final double strokeWidth, strokeMultiplier;
  final bool canDeleteEraser;

  const PathEraserPainter(
      {this.strokeWidth = 5,
      this.strokeMultiplier = 1,
      String name = '',
      this.canDeleteEraser = false})
      : super(name: name);
  PathEraserPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : strokeWidth = json['strokeWidth'] ?? 5,
        strokeMultiplier = json['strokeMultiplier'] ?? 1,
        canDeleteEraser = json['can-delete-eraser'] ?? false,
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      "type": "path-eraser",
      "strokeWidth": strokeWidth,
      "strokeMultiplier": strokeMultiplier,
      "can-delete-eraser": canDeleteEraser
    });

  PathEraserPainter copyWith(
          {String? name, double? strokeWidth, double? strokeMultiplier, bool? canDeleteEraser}) =>
      PathEraserPainter(
        name: name ?? this.name,
        strokeWidth: strokeWidth ?? this.strokeWidth,
        strokeMultiplier: strokeMultiplier ?? this.strokeMultiplier,
        canDeleteEraser: canDeleteEraser ?? this.canDeleteEraser,
      );
}
