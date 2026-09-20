import 'dart:math';

import 'package:butterfly_api/butterfly_api.dart';

List<int> presentationSlideFrames(AnimationTrack animation) =>
    animation.keys.entries
        .where((entry) => entry.value.breakpoint)
        .map((entry) => entry.key)
        .toList()
      ..sort();

AnimationTrack insertPresentationSlide(
  AnimationTrack animation, {
  required int afterFrame,
  required int durationFrames,
  required AnimationKey key,
}) {
  final gap = max(1, durationFrames).toInt();
  final frame = afterFrame + gap;
  final keys = <int, AnimationKey>{};
  for (final entry in animation.keys.entries) {
    keys[entry.key > afterFrame ? entry.key + gap : entry.key] = entry.value;
  }
  keys[frame] = key.copyWith(breakpoint: true);
  final duration = animation.duration > afterFrame
      ? animation.duration + gap
      : frame;
  return animation.copyWith(keys: keys, duration: duration);
}

AnimationTrack setPresentationTransitionDuration(
  AnimationTrack animation, {
  required int fromFrame,
  required int durationFrames,
}) {
  final slides = presentationSlideFrames(animation);
  final next = slides.where((frame) => frame > fromFrame).firstOrNull;
  if (next == null) return animation;
  final targetGap = max(1, durationFrames).toInt();
  final oldGap = next - fromFrame;
  final shift = targetGap - oldGap;
  if (shift == 0) return animation;
  final keys = <int, AnimationKey>{};
  final entries = animation.keys.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  for (final entry in entries) {
    var frame = entry.key;
    if (frame > fromFrame && frame <= next) {
      final progress = (frame - fromFrame) / oldGap;
      frame = fromFrame + (progress * targetGap).round();
      frame = frame.clamp(fromFrame + 1, fromFrame + targetGap);
    } else if (frame > next) {
      frame += shift;
    }
    keys[frame] = entry.value;
  }
  return animation.copyWith(
    keys: keys,
    duration: max(fromFrame + targetGap, animation.duration + shift).toInt(),
  );
}

AnimationTrack removePresentationSlide(AnimationTrack animation, int frame) {
  final slides = presentationSlideFrames(animation);
  final index = slides.indexOf(frame);
  if (index < 0 || slides.length <= 1) return animation;
  final collapse = index == 0 ? slides[1] - frame : frame - slides[index - 1];
  final keys = <int, AnimationKey>{};
  for (final entry in animation.keys.entries) {
    if (entry.key == frame) continue;
    keys[entry.key > frame ? entry.key - collapse : entry.key] = entry.value;
  }
  final lastFrame = keys.keys.fold(0, max).toInt();
  return animation.copyWith(
    keys: keys,
    duration: max(lastFrame, animation.duration - collapse).toInt(),
  );
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
