import 'dart:math';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'converter.dart';

part 'animation.freezed.dart';
part 'animation.g.dart';

class _InterpolationResult {
  final AnimationKey first, second;
  final int firstFrame, secondFrame;

  int get delta => secondFrame - firstFrame;

  const _InterpolationResult(
      this.first, this.second, this.firstFrame, this.secondFrame);
}

@freezed
class AnimationTrack with _$AnimationTrack {
  const AnimationTrack._();
  const factory AnimationTrack({
    @Default('') String name,
    @Default(<int, AnimationKey>{}) Map<int, AnimationKey> keys,
    @Default(250) int duration,
    @Default(24) int fps,
  }) = _AnimationTrack;

  factory AnimationTrack.fromJson(Map<String, dynamic> json) =>
      _$AnimationTrackFromJson(json);

  _InterpolationResult? _interpolate(
      int frame, bool Function(AnimationKey) where) {
    if (keys.isEmpty) {
      return null;
    }
    if (keys.length == 1) {
      final result = keys.values.first;
      final firstFrame = keys.keys.first;
      return _InterpolationResult(result, result, firstFrame, firstFrame);
    }
    final first = keys.entries.firstWhereOrNull(
        (entry) => entry.key <= frame && (entry.value.cameraPosition != null));

    if (first == null) {
      final result = keys.values.last;
      final firstFrame = keys.keys.last;
      return _InterpolationResult(result, result, firstFrame, firstFrame);
    }
    final second = keys.entries.firstWhereOrNull(
        (entry) => entry.key > frame && (entry.value.cameraPosition != null));
    if (second == null) {
      return _InterpolationResult(
          first.value, first.value, first.key, first.key);
    }
    return _InterpolationResult(
        first.value, second.value, first.key, second.key);
  }

  Point<double>? interpolateCameraPosition(int frame) {
    final result = _interpolate(frame, (key) => key.cameraPosition != null);
    if (result == null ||
        result.first.cameraPosition == null ||
        result.second.cameraPosition == null) {
      return null;
    }
    if (result.delta == 0) {
      return result.first.cameraPosition;
    }
    final delta = result.second.cameraPosition! - result.first.cameraPosition!;
    final offset = frame - result.firstFrame;
    final progress = offset / result.delta;
    return result.first.cameraPosition! + delta * progress;
  }

  double? interpolateCameraZoom(int frame) {
    final result = _interpolate(frame, (key) => key.cameraZoom != null);
    if (result == null ||
        result.first.cameraZoom == null ||
        result.second.cameraZoom == null) {
      return null;
    }
    if (result.delta == 0) {
      return result.first.cameraZoom;
    }
    final delta = result.second.cameraZoom! - result.first.cameraZoom!;
    final offset = frame - result.firstFrame;
    final progress = offset / result.delta;
    return result.first.cameraZoom! + delta * progress;
  }

  bool isBreakpoint(int frame) => keys[frame]?.breakPoint ?? false;
}

@freezed
class AnimationKey with _$AnimationKey {
  const AnimationKey._();

  const factory AnimationKey.camera({
    @DoublePointJsonConverter() Point<double>? cameraPosition,
    double? cameraZoom,
    @Default(false) bool breakPoint,
  }) = _AnimationKey;

  factory AnimationKey.fromJson(Map<String, dynamic> json) =>
      _$AnimationKeyFromJson(json);
}
