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

  CameraTransform withSize(double size, [Offset? cursor]) {
    if (cursor != null) {
      final offset = position + cursor;
      return CameraTransform(
        offset - (offset - position) * (size / this.size),
        size,
      );
    } else {
      // Return new CameraTransform
      return CameraTransform(position, size);
    }
  }

  Offset localToGlobal(Offset local) => local / size - position;

  @override
  List<Object?> get props => [position, size];
}

class TransformCubit extends Cubit<CameraTransform> {
  TransformCubit() : super(const CameraTransform());

  void move(Offset delta) => emit(state.withPosition(state.position + delta));

  void zoom(double delta, [Offset? cursor]) =>
      emit(state.withSize(state.size + delta, cursor));

  void focus(Offset cursor) => emit(state.withSize(state.size, cursor));

  void reset() => emit(const CameraTransform());

  void size(double size) => emit(state.withSize(size));

  void moveToWaypoint(Waypoint waypoint) => emit(state
      .withPosition(waypoint.position)
      .withSize(waypoint.scale ?? state.size));
}
