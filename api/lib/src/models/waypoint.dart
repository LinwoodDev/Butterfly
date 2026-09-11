import 'dart:math';

import '../converter/core.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'waypoint.g.dart';
part 'waypoint.freezed.dart';

@freezed
@JsonSerializable()
class Waypoint with _$Waypoint {
  static const String? originName = null;
  static const Waypoint defaultOrigin = Waypoint(originName, Point(0, 0), 1);

  const new(this.name, this.position, [this.scale]);

  final String? name;
  @DoublePointJsonConverter()
  final Point<double> position;
  final double? scale;

  factory Waypoint.fromJson(Map<String, dynamic> json) =>
      _$WaypointFromJson(json);

  Map<String, dynamic> toJson() => _$WaypointToJson(this);
}
