import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Waypoint extends Equatable {
  final String name;
  final Offset position;
  final double? scale;

  static const Waypoint origin = Waypoint('', Offset.zero, 1);

  const Waypoint(this.name, this.position, [this.scale]);

  Waypoint.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        position = Offset(json['position']['x'], json['position']['y']),
        scale = json['scale'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'position': {'x': position.dx, 'y': position.dy},
        'scale': scale
      };

  @override
  List<Object?> get props => [name, position, scale];
}
