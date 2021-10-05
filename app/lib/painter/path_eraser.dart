import 'painter.dart';

class PathEraserPainter extends Painter {
  final double strokeWidth;

  const PathEraserPainter({this.strokeWidth = 5, String name = ''}) : super(name: name);
  PathEraserPainter.fromJson(Map<String, dynamic> json)
      : strokeWidth = json['stroke-width'] ?? 5,
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      super.toJson()..addAll({"type": "path-eraser", "stroke-width": strokeWidth});
}
