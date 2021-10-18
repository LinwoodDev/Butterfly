import 'painter.dart';

class EraserPainter extends Painter {
  final double strokeWidth, strokeMultiplier;

  const EraserPainter({this.strokeWidth = 10, this.strokeMultiplier = 2, String name = ''})
      : super(name: name);
  EraserPainter.fromJson(Map<String, dynamic> json, [String? fileVersion])
      : strokeWidth = json['strokeWidth'] ?? 10,
        strokeMultiplier = json['strokeMultiplier'] ?? 2,
        super.fromJson(json);
  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({"type": "eraser", "strokeWidth": strokeWidth, "strokeMultiplier": strokeMultiplier});
  EraserPainter copyWith({String? name, double? strokeWidth, double? strokeMultiplier}) =>
      EraserPainter(
          name: name ?? this.name,
          strokeWidth: strokeWidth ?? this.strokeWidth,
          strokeMultiplier: strokeMultiplier ?? this.strokeMultiplier);
}
