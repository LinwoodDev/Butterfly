import 'dart:async';

import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

const _longPressShortcutId = 'long_press';

typedef PointerShortcutCallback =
    void Function(String shortcutId, PointerUpEvent event);

typedef _RepeatedTapDetails = ({
  PointerDeviceKind kind,
  int buttons,
  Offset position,
  Duration timeStamp,
  int count,
});

class PointerShortcutManager {
  final Duration repeatTimeout;
  final Duration repeatResolveDelay;
  final Duration multiFingerTimeout;
  final double movementTolerance;

  final Map<int, Offset> _initialTouchPositions = {};
  final Map<int, Offset> _repeatedDownPositions = {};
  final Set<int> _activeTouchPointers = {};
  final Set<int> _trackedRepeatedPointers = {};
  Duration? _multiFingerStartTime;
  int _maxTouchPointerCount = 0;
  bool _invalidMultiFingerGesture = false;

  Timer? _repeatTimer;
  _RepeatedTapDetails? _lastRepeatedTap;

  PointerShortcutManager({
    required this.repeatTimeout,
    required this.repeatResolveDelay,
    required this.multiFingerTimeout,
    required this.movementTolerance,
  });

  void pointerDown(PointerDownEvent event, InputConfiguration configuration) {
    var touchPointerCount = 0;
    if (event.kind == PointerDeviceKind.touch) {
      touchPointerCount = _addTouchPointer(event);
      if (touchPointerCount > 1) {
        _resetRepeatedTap();
      }
    }

    if (configuration.hasRepeatedTapShortcut(event.kind, event.buttons) &&
        (event.kind != PointerDeviceKind.touch || touchPointerCount == 1)) {
      _trackedRepeatedPointers.add(event.pointer);
      _repeatedDownPositions[event.pointer] = event.localPosition;
      _rememberRepeatedTap(event);
    }
  }

  void pointerMove(PointerMoveEvent event) {
    _checkRepeatedTapMovement(event.pointer, event.localPosition);
    if (event.kind == PointerDeviceKind.touch) {
      _checkTouchMovement(event.pointer, event.localPosition);
    }
  }

  void pointerUp(
    PointerUpEvent event, {
    required InputConfiguration Function() getConfiguration,
    required PointerShortcutCallback onTriggered,
  }) {
    _checkRepeatedTapMovement(event.pointer, event.localPosition);
    final trackedRepeatedTap = _trackedRepeatedPointers.remove(event.pointer);
    _repeatedDownPositions.remove(event.pointer);
    if (event.kind == PointerDeviceKind.touch) {
      final multiFingerTap = _removeTouchPointer(event);
      if (multiFingerTap.fingerCount case final fingerCount?) {
        _resetRepeatedTap();
        final shortcutId = getConfiguration().getMultiFingerTouchShortcut(
          fingerCount,
        );
        if (shortcutId != null) {
          onTriggered(shortcutId, event);
        }
        return;
      }
      if (multiFingerTap.wasMultiFingerGesture) {
        _resetRepeatedTap();
        return;
      }
    }
    if (trackedRepeatedTap) {
      _scheduleRepeatedTap(event, getConfiguration, onTriggered);
    }
  }

  void pointerCancel(PointerEvent event) {
    final trackedRepeatedTap = _trackedRepeatedPointers.remove(event.pointer);
    _repeatedDownPositions.remove(event.pointer);
    if (event.kind == PointerDeviceKind.touch) {
      _cancelTouchPointer(event.pointer);
    }
    if (trackedRepeatedTap) {
      _resetRepeatedTap();
    }
  }

  void reset() {
    _resetRepeatedTap();
    _resetMultiFingerTap();
  }

  void dispose() => reset();

  int _addTouchPointer(PointerDownEvent event) {
    if (_activeTouchPointers.isEmpty) {
      _resetMultiFingerTap();
      _multiFingerStartTime = event.timeStamp;
    }
    _activeTouchPointers.add(event.pointer);
    _initialTouchPositions[event.pointer] = event.localPosition;
    _maxTouchPointerCount = _maxTouchPointerCount < _activeTouchPointers.length
        ? _activeTouchPointers.length
        : _maxTouchPointerCount;
    if (_maxTouchPointerCount > 3 ||
        event.timeStamp - _multiFingerStartTime! > multiFingerTimeout) {
      _invalidMultiFingerGesture = true;
    }
    return _activeTouchPointers.length;
  }

