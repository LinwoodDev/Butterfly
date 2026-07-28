import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/pointer_shortcuts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const configuration = InputConfiguration(
    doubleLeftMouseShortcut: 'double-left',
    tripleLeftMouseShortcut: 'triple-left',
    doubleBackMouseShortcut: 'double-back',
    tripleBackMouseShortcut: 'triple-back',
    doubleTouchShortcut: 'double-touch',
    tripleTouchShortcut: 'triple-touch',
    twoFingerTouchShortcut: 'two-finger',
    threeFingerTouchShortcut: 'three-finger',
  );
  late PointerShortcutManager manager;
  late List<String> triggers;

  setUp(() {
    manager = PointerShortcutManager(
      repeatTimeout: const Duration(milliseconds: 500),
      repeatResolveDelay: const Duration(milliseconds: 10),
      multiFingerTimeout: const Duration(milliseconds: 500),
      movementTolerance: 18,
    );
    triggers = [];
  });

  tearDown(() => manager.dispose());

  void pointerDown({
    required int pointer,
    required PointerDeviceKind kind,
    required Duration timeStamp,
    Offset position = Offset.zero,
    int buttons = kPrimaryButton,
  }) {
    manager.pointerDown(
      PointerDownEvent(
        pointer: pointer,
        kind: kind,
        timeStamp: timeStamp,
        position: position,
        buttons: buttons,
      ),
      configuration,
    );
  }

  void pointerUp({
    required int pointer,
    required PointerDeviceKind kind,
    required Duration timeStamp,
    Offset position = Offset.zero,
  }) {
    manager.pointerUp(
      PointerUpEvent(
        pointer: pointer,
        kind: kind,
        timeStamp: timeStamp,
        position: position,
      ),
      getConfiguration: () => configuration,
      onTriggered: (shortcutId, event) => triggers.add(shortcutId),
    );
  }

  test('recognizes repeated mouse button clicks', () async {
    pointerDown(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: Duration.zero,
      buttons: kBackMouseButton,
    );
    pointerUp(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: const Duration(milliseconds: 20),
    );
    pointerDown(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: const Duration(milliseconds: 80),
      buttons: kBackMouseButton,
    );
    pointerUp(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: const Duration(milliseconds: 100),
    );
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(triggers, ['double-back']);
  });

  test('triple clicks supersede pending double clicks', () async {
    for (var index = 0; index < 3; index++) {
      final start = Duration(milliseconds: index * 40);
      pointerDown(pointer: 1, kind: PointerDeviceKind.mouse, timeStamp: start);
      pointerUp(
        pointer: 1,
        kind: PointerDeviceKind.mouse,
        timeStamp: start + const Duration(milliseconds: 10),
      );
    }
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(triggers, ['triple-left']);
  });

  test('rejects repeated clicks that move like a drag', () async {
    pointerDown(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: Duration.zero,
    );
    manager.pointerMove(
      const PointerMoveEvent(
        pointer: 1,
        kind: PointerDeviceKind.mouse,
        position: Offset(20, 0),
      ),
    );
    pointerUp(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      position: const Offset(20, 0),
      timeStamp: const Duration(milliseconds: 20),
    );
    pointerDown(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: const Duration(milliseconds: 80),
    );
    pointerUp(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: const Duration(milliseconds: 100),
    );
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(triggers, isEmpty);
  });

  test('recognizes a simultaneous two-finger tap', () {
    pointerDown(
      pointer: 1,
      kind: PointerDeviceKind.touch,
      timeStamp: Duration.zero,
    );
    pointerDown(
      pointer: 2,
      kind: PointerDeviceKind.touch,
      position: const Offset(30, 0),
      timeStamp: const Duration(milliseconds: 40),
    );
    pointerUp(
      pointer: 1,
      kind: PointerDeviceKind.touch,
      position: const Offset(1, 0),
      timeStamp: const Duration(milliseconds: 100),
    );
    pointerUp(
      pointer: 2,
      kind: PointerDeviceKind.touch,
      position: const Offset(31, 0),
      timeStamp: const Duration(milliseconds: 120),
    );

    expect(triggers, ['two-finger']);
  });

  test('recognizes a simultaneous three-finger tap', () {
    for (var pointer = 1; pointer <= 3; pointer++) {
      pointerDown(
        pointer: pointer,
        kind: PointerDeviceKind.touch,
        position: Offset(pointer * 30, 0),
        timeStamp: Duration.zero,
      );
    }
    for (var pointer = 1; pointer <= 3; pointer++) {
      pointerUp(
        pointer: pointer,
        kind: PointerDeviceKind.touch,
        position: Offset(pointer * 30, 0),
        timeStamp: const Duration(milliseconds: 100),
      );
    }

    expect(triggers, ['three-finger']);
  });

  test('does not confuse sequential taps with a multi-finger tap', () async {
    for (var pointer = 1; pointer <= 2; pointer++) {
      final start = Duration(milliseconds: pointer * 100);
      pointerDown(
        pointer: pointer,
        kind: PointerDeviceKind.touch,
        timeStamp: start,
      );
      pointerUp(
        pointer: pointer,
        kind: PointerDeviceKind.touch,
        timeStamp: start + const Duration(milliseconds: 20),
      );
    }
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(triggers, ['double-touch']);
  });

  test('rejects moved, held, and canceled multi-finger gestures', () {
    pointerDown(
      pointer: 1,
      kind: PointerDeviceKind.touch,
      timeStamp: Duration.zero,
    );
    pointerDown(
      pointer: 2,
      kind: PointerDeviceKind.touch,
      position: const Offset(30, 0),
      timeStamp: Duration.zero,
    );
    manager.pointerMove(
      const PointerMoveEvent(
        pointer: 1,
        kind: PointerDeviceKind.touch,
        position: Offset(20, 0),
      ),
    );
    pointerUp(
      pointer: 1,
      kind: PointerDeviceKind.touch,
      position: const Offset(20, 0),
      timeStamp: const Duration(milliseconds: 100),
    );
    pointerUp(
      pointer: 2,
      kind: PointerDeviceKind.touch,
      position: const Offset(30, 0),
      timeStamp: const Duration(milliseconds: 120),
    );

    pointerDown(
      pointer: 3,
      kind: PointerDeviceKind.touch,
      timeStamp: Duration.zero,
    );
    pointerDown(
      pointer: 4,
      kind: PointerDeviceKind.touch,
      position: const Offset(30, 0),
      timeStamp: Duration.zero,
    );
    pointerUp(
      pointer: 3,
      kind: PointerDeviceKind.touch,
      timeStamp: const Duration(milliseconds: 550),
    );
    pointerUp(
      pointer: 4,
      kind: PointerDeviceKind.touch,
      position: const Offset(30, 0),
      timeStamp: const Duration(milliseconds: 560),
    );

    pointerDown(
      pointer: 5,
      kind: PointerDeviceKind.touch,
      timeStamp: Duration.zero,
    );
    pointerDown(
      pointer: 6,
      kind: PointerDeviceKind.touch,
      position: const Offset(30, 0),
      timeStamp: Duration.zero,
    );
    manager.pointerCancel(
      const PointerCancelEvent(pointer: 5, kind: PointerDeviceKind.touch),
    );
    pointerUp(
      pointer: 6,
      kind: PointerDeviceKind.touch,
      position: const Offset(30, 0),
      timeStamp: const Duration(milliseconds: 100),
    );

    expect(triggers, isEmpty);
  });
}
