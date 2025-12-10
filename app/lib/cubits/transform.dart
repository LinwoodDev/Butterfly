import 'dart:math';

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kMinZoom = 0.1;
const kMaxZoom = 10.0;
const kRoundPrecision = 3;
const kDrag = 0.001;

@immutable
class FrictionState extends Equatable {
  final Offset beginOffset;
  final double beginSize;
  final DateTime lastUpdate;
  final double duration;

  const FrictionState(
    this.beginOffset,
    this.beginSize,
    this.lastUpdate,
    this.duration,
  );

  @override
  List<Object?> get props => [beginOffset, beginSize, lastUpdate];
}

@immutable
class CameraTransform extends Equatable {
  final Offset position;
  final double size;
  final FrictionState? friction;
  final double pixelRatio;

  const CameraTransform([
    this.pixelRatio = 1,
    this.position = Offset.zero,
    this.size = 1,
    this.friction,
  ]);

  CameraTransform withPosition(Offset position) =>
      CameraTransform(pixelRatio, position, size);

  CameraTransform withPointPosition(Point<double> position) =>
      CameraTransform(pixelRatio, position.toOffset(), size);

  CameraTransform withSize(double size, [Offset cursor = Offset.zero]) {
    // Set size and focus on cursor if provided
    final double newSize = size.clamp(kMinZoom, kMaxZoom);
    var mx = localToGlobal(cursor);
    mx = (mx - position) * newSize;

    return CameraTransform(
      pixelRatio,
      position + (mx - cursor) / newSize,
      newSize,
    );
  }

  Offset localToGlobal(Offset local) => local / size + position;
  Offset globalToLocal(Offset global) => (global - position) * size;

  @override
  List<Object?> get props => [position, size];

  double _getFinalTime(
    double velocity,
    double drag, {
    double effectivelyMotionless = 10,
  }) => log(effectivelyMotionless / velocity) / log(drag);

  FrictionSimulation _getSimulation(double velocity) =>
      FrictionSimulation(kDrag, 0, velocity);
  CameraTransform withFriction(Offset velocityPosition, double velocitySize) {
    final simX = _getSimulation(velocityPosition.dx);
    final finalX = simX.finalX;
    final simY = _getSimulation(velocityPosition.dy);
    final finalY = simY.finalX;
    final durationPosition = _getFinalTime(velocityPosition.distance, kDrag);
    final finalPos = Offset(finalX, finalY);
    final simScale = _getSimulation(velocitySize);
    final finalSize = simScale.finalX;
    final durationSize = _getFinalTime(velocitySize, kDrag);
    final duration = max(durationPosition, durationSize);
    if (!duration.isFinite) {
      return this;
    }

    final frictionState = FrictionState(
      -finalPos,
      1 / velocitySize,
      DateTime.now(),
      duration,
    );

    return CameraTransform(
      pixelRatio,
      position - finalPos,
      size + finalSize,
      frictionState,
    );
  }

  CameraTransform withFrictionless(Offset position, double size) {
    return CameraTransform(
      pixelRatio,
      this.position - position,
      this.size - size,
      null,
    );
  }

  CameraTransform improve(RenderResolution resolution, Rect rect) {
    return CameraTransform(pixelRatio, rect.topLeft, size, friction);
  }
}

class TransformCubit extends Cubit<CameraTransform> {
  TransformCubit(double pixelRatio, [Offset? position])
    : super(CameraTransform(pixelRatio, position ?? Offset.zero));

  void move(Offset delta) => emit(state.withPosition(state.position + delta));

  void teleport(Offset position, [double? scale]) =>
      emit(state.withPosition(position).withSize(scale ?? state.size));

  void zoom(double delta, [Offset cursor = Offset.zero]) =>
      emit(state.withSize(state.size * delta, cursor));

  void focus(Offset cursor) => emit(state.withSize(state.size, cursor));

  void reset() => emit(CameraTransform(state.pixelRatio));

  void size(double size, [Offset cursor = Offset.zero]) =>
      emit(state.withSize(size, cursor));

  void teleportToWaypoint(Waypoint waypoint) =>
      teleport(waypoint.position.toOffset(), waypoint.scale ?? state.size);

  void teleportToArea(Area area, [Size? screen]) {
    double? size;
    var position = area.position.toOffset();
    if (screen != null) {
      final width = screen.width / area.width;
      final height = screen.height / area.height;
      size = min(width, height).clamp(kMinZoom, kMaxZoom);
      position += Offset(
        (area.width - screen.width / size) / 2,
        (area.height - screen.height / size) / 2,
      );
    }
    teleport(position, size);
  }

  void slide(Offset velocityPosition, double velocitySize) =>
      emit(state.withFriction(velocityPosition, velocitySize));
}
