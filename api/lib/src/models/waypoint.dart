import 'dart:math';

import '../converter/core.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'waypoint.g.dart';
part 'waypoint.freezed.dart';

@freezed
@JsonSerializable()
class const Waypoint(
  final String? name,
  @DoublePointJsonConverter() final Point<double> position, [
  final double? scale,
]) with _$Waypoint {
  static const String? originName = null;
  static const Waypoint defaultOrigin = .new(originName, Point(0, 0), 1);

  static Waypoint fromJson(Map json) =>
      _$WaypointFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$WaypointToJson(this);
}
