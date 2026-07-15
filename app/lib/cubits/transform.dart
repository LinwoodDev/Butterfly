import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_runtime.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/views/navigator/constants.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transform.freezed.dart';

const kMinZoom = 0.1;
const kMaxZoom = 10.0;
const kRoundPrecision = 3;
const kDrag = 0.001;
const kBoundsSnapBackDuration = 0.18;

@freezed
sealed class FrictionState with _$FrictionState {
  const factory FrictionState(
    Offset beginOffset,
    double beginSize,
    DateTime lastUpdate,
    double duration,
  ) = _FrictionState;
}

@freezed
sealed class CameraTransform with _$CameraTransform {
  const CameraTransform._();

  const factory CameraTransform([
    @Default(1) double pixelRatio,
    @Default(Offset.zero) Offset position,
    @Default(1) double size,
    @Default(0) double rotation,
    FrictionState? friction,
  ]) = _CameraTransform;

  CameraTransform withPosition(Offset position) =>
      CameraTransform(pixelRatio, position, size, rotation);

  CameraTransform withPointPosition(Point<double> position) =>
      CameraTransform(pixelRatio, position.toOffset(), size, rotation);

  CameraTransform withSize(double size, [Offset cursor = Offset.zero]) {
    // Set size and focus on cursor if provided
    final double newSize = size.clamp(kMinZoom, kMaxZoom);
    return CameraTransform(
      pixelRatio,
      localToGlobal(cursor) - cursor.rotate(Offset.zero, -rotation) / newSize,
      newSize,
      rotation,
    );
  }

  CameraTransform withRotation(double rotation, [Offset cursor = Offset.zero]) {
    final normalized = (rotation + pi) % (2 * pi) - pi;
    return CameraTransform(
      pixelRatio,
      localToGlobal(cursor) - cursor.rotate(Offset.zero, -normalized) / size,
      size,
      normalized,
    );
  }

  Offset localToGlobal(Offset local) =>
      local.rotate(Offset.zero, -rotation) / size + position;

  Offset globalToLocal(Offset global) =>
      ((global - position) * size).rotate(Offset.zero, rotation);

  Offset localToGlobalDelta(Offset delta) =>
      delta.rotate(Offset.zero, -rotation) / size;

  Rect localToGlobalRect(Rect rect) => _transformRect(rect, localToGlobal);

  Rect globalToLocalRect(Rect rect) => _transformRect(rect, globalToLocal);

  Rect _transformRect(Rect rect, Offset Function(Offset) transform) {
    final topLeft = transform(rect.topLeft);
    final topRight = transform(rect.topRight);
    final bottomLeft = transform(rect.bottomLeft);
    final bottomRight = transform(rect.bottomRight);
    return Rect.fromLTRB(
      min(min(topLeft.dx, topRight.dx), min(bottomLeft.dx, bottomRight.dx)),
      min(min(topLeft.dy, topRight.dy), min(bottomLeft.dy, bottomRight.dy)),
      max(max(topLeft.dx, topRight.dx), max(bottomLeft.dx, bottomRight.dx)),
      max(max(topLeft.dy, topRight.dy), max(bottomLeft.dy, bottomRight.dy)),
    );
  }

  void applyToCanvas(Canvas canvas) {
    canvas.rotate(rotation);
    canvas.scale(size);
    canvas.translate(-position.dx, -position.dy);
  }

  double _getFinalTime(
    double velocity,
    double drag, {
    double effectivelyMotionless = 10,
  }) {
    final speed = velocity.abs();
    if (speed <= effectivelyMotionless) {
      return 0;
    }
    return log(effectivelyMotionless / speed) / log(drag);
  }

  FrictionSimulation _getSimulation(double velocity) =>
      FrictionSimulation(kDrag, 0, velocity);

  Offset _clampPosition(Offset position, Rect bounds) => Offset(
    position.dx.clamp(bounds.left, bounds.right),
    position.dy.clamp(bounds.top, bounds.bottom),
  );

