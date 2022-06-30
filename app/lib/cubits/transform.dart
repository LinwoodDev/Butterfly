import 'package:butterfly/models/waypoint.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CameraTransform extends Equatable {
  final Offset position;
  final double size;

  const CameraTransform([this.position = Offset.zero, this.size = 1]);

  CameraTransform withPosition(Offset position) =>
      CameraTransform(position, size);

  CameraTransform withSize(double size, [Offset cursor = Offset.zero]) {
    // Set size and focus on cursor if provided
    final double newSize = size.clamp(0.1, 1000);
    var mx = localToGlobal(cursor);
    mx = (mx + position) * newSize;

    return CameraTransform(
      position + (cursor - mx) / newSize,
      newSize,
    );
  }

  Offset localToGlobal(Offset local) => local / size - position;
  Offset globalToLocal(Offset global) => (global + position) * size;

  Rect get rect => Rect.fromLTWH(
        position.dx,
        position.dy,
        size,
        size,
      );

  @override
  List<Object?> get props => [position, size];
}

class TransformCubit extends Cubit<CameraTransform> {
  TransformCubit() : super(const CameraTransform());

  void move(Offset delta) => emit(state.withPosition(state.position + delta));

  void setPosition(Offset position) => emit(state.withPosition(position));

  void zoom(double delta, [Offset cursor = Offset.zero]) =>
      emit(state.withSize(state.size * delta, cursor));

  void focus(Offset cursor) => emit(state.withSize(state.size, cursor));

  void reset() => emit(const CameraTransform());

  void size(double size, [Offset cursor = Offset.zero]) =>
      emit(state.withSize(size, cursor));

  void moveToWaypoint(Waypoint waypoint) => emit(state
      .withPosition(waypoint.position)
      .withSize(waypoint.scale ?? state.size));
}
