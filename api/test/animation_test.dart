import 'dart:math';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:test/test.dart';

void main() {
  group('AnimationTrack interpolation', () {
    final track = AnimationTrack(
      keys: const {
        10: AnimationKey(
          cameraPosition: Point(10, 20),
          cameraZoom: 2,
          cameraRotation: pi * 0.75,
        ),
        20: AnimationKey(
          cameraPosition: Point(30, 40),
          cameraZoom: 4,
          cameraRotation: -pi * 0.75,
        ),
      },
    );

    test('uses the first key before the animation reaches it', () {
      expect(track.interpolateCameraPosition(0), const Point<double>(10, 20));
      expect(track.interpolateCameraZoom(0), 2);
      expect(track.interpolateCameraRotation(0), closeTo(pi * 0.75, 0.0001));
    });

    test('interpolates between surrounding keys', () {
      expect(track.interpolateCameraPosition(15), const Point<double>(20, 30));
      expect(track.interpolateCameraZoom(15), 3);
      expect(track.interpolateCameraRotation(15)?.abs(), closeTo(pi, 0.0001));
    });

    test('uses the last key after the final key', () {
      expect(track.interpolateCameraPosition(30), const Point<double>(30, 40));
      expect(track.interpolateCameraZoom(30), 4);
      expect(track.interpolateCameraRotation(30), closeTo(-pi * 0.75, 0.0001));
    });

    test('rotation interpolation takes the shortest path', () {
      final halfway = track.interpolateCameraRotation(15)!;
      expect(halfway.abs(), closeTo(pi, 0.0001));
    });
  });
}
