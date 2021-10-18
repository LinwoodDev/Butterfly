import 'painter.dart';

class EraserPainter extends Painter {
  final double strokeWidth, strokeMultiplier;

  const EraserPainter({this.strokeWidth = 10, this.strokeMultiplier = 2, String name = ''})
      : super(name: name);
  EraserPainter.fromJson(Map<String, dynamic> json, [int? apiVersion])
      : strokeWidth = json['stroke-width'] ?? 10,
        strokeMultiplier = json['stroke-multiplier'] ?? 2,
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll(
        {"type": "eraser", "stroke-width": strokeWidth, "stroke-multiplier": strokeMultiplier});
  EraserPainter copyWith({String? name, double? strokeWidth, double? strokeMultiplier}) =>
      EraserPainter(
          name: name ?? this.name,
          strokeWidth: strokeWidth ?? this.strokeWidth,
          strokeMultiplier: strokeMultiplier ?? this.strokeMultiplier);
}
