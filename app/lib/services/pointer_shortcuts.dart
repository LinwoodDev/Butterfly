import 'dart:async';

import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

const _longPressShortcutId = 'long_press';
const _defaultTapTimeout = Duration(milliseconds: 500);
const _defaultRepeatResolveDelay = Duration(milliseconds: 250);
const _defaultMovementTolerance = 18.0;

typedef PointerShortcutCallback = void Function(
  String shortcutId,
  PointerUpEvent event,
);
typedef PointerShortcutFallbackCallback = void Function(
  List<PointerEvent> events,
);
typedef PointerShortcutEventResult = ({
  bool consumed,
  List<PointerEvent> releasedEvents,
});

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
  final List<PointerEvent> _bufferedRepeatedTapEvents = [];
  final Map<int, Offset> _bufferedRepeatedTapStartPositions = {};
  final Set<int> _activePointers = {};
  final Set<int> _activeTouchPointers = {};
  final Set<int> _trackedRepeatedPointers = {};
  Duration? _multiFingerStartTime;
  int _maxTouchPointerCount = 0;
  bool _invalidMultiFingerGesture = false;

  Timer? _repeatTimer;
  _RepeatedTapDetails? _lastRepeatedTap;

  PointerShortcutManager({
    this.repeatTimeout = _defaultTapTimeout,
    this.repeatResolveDelay = _defaultRepeatResolveDelay,
    this.multiFingerTimeout = _defaultTapTimeout,
    this.movementTolerance = _defaultMovementTolerance,
  });

  PointerShortcutEventResult pointerDown(
    PointerDownEvent event,
    InputConfiguration configuration,
  ) {
    final hasRepeatedTapShortcut = configuration.hasRepeatedTapShortcut(
      event.kind,
      event.buttons,
    );
    final isContinuation = _isRepeatedTapContinuation(event);
    var releasedEvents = const <PointerEvent>[];
    if (hasRepeatedTapShortcut &&
        _bufferedRepeatedTapEvents.isNotEmpty &&
        (_bufferedRepeatedTapStartPositions.isNotEmpty || !isContinuation)) {
      releasedEvents = _takeBufferedRepeatedTapEvents();
    }

    final hasActivePointer = _activePointers.isNotEmpty;
    _activePointers.add(event.pointer);
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

    final consumed = hasRepeatedTapShortcut && !hasActivePointer;
    if (consumed) {
      _bufferedRepeatedTapEvents.add(event);
      _bufferedRepeatedTapStartPositions[event.pointer] = event.position;
    }
    return (consumed: consumed, releasedEvents: releasedEvents);
  }

  bool _isRepeatedTapContinuation(PointerDownEvent event) {
    final lastTap = _lastRepeatedTap;
    return lastTap != null &&
        lastTap.kind == event.kind &&
        lastTap.buttons == event.buttons &&
        event.timeStamp - lastTap.timeStamp <= repeatTimeout &&
        (event.position - lastTap.position).distance <= movementTolerance;
  }

  PointerShortcutEventResult pointerMove(PointerMoveEvent event) {
    _checkRepeatedTapMovement(event.pointer, event.localPosition);
    if (event.kind == PointerDeviceKind.touch) {
      _checkTouchMovement(event.pointer, event.localPosition);
    }
    final startPosition = _bufferedRepeatedTapStartPositions[event.pointer];
    if (startPosition == null) {
      return (consumed: false, releasedEvents: const []);
    }
    _bufferedRepeatedTapEvents.add(event);
    if ((event.position - startPosition).distance > movementTolerance) {
      return (consumed: true, releasedEvents: _takeBufferedRepeatedTapEvents());
    }
    return (consumed: true, releasedEvents: const []);
  }

  PointerShortcutEventResult pointerUp(
    PointerUpEvent event, {
    required InputConfiguration Function() getConfiguration,
    required PointerShortcutCallback onTriggered,
    PointerShortcutFallbackCallback? onFallback,
  }) {
    final bufferedStartPosition = _bufferedRepeatedTapStartPositions.remove(
      event.pointer,
    );
    final consumed = bufferedStartPosition != null;
    if (consumed) {
      _bufferedRepeatedTapEvents.add(event);
    }
    _activePointers.remove(event.pointer);
    _checkRepeatedTapMovement(event.pointer, event.localPosition);
    final trackedRepeatedTap = _trackedRepeatedPointers.remove(event.pointer);
    _repeatedDownPositions.remove(event.pointer);
    final releasedEvents =
        bufferedStartPosition != null &&
            (event.position - bufferedStartPosition).distance >
                movementTolerance
        ? _takeBufferedRepeatedTapEvents()
        : const <PointerEvent>[];
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
        return (consumed: consumed, releasedEvents: releasedEvents);
      }
      if (multiFingerTap.wasMultiFingerGesture) {
        _resetRepeatedTap();
        return (consumed: consumed, releasedEvents: releasedEvents);
      }
    }
    if (releasedEvents.isNotEmpty) {
      return (consumed: true, releasedEvents: releasedEvents);
    }
    if (trackedRepeatedTap) {
      _scheduleRepeatedTap(event, getConfiguration, onTriggered, onFallback);
    }
    return (consumed: consumed, releasedEvents: const []);
  }

  bool pointerCancel(PointerEvent event) {
    _activePointers.remove(event.pointer);
    final consumed =
        _bufferedRepeatedTapStartPositions.remove(event.pointer) != null;
    if (consumed) {
      _bufferedRepeatedTapEvents.clear();
      _bufferedRepeatedTapStartPositions.clear();
    }
    final trackedRepeatedTap = _trackedRepeatedPointers.remove(event.pointer);
    _repeatedDownPositions.remove(event.pointer);
    if (event.kind == PointerDeviceKind.touch) {
      _cancelTouchPointer(event.pointer);
    }
    if (trackedRepeatedTap) {
      _resetRepeatedTap();
    }
    return consumed;
  }

  void reset() {
    _resetRepeatedTap();
    _resetMultiFingerTap();
    _activePointers.clear();
    _bufferedRepeatedTapEvents.clear();
    _bufferedRepeatedTapStartPositions.clear();
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
    PointerShortcutFallbackCallback? onFallback,
  ) {
    final tap = _lastRepeatedTap;
    if (tap == null ||
        tap.kind != event.kind ||
        event.timeStamp - tap.timeStamp > repeatTimeout) {
      return;
    }

    _repeatTimer?.cancel();
    final delay = tap.count < 2 ? repeatTimeout : repeatResolveDelay;
    _repeatTimer = Timer(delay, () {
      _lastRepeatedTap = null;
      final shortcutId = getConfiguration().getRepeatedTapShortcut(
        tap.kind,
        tap.buttons,
        tap.count,
      );
      if (shortcutId != null) {
        _takeBufferedRepeatedTapEvents();
        onTriggered(shortcutId, event);
      } else {
        final events = _takeBufferedRepeatedTapEvents();
        if (events.isNotEmpty) {
          onFallback?.call(events);
        }
      }
    });
  }

  List<PointerEvent> _takeBufferedRepeatedTapEvents() {
    final events = List<PointerEvent>.of(_bufferedRepeatedTapEvents);
    _bufferedRepeatedTapEvents.clear();
    _bufferedRepeatedTapStartPositions.clear();
    return events;
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