  CameraTransform withFriction(
    Offset velocityPosition,
    double velocitySize, {
    Rect? positionBounds,
  }) {
    final simX = _getSimulation(velocityPosition.dx);
    final finalX = simX.finalX;
    final simY = _getSimulation(velocityPosition.dy);
    final finalY = simY.finalX;
    final durationPosition = _getFinalTime(velocityPosition.distance, kDrag);
    final finalPos = Offset(finalX, finalY);
    final simScale = _getSimulation(velocitySize);
    final finalSize = simScale.finalX;
    final durationSize = _getFinalTime(velocitySize, kDrag);
    final finalPosition = positionBounds == null
        ? position - finalPos
        : _clampPosition(position - finalPos, positionBounds);
    final finalScale = (size + finalSize).clamp(kMinZoom, kMaxZoom);
    var duration = max(durationPosition, durationSize);
    if (!duration.isFinite) {
      duration = 0;
    }
    if (duration <= 0) {
      if (finalPosition == position && finalScale == size) {
        return this;
      }
      duration = kBoundsSnapBackDuration;
    }
    final frictionState = FrictionState(
      finalPosition - position,
      velocitySize == 0 ? 0 : 1 / velocitySize,
      DateTime.now(),
      duration,
    );

    return CameraTransform(
      pixelRatio,
      finalPosition,
      finalScale,
      rotation,
      frictionState,
    );
  }

  CameraTransform withFrictionless(Offset position, double size) {
    return CameraTransform(
      pixelRatio,
      this.position - position,
      this.size - size,
      rotation,
      null,
    );
  }

  CameraTransform improve(RenderResolution resolution, Rect rect) {
    return CameraTransform(pixelRatio, rect.topLeft, size, 0, friction);
  }
}

class TransformCubit extends Cubit<CameraTransform> {
  TransformCubit(double pixelRatio, [Offset? position])
    : super(CameraTransform(pixelRatio, position ?? Offset.zero));

  void move(Offset delta) => emit(state.withPosition(state.position + delta));

  void teleport(Offset position, [double? scale, double? rotation]) => emit(
    state
        .withPosition(position)
        .withSize(scale ?? state.size)
        .withRotation(rotation ?? state.rotation),
  );

  void zoom(double delta, [Offset cursor = Offset.zero]) =>
      emit(state.withSize(state.size * delta, cursor));

  void focus(Offset cursor) => emit(state.withSize(state.size, cursor));

  void rotate(double delta, [Offset cursor = Offset.zero]) =>
      emit(state.withRotation(state.rotation + delta, cursor));

  void reset() => emit(CameraTransform(state.pixelRatio));

  void size(double size, [Offset cursor = Offset.zero]) =>
      emit(state.withSize(size, cursor));

  void teleportToWaypoint(Waypoint waypoint) =>
      teleport(waypoint.position.toOffset(), waypoint.scale ?? state.size);

  void teleportToArea(
    Area area, [
    Size? screen,
    RenderResolution resolution = RenderResolution.performance,
  ]) {
    if (screen == null || area.width <= 0 || area.height <= 0) {
      teleport(area.position.toOffset(), state.size);
      return;
    }

    final effectiveScreen = screen / resolution.multiplier;
    final width = effectiveScreen.width / area.width;
    final height = effectiveScreen.height / area.height;
    final size = min(width, height).clamp(kMinZoom, kMaxZoom);
    final position =
        area.rect.center - effectiveScreen.center(Offset.zero) / size;
    teleport(position, size);
  }

  void slide(
    Offset velocityPosition,
    double velocitySize, {
    Rect? positionBounds,
  }) => emit(
    state.withFriction(
      velocityPosition,
      velocitySize,
      positionBounds: positionBounds,
    ),
  );

