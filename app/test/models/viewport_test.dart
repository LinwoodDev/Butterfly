import 'package:butterfly/models/viewport.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('viewport snapshots use identity equality', () {
    const viewport = CameraViewport.unbaked(width: 100, height: 100);

    expect(viewport.copyWith(), isNot(equals(viewport)));
    expect(viewport, equals(viewport));
  });
}
