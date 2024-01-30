import 'dart:math';

import 'package:butterfly/helpers/point.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kMinZoom = 0.1;
const kMaxZoom = 10.0;

@immutable
class CameraTransform extends Equatable {
  final Offset position;
  final double size;

  const CameraTransform([this.position = Offset.zero, this.size = 1]);

  CameraTransform withPosition(Offset position) =>
      CameraTransform(position, size);

  CameraTransform withPointPosition(Point<double> position) =>
      CameraTransform(position.toOffset(), size);

  CameraTransform withSize(double size, [Offset cursor = Offset.zero]) {
    // Set size and focus on cursor if provided
    final double newSize = size.clamp(kMinZoom, kMaxZoom);
    var mx = localToGlobal(cursor);
    mx = (mx + position) * newSize;

    return CameraTransform(
      position + (cursor - mx) / newSize,
      newSize,
    );
  }

  Offset localToGlobal(Offset local) => local / size - position;
  Offset globalToLocal(Offset global) => (global + position) * size;

  @override
  List<Object?> get props => [position, size];
}

class TransformCubit extends Cubit<CameraTransform> {
  TransformCubit() : super(const CameraTransform());

  void move(Offset delta) => emit(state.withPosition(state.position + delta));

  void teleport(Offset position, [double? scale]) =>
      emit(state.withPosition(position).withSize(scale ?? state.size));

  void zoom(double delta, [Offset cursor = Offset.zero]) =>
      emit(state.withSize(state.size * delta, cursor));

  void focus(Offset cursor) => emit(state.withSize(state.size, cursor));

  void reset() => emit(const CameraTransform());

  void size(double size, [Offset cursor = Offset.zero]) =>
      emit(state.withSize(size, cursor));

  void teleportToWaypoint(Waypoint waypoint) =>
      teleport(-waypoint.position.toOffset(), waypoint.scale ?? state.size);

  void teleportToArea(Area area, [Size? screen]) {
    double? size;
    var position = area.position.toOffset();
    if (screen != null) {
      final width = screen.width / area.width;
      final height = screen.height / area.height;
      size = min(width, height).clamp(kMinZoom, kMaxZoom);
      position += Offset((area.width - screen.width / size) / 2,
          (area.height - screen.height / size) / 2);
    }
    teleport(-position, size);
  }
}