  ({bool wasMultiFingerGesture, int? fingerCount}) _removeTouchPointer(
    PointerUpEvent event,
  ) {
    _checkTouchMovement(event.pointer, event.localPosition);
    final tracked = _activeTouchPointers.remove(event.pointer);
    _initialTouchPositions.remove(event.pointer);
    final wasMultiFingerGesture = tracked && _maxTouchPointerCount >= 2;
    if (!tracked || _activeTouchPointers.isNotEmpty) {
      return (wasMultiFingerGesture: wasMultiFingerGesture, fingerCount: null);
    }

    final startTime = _multiFingerStartTime;
    final fingerCount =
        !_invalidMultiFingerGesture &&
            startTime != null &&
            event.timeStamp - startTime <= multiFingerTimeout &&
            (_maxTouchPointerCount == 2 || _maxTouchPointerCount == 3)
        ? _maxTouchPointerCount
        : null;
    _resetMultiFingerTap();
    return (
      wasMultiFingerGesture: wasMultiFingerGesture,
      fingerCount: fingerCount,
    );
  }

  void _cancelTouchPointer(int pointer) {
    _activeTouchPointers.remove(pointer);
    _initialTouchPositions.remove(pointer);
    _invalidMultiFingerGesture = true;
    if (_activeTouchPointers.isEmpty) {
      _resetMultiFingerTap();
    }
  }

  void _checkTouchMovement(int pointer, Offset position) {
    final initialPosition = _initialTouchPositions[pointer];
    if (initialPosition == null) return;
    if ((position - initialPosition).distance > movementTolerance) {
      _invalidMultiFingerGesture = true;
    }
  }

  void _checkRepeatedTapMovement(int pointer, Offset position) {
    final initialPosition = _repeatedDownPositions[pointer];
    if (initialPosition == null) return;
    if ((position - initialPosition).distance > movementTolerance) {
      _resetRepeatedTap();
    }
  }

  void _rememberRepeatedTap(PointerDownEvent event) {
    final lastTap = _lastRepeatedTap;
    final isContinuation =
        lastTap != null &&
        lastTap.kind == event.kind &&
        lastTap.buttons == event.buttons &&
        event.timeStamp - lastTap.timeStamp <= repeatTimeout &&
        (event.position - lastTap.position).distance <= movementTolerance;
    final tapCount = isContinuation ? (lastTap.count % 3) + 1 : 1;
    _repeatTimer?.cancel();
    _lastRepeatedTap = (
      kind: event.kind,
      buttons: event.buttons,
      position: event.position,
      timeStamp: event.timeStamp,
      count: tapCount,
    );
  }

  void _scheduleRepeatedTap(
    PointerUpEvent event,
    InputConfiguration Function() getConfiguration,
    PointerShortcutCallback onTriggered,
  ) {
    final tap = _lastRepeatedTap;
    if (tap == null ||
        tap.kind != event.kind ||
        event.timeStamp - tap.timeStamp > repeatTimeout ||
        tap.count < 2) {
      return;
    }

    _repeatTimer?.cancel();
    _repeatTimer = Timer(repeatResolveDelay, () {
      _lastRepeatedTap = null;
      final shortcutId = getConfiguration().getRepeatedTapShortcut(
        tap.kind,
        tap.buttons,
        tap.count,
      );
      if (shortcutId != null) {
        onTriggered(shortcutId, event);
      }
    });
  }

  void _resetRepeatedTap() {
    _repeatTimer?.cancel();
    _repeatTimer = null;
    _lastRepeatedTap = null;
    _trackedRepeatedPointers.clear();
    _repeatedDownPositions.clear();
  }

  void _resetMultiFingerTap() {
    _initialTouchPositions.clear();
    _activeTouchPointers.clear();
    _multiFingerStartTime = null;
    _maxTouchPointerCount = 0;
    _invalidMultiFingerGesture = false;
  }
}

void invokePointerShortcut(
  BuildContext context,
  String shortcutId,
  PointerEvent event,
  EditorController controller,
  Handler Function() getHandler,
  EventContext Function() getEventContext,
) {
  if (shortcutId.isEmpty) return;
  if (shortcutId == _longPressShortcutId) {
    final handler = getHandler();
    final eventContext = getEventContext();
    controller.inputCubit.updateLastPosition(event.localPosition);
    handler.onLongPressDown(
      LongPressDownDetails(
        globalPosition: event.position,
        localPosition: event.localPosition,
        kind: event.kind,
      ),
      eventContext,
    );
    handler.onLongPressStart(
      LongPressStartDetails(
        globalPosition: event.position,
        localPosition: event.localPosition,
      ),
      eventContext,
    );
    handler.onLongPressEnd(
      LongPressEndDetails(
        globalPosition: event.position,
        localPosition: event.localPosition,
      ),
      eventContext,
    );
    return;
  }
  final definition = keybinder.definitions.firstWhereOrNull(
    (definition) => definition.id == shortcutId,
  );
  if (definition != null) {
    Actions.maybeInvoke(context, definition.intent);
  }
}
