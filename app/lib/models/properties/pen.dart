part of 'property.dart';

class PenProperty extends PathProperty {
  final Color color;
  final bool fill;

  const PenProperty(
      {double strokeWidth = 5,
      double strokeMultiplier = 10,
      this.color = Colors.black,
      this.fill = false})
      : super(strokeWidth: strokeWidth, strokeMultiplier: strokeMultiplier);

  PenProperty.fromJson(Map<String, dynamic> json)
      : color = json['color'] != null ? Color(json['color']) : Colors.black,
        fill = json['fill'] ?? false,
        super.fromJson(json);

  @override
  PenProperty copyWith(
          {Color? color,
          bool? fill,
          double? strokeWidth,
          double? strokeMultiplier}) =>
      PenProperty(
          color: color ?? this.color,
          fill: fill ?? this.fill,
          strokeMultiplier: strokeMultiplier ?? this.strokeMultiplier,
          strokeWidth: strokeWidth ?? this.strokeWidth);

  @override
  Map<String, dynamic> toJson() => {
        'color': color.value,
        'strokeWidth': strokeWidth,
        'strokeMultiplier': strokeMultiplier,
        'fill': fill
      };
}
