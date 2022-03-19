part of 'painter.dart';

class PathEraserPainter extends Painter {
  final double strokeWidth;
  final bool includeEraser, deleteWholeStroke;

  const PathEraserPainter(
      {this.strokeWidth = 5,
      String name = '',
      this.includeEraser = false,
      this.deleteWholeStroke = false})
      : super(name: name);
  PathEraserPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : strokeWidth = json['strokeWidth'] ?? 5,
        includeEraser = json['includeEraser'] ?? false,
        deleteWholeStroke = json['deleteWholeStroke'] ?? false,
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'type': 'path-eraser',
      'strokeWidth': strokeWidth,
      'includeEraser': includeEraser,
      'deleteWholeStroke': deleteWholeStroke,
    });

  PathEraserPainter copyWith(
          {String? name,
          double? strokeWidth,
          bool? includeEraser,
          bool? deleteWholeStroke}) =>
      PathEraserPainter(
        name: name ?? this.name,
        strokeWidth: strokeWidth ?? this.strokeWidth,
        includeEraser: includeEraser ?? this.includeEraser,
        deleteWholeStroke: deleteWholeStroke ?? this.deleteWholeStroke,
      );
}