  Rect getContentRect(RendererCubit rendererCubit, [Area? currentArea]) {
    if (currentArea != null) {
      return currentArea.rect;
    }
    final renderers = rendererCubit.renderers;
    if (renderers.isEmpty) {
      return Rect.zero;
    }

    var minX = double.infinity;
    var minY = double.infinity;
    var maxX = double.negativeInfinity;
    var maxY = double.negativeInfinity;

    for (final renderer in renderers) {
      final rect = renderer.expandedRect;
      if (rect != null) {
        minX = min(minX, rect.left);
        minY = min(minY, rect.top);
        maxX = max(maxX, rect.right);
        maxY = max(maxY, rect.bottom);
      }
    }

    if (minX == double.infinity) {
      return Rect.zero;
    }

    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  bool _isNavigationRailVisible(EditorRuntimeContext runtime) {
    final settings = runtime.settingsCubit.state;
    final viewport = runtime.rendererCubit.state.cameraViewport;
    return settings.navigationRail &&
        settings.navigatorPosition == NavigatorPosition.left &&
        runtime.inputCubit.state.hideUi == HideState.visible &&
        (viewport.width ?? 0) >= LeapBreakpoints.expanded &&
        (viewport.height ?? 0) >= 400;
  }

  Rect? calculateViewportBounds({
    required EditorRuntimeContext runtime,
    Area? currentArea,
    CameraTransform? customTransform,
  }) {
    final settings = runtime.settingsCubit.state;
    var multiplier = settings.limitViewportMultiplier;
    final positive = settings.limitViewportPositive;

    if (multiplier == null && !positive && currentArea == null) return null;

    final viewport = runtime.rendererCubit.state.cameraViewport;
    final transform = customTransform ?? state;
    final navigationRailOffset = _isNavigationRailVisible(runtime)
        ? kNavigationRailWidth / transform.size
        : 0.0;
    final size =
        Size(
          ((viewport.width ?? 0) / transform.size) - navigationRailOffset,
          (viewport.height ?? 0) / transform.size,
        ) /
        settings.renderResolution.multiplier;

    final contentRect = getContentRect(runtime.rendererCubit, currentArea);

    double minX = double.negativeInfinity;
    double minY = double.negativeInfinity;
    double maxX = double.infinity;
    double maxY = double.infinity;

    if (multiplier != null || currentArea != null) {
      multiplier ??= 1;
      final padX = size.width * multiplier;
      final padY = size.height * multiplier;

      minX = contentRect.left - padX;
      minY = contentRect.top - padY;
      maxX = contentRect.right - size.width + padX;
      maxY = contentRect.bottom - size.height + padY;

      if (minX > maxX) {
        final mid = (minX + maxX) / 2;
        minX = mid;
        maxX = mid;
      }
      if (minY > maxY) {
        final mid = (minY + maxY) / 2;
        minY = mid;
        maxY = mid;
      }
    }

    if (positive && currentArea == null) {
      minX = max(-navigationRailOffset, minX);
      minY = max(0.0, minY);
      maxX = max(-navigationRailOffset, maxX);
      maxY = max(0.0, maxY);
    }

    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  CameraTransform _clampTransform({
    required CameraTransform transform,
    required EditorRuntimeContext runtime,
  }) {
    final bounds = calculateViewportBounds(
      runtime: runtime,
      customTransform: transform,
    );
    if (bounds == null) return transform;
    return transform.withPosition(
      Offset(
        transform.position.dx.clamp(bounds.left, bounds.right),
        transform.position.dy.clamp(bounds.top, bounds.bottom),
      ),
    );
  }

  Area? getRelativeArea({
    required DocumentLoadSuccess docState,
    required EditorViewCubit viewCubit,
    required Area currentArea,
    required int dx,
    required int dy,
    bool? exact,
  }) {
    if (dx == 0 && dy == 0) return null;

    final rect = currentArea.rect.translate(
      dx.toDouble() * currentArea.rect.width,
      dy.toDouble() * currentArea.rect.height,
    );

    return docState.page.areas.firstWhereOrNull((area) {
      final currentAreaRect = area.rect;
      if (exact ?? viewCubit.state.areaNavigatorExact) {
        return (currentAreaRect.top - rect.top).abs() <
                precisionErrorTolerance &&
            (currentAreaRect.left - rect.left).abs() <
                precisionErrorTolerance &&
            (currentAreaRect.width - rect.width).abs() <
                precisionErrorTolerance &&
            (currentAreaRect.height - rect.height).abs() <
                precisionErrorTolerance;
      }
      return currentAreaRect.overlaps(rect.deflate(precisionErrorTolerance));
    });
  }

  void teleportToAreaEdge({
    required Area area,
    required int dx,
    required int dy,
    required EditorRuntimeContext runtime,
  }) {
    final newBounds = calculateViewportBounds(
      runtime: runtime,
      currentArea: area,
    );
    if (newBounds == null) return;

    final pos = state.position;
    double newX = pos.dx;
    double newY = pos.dy;
    if (dx > 0) {
      newX = newBounds.left;
    } else if (dx < 0) {
      newX = newBounds.right;
    } else {
      newX = newX.clamp(newBounds.left, newBounds.right);
    }
    if (dy > 0) {
      newY = newBounds.top;
    } else if (dy < 0) {
      newY = newBounds.bottom;
    } else {
      newY = newY.clamp(newBounds.top, newBounds.bottom);
    }
    teleport(Offset(newX, newY));
  }

  Future<void> navigateToRelativeArea({
    required DocumentBloc bloc,
    required EditorRuntimeContext runtime,
    required int dx,
    required int dy,
    Future<String?> Function()? createAreaName,
  }) async {
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;

    final current = docState.currentArea;
    if (current == null) return;

    var area = getRelativeArea(
      docState: docState,
      viewCubit: runtime.viewCubit,
      currentArea: current,
      dx: dx,
      dy: dy,
    );
    if (area != null) {
      bloc.add(CurrentAreaChanged(area.name));
      teleportToAreaEdge(area: area, dx: dx, dy: dy, runtime: runtime);
      return;
    }

    if (!runtime.viewCubit.state.areaNavigatorCreate ||
        createAreaName == null) {
      return;
    }
    final name = await createAreaName();
    if (name == null) return;

    final rect = current.rect.translate(
      dx.toDouble() * current.rect.width,
      dy.toDouble() * current.rect.height,
    );

    final newArea = Area(
      position: rect.topLeft.toPoint(),
      height: rect.height,
      width: rect.width,
      name: name,
    );
    bloc.add(AreasCreated([AreaPreset(area: newArea)]));
    bloc.add(CurrentAreaChanged(name));
    teleportToAreaEdge(area: newArea, dx: dx, dy: dy, runtime: runtime);
  }

  void moveConstrained(
    Offset delta, {
    required EditorRuntimeContext runtime,
    DocumentBloc? bloc,
    bool force = false,
    Area? currentArea,
  }) {
    final locks = runtime.viewCubit.state.locks;
    if (!force) {
      if (locks.lockHorizontal) delta = Offset(0, delta.dy);
      if (locks.lockVertical) delta = Offset(delta.dx, 0);

      final bounds = calculateViewportBounds(
        runtime: runtime,
        currentArea: currentArea,
      );
      if (bounds != null) {
        final pos = state.position;
        var newPos = pos + delta;
        final clampedPos = Offset(
          newPos.dx.clamp(bounds.left, bounds.right),
          newPos.dy.clamp(bounds.top, bounds.bottom),
        );

        final docState = bloc?.state;
        if (currentArea != null &&
            docState is DocumentLoadSuccess &&
            (clampedPos.dx != newPos.dx || clampedPos.dy != newPos.dy)) {
          int dx = 0;
          int dy = 0;
          if (newPos.dx < bounds.left) {
            dx = -1;
          } else if (newPos.dx > bounds.right) {
            dx = 1;
          }

          if (newPos.dy < bounds.top) {
            dy = -1;
          } else if (newPos.dy > bounds.bottom) {
            dy = 1;
          }

          if ((dx != 0 || dy != 0) &&
              runtime.settingsCubit.state.hasFlag('edgePanAreaSwitching')) {
            final area = getRelativeArea(
              docState: docState,
              viewCubit: runtime.viewCubit,
              currentArea: currentArea,
              dx: dx,
              dy: dy,
            );
            if (area != null) {
              bloc?.add(CurrentAreaChanged(area.name));
              teleportToAreaEdge(area: area, dx: dx, dy: dy, runtime: runtime);
              return;
            }
          }
        }

        delta = clampedPos - pos;
      }
    }

    if (delta.dx == 0 && delta.dy == 0) {
      return;
    }
    move(delta);
  }

  void zoomConstrained(
    double delta, {
    required EditorRuntimeContext runtime,
    Offset cursor = Offset.zero,
    bool force = false,
  }) {
    final locks = runtime.viewCubit.state.locks;
    if (locks.lockZoom && !force) {
      delta = 1;
    }
    if (delta == 1) {
      return;
    }
    if (force) {
      zoom(delta, cursor);
      return;
    }
    final transform = state.withSize(state.size * delta, cursor);
    final clamped = _clampTransform(transform: transform, runtime: runtime);
    teleport(clamped.position, clamped.size);
  }

  void rotateConstrained(
    double delta, {
    required EditorRuntimeContext runtime,
    Offset cursor = Offset.zero,
    bool force = false,
  }) {
    if (delta == 0 || (runtime.viewCubit.state.locks.lockRotation && !force)) {
      return;
    }
    rotate(delta, cursor);
  }

  void sizeConstrained(
    double size, {
    required EditorRuntimeContext runtime,
    Offset cursor = Offset.zero,
    bool force = false,
  }) {
    final locks = runtime.viewCubit.state.locks;
    if (locks.lockZoom && !force) return;
    if (force) {
      this.size(size, cursor);
      return;
    }
    final transform = _clampTransform(
      transform: state.withSize(size, cursor),
      runtime: runtime,
    );
    teleport(transform.position, transform.size);
  }

  void slideConstrained(
    Offset positionVelocity,
    double sizeVelocity, {
    required EditorRuntimeContext runtime,
    bool force = false,
    Area? currentArea,
  }) {
    final settings = runtime.settingsCubit.state;
    if (!settings.hasFlag('smoothNavigation')) return;
    final locks = runtime.viewCubit.state.locks;
    Rect? bounds;
    var outOfBounds = false;
    if (!force) {
      if (locks.lockHorizontal) {
        positionVelocity = Offset(0, positionVelocity.dy);
      }
      if (locks.lockVertical) {
        positionVelocity = Offset(positionVelocity.dx, 0);
      }
      if (locks.lockZoom) sizeVelocity = 0;

      bounds = calculateViewportBounds(
        runtime: runtime,
        currentArea: currentArea,
      );
      if (bounds != null) {
        final pos = state.position;
        final clampedPos = Offset(
          pos.dx.clamp(bounds.left, bounds.right),
          pos.dy.clamp(bounds.top, bounds.bottom),
        );
        outOfBounds = clampedPos != pos;
        var vX = positionVelocity.dx;
        var vY = positionVelocity.dy;

        if (pos.dx >= bounds.right && vX > 0) {
          vX = 0;
        }
        if (pos.dx <= bounds.left && vX < 0) {
          vX = 0;
        }
        if (pos.dy >= bounds.bottom && vY > 0) {
          vY = 0;
        }
        if (pos.dy <= bounds.top && vY < 0) {
          vY = 0;
        }

        positionVelocity = Offset(vX, vY);
      }
    }

    if (positionVelocity.dx == 0 &&
        positionVelocity.dy == 0 &&
        sizeVelocity == 0 &&
        !outOfBounds) {
      return;
    }
    slide(positionVelocity, sizeVelocity, positionBounds: bounds);
  }
}
