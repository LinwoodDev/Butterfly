import 'painter.dart';

class PathEraserPainter extends Painter {
  final double strokeWidth;

  const PathEraserPainter({this.strokeWidth = 5});
  PathEraserPainter.fromJson(Map<String, dynamic> json) : strokeWidth = json['stroke-width'] ?? 5;
  @override
  Map<String, dynamic> toJson() => {"type": "path-eraser", "stroke-width": strokeWidth};
}
