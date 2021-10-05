import 'painter.dart';

class EraserPainter extends Painter {
  final double strokeWidth;

  const EraserPainter({this.strokeWidth = 5});
  EraserPainter.fromJson(Map<String, dynamic> json) : strokeWidth = json['stroke-width'] ?? 5;
  @override
  Map<String, dynamic> toJson() => {"type": "eraser", "stroke-width": strokeWidth};
}
