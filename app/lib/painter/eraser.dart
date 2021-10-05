import 'painter.dart';

class EraserPainter extends Painter {
  final double strokeWidth;

  const EraserPainter({this.strokeWidth = 5, String name = ''}) : super(name: name);
  EraserPainter.fromJson(Map<String, dynamic> json)
      : strokeWidth = json['stroke-width'] ?? 5,
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      super.toJson()..addAll({"type": "eraser", "stroke-width": strokeWidth});
}
