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
  late int fallbacks;
  late List<PointerEvent> fallbackEvents;

  setUp(() {
    manager = PointerShortcutManager(
      repeatTimeout: const Duration(milliseconds: 500),
      repeatResolveDelay: const Duration(milliseconds: 10),
      multiFingerTimeout: const Duration(milliseconds: 500),
      movementTolerance: 18,
    );
    triggers = [];
    fallbacks = 0;
    fallbackEvents = [];
  });

  tearDown(() => manager.dispose());

  PointerShortcutEventResult pointerDown({
    required int pointer,
    required PointerDeviceKind kind,
    required Duration timeStamp,
    Offset position = Offset.zero,
    int buttons = kPrimaryButton,
  }) {
    return manager.pointerDown(
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

  PointerShortcutEventResult pointerUp({
    required int pointer,
    required PointerDeviceKind kind,
    required Duration timeStamp,
    Offset position = Offset.zero,
  }) {
    return manager.pointerUp(
      PointerUpEvent(
        pointer: pointer,
        kind: kind,
        timeStamp: timeStamp,
        position: position,
      ),
      getConfiguration: () => configuration,
      onTriggered: (shortcutId, event) => triggers.add(shortcutId),
      onFallback: (events) {
        fallbacks++;
        fallbackEvents.addAll(events);
      },
    );
  }

  test('merges hover button state into stylus pointer down events', () {
    expect(
      mergeStylusButtonState(
        kind: PointerDeviceKind.stylus,
        eventButtons: 0,
        hoverButtons: kSecondaryStylusButton,
      ),
      kSecondaryStylusButton,
    );
    expect(
      mergeStylusButtonState(
        kind: PointerDeviceKind.stylus,
        eventButtons: kPrimaryStylusButton,
        hoverButtons: kSecondaryStylusButton,
      ),
      kPrimaryStylusButton | kSecondaryStylusButton,
    );
    expect(
      mergeStylusButtonState(
        kind: PointerDeviceKind.mouse,
        eventButtons: kPrimaryMouseButton,
        hoverButtons: kSecondaryStylusButton,
      ),
      kPrimaryMouseButton,
    );
  });

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
    expect(fallbacks, 0);
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
    final moveResult = manager.pointerMove(
      const PointerMoveEvent(
        pointer: 1,
        kind: PointerDeviceKind.mouse,
        position: Offset(20, 0),
      ),
    );
    expect(moveResult.consumed, isTrue);
    expect(moveResult.releasedEvents, [
      isA<PointerDownEvent>(),
      isA<PointerMoveEvent>(),
    ]);
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

  test('releases a single tap after the repeat timeout', () async {
    manager.dispose();
    manager = PointerShortcutManager(
      repeatTimeout: const Duration(milliseconds: 10),
      repeatResolveDelay: const Duration(milliseconds: 5),
      multiFingerTimeout: const Duration(milliseconds: 10),
      movementTolerance: 18,
    );

    pointerDown(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: Duration.zero,
    );
    pointerUp(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: const Duration(milliseconds: 5),
    );
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(triggers, isEmpty);
    expect(fallbacks, 1);
    expect(fallbackEvents, [isA<PointerDownEvent>(), isA<PointerUpEvent>()]);
  });

  test('keeps repeated tap continuations in the same buffer', () {
    pointerDown(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: Duration.zero,
    );
    pointerUp(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: const Duration(milliseconds: 20),
    );

    final result = pointerDown(
      pointer: 2,
      kind: PointerDeviceKind.mouse,
      timeStamp: const Duration(milliseconds: 80),
      position: const Offset(10, 0),
    );

    expect(result.consumed, isTrue);
    expect(result.releasedEvents, isEmpty);
  });

  test('releases a buffered tap before a non-continuation', () {
    pointerDown(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: Duration.zero,
    );
    pointerUp(
      pointer: 1,
      kind: PointerDeviceKind.mouse,
      timeStamp: const Duration(milliseconds: 20),
    );

    final result = pointerDown(
      pointer: 2,
      kind: PointerDeviceKind.mouse,
      timeStamp: const Duration(milliseconds: 80),
      position: const Offset(20, 0),
    );

    expect(result.consumed, isTrue);
    expect(result.releasedEvents, [
      isA<PointerDownEvent>(),
      isA<PointerUpEvent>(),
    ]);
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
