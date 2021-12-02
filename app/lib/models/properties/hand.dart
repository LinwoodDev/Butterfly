class HandProperty {
  final bool includeEraser;
  const HandProperty({this.includeEraser = false});
  HandProperty.fromJson(Map<String, dynamic> json)
      : includeEraser = json['includeEraser'] ?? false;

  HandProperty copyWith({bool? includeEraser}) =>
      HandProperty(includeEraser: includeEraser ?? this.includeEraser);

  Map<String, dynamic> toJson() => {'includeEraser': includeEraser};
}
