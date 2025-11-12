import 'dart:math';

import '../converter/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'waypoint.g.dart';
part 'waypoint.freezed.dart';

@freezed
sealed class Waypoint with _$Waypoint {
  static const String? originName = null;
  static const Waypoint defaultOrigin = Waypoint(originName, Point(0, 0), 1);

  const factory Waypoint(
    String? name,
    @DoublePointJsonConverter() Point<double> position, [
    double? scale,
  ]) = _Waypoint;

  factory Waypoint.fromJson(Map<String, dynamic> json) =>
      _$WaypointFromJson(json);
}
