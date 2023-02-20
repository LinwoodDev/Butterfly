import 'dart:math';

import 'converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'waypoint.g.dart';
part 'waypoint.freezed.dart';

@freezed
class Waypoint with _$Waypoint {
  static const Waypoint origin = Waypoint('', Point(0, 0), 1);

  const factory Waypoint(
      String name, @DoublePointJsonConverter() Point<double> position,
      [double? scale]) = _Waypoint;

  factory Waypoint.fromJson(Map<String, dynamic> json) =>
      _$WaypointFromJson(json);
}
