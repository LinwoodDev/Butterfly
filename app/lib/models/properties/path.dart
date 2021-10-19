class PathProperty {
  final double strokeWidth;
  final double strokeMultiplier;

  const PathProperty({this.strokeWidth = 5, this.strokeMultiplier = 1});
  PathProperty.fromJson(Map<String, dynamic> json)
      : strokeWidth = json['strokeWidth'] ?? 5,
        strokeMultiplier = json['strokeMultiplier'] ?? 1;

  Map<String, dynamic> toJson() =>
      {"strokeWidth": strokeWidth, "strokeMultiplier": strokeMultiplier};

  PathProperty copyWith({double? strokeWidth, double? strokeMultiplier}) => PathProperty(
      strokeMultiplier: strokeMultiplier ?? this.strokeMultiplier,
      strokeWidth: strokeWidth ?? this.strokeWidth);
}
