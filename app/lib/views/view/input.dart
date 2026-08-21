part of '../view.dart';

class _ViewportInputCoordinator {
  _ViewportInputCoordinator(this._settleSlide);

  final void Function(TransformCubit transformCubit) _settleSlide;
  final Map<int, PointerDeviceKind> _pointerKinds = {};
  final PointerShortcutManager _shortcutManager = PointerShortcutManager();

  Offset _gestureFocalPoint = Offset.zero;
  double _gestureScale = 1;
  double _gestureRotation = 0;
  int _gesturePointerCount = 0;
  bool? _handlerHandlesScaleGesture;
  RulerHandler? _ruler;
  int? _rulerPointer;

  bool get _isHandlerGesture => _handlerHandlesScaleGesture ?? true;

  void reset() {
    _shortcutManager.reset();
    _pointerKinds.clear();
    _resetRulerInteraction();
    _handlerHandlesScaleGesture = null;
  }

  void dispose() => _shortcutManager.dispose();

  void beginTrackpadGesture() => _handlerHandlesScaleGesture = false;

  EventContext createEventContext(BuildContext context, Size viewportSize) {
    final keyboard = HardwareKeyboard.instance;
    return EventContext(
      context,
      viewportSize,
      keyboard.isShiftPressed,
      keyboard.isAltPressed,
      keyboard.isControlPressed,
    );
  }

  bool _isTouchMoveGesture(EditorController controller) =>
      controller.inputCubit.moveEnabled &&
      controller.inputCubit.state.pointers.every(
        (pointer) => _pointerKinds[pointer] == PointerDeviceKind.touch,
      );

  Future<void> handlePointerDown(
    PointerDownEvent event,
    _PointerInputContext input, {
    bool skipShortcuts = false,
  }) async {
    final cubit = input.cubit;
    final getHandler = input.getHandler;
    final getEventContext = input.getEventContext;
    if (!skipShortcuts && cubit.inputCubit.state.pointers.isEmpty) {
      _settleSlide(cubit.transformCubit);
      _handlerHandlesScaleGesture = event.kind == PointerDeviceKind.trackpad
          ? false
          : null;
    }
    if (!skipShortcuts) {
      if (event.kind == PointerDeviceKind.stylus ||
          event.kind == PointerDeviceKind.invertedStylus) {
        cubit.inputCubit.detectPen(true);
      }
      final result = _shortcutManager.pointerDown(
        event,
        input.context.read<SettingsCubit>().state.inputConfiguration,
      );
      await _replayPointerEvents(result.releasedEvents, input);
      if (result.consumed) return;
    }

    _pointerKinds[event.pointer] = event.kind;
    cubit.inputCubit.addPointer(event.pointer);
    cubit.inputCubit.setButtons(event.buttons);
    final handler = getHandler();
    final eventContext = getEventContext();
    final ruler = RulerHandler.getInteractiveRuler(
      cubit.toolCubit.state,
      handler,
      event.localPosition,
      eventContext.viewportSize,
    );
    if (event.kind != PointerDeviceKind.touch && ruler != null) {
      _ruler = ruler;
      _rulerPointer = event.pointer;
      ruler.beginTransform(event.localPosition);
      return;
    }
    if (handler.canChange(event, eventContext)) {
      await _changeTemporaryTool(event.kind, event.buttons, input);
    }
    if (_isHandlerGesture) {
      await getHandler().onPointerDown(event, eventContext);
    }
  }

  Future<void> handlePointerMove(
    PointerMoveEvent event,
    _PointerInputContext input, {
    bool skipShortcuts = false,
  }) async {
    final cubit = input.cubit;
    if (!skipShortcuts) {
      final result = _shortcutManager.pointerMove(event);
      await _replayPointerEvents(result.releasedEvents, input);
      if (result.consumed) return;
    }

    final renderObject = input.context.findRenderObject();
    if (kIsWeb &&
        (renderObject is! RenderBox ||
            !renderObject.paintBounds.contains(event.localPosition))) {
      return;
    }
    cubit.inputCubit.updateLastPosition(event.localPosition);
    final ruler = _ruler;
    if (ruler != null && event.kind != PointerDeviceKind.touch) {
      ruler.transformWithPointerMove(input.getEventContext(), event);
      return;
    }
    final inputState = cubit.inputCubit.state;
    if (_isTouchMoveGesture(cubit)) {
      if (inputState.pointers.isEmpty) return;
      if (event.pointer == inputState.pointers.first) {
        final transform = cubit.transformCubit.state;
        cubit.transformCubit.moveConstrained(
          transform.localToGlobalDelta(-event.delta),
          runtime: cubit,
          bloc: input.bloc,
          currentArea: input.state.currentArea,
        );
        _delayBakeUnlessSmooth(
          input.context.read<SettingsCubit>().state,
          input.delayBake,
        );
      }
      return;
    }
    if (_isHandlerGesture) {
      await input.getHandler().onPointerMove(event, input.getEventContext());
    }
  }

  Future<void> handlePointerUp(
    PointerUpEvent event,
    _PointerInputContext input, {
    bool skipShortcuts = false,
  }) async {
    final cubit = input.cubit;
    if (!skipShortcuts) {
      if (_ruler != null) {
        _shortcutManager.pointerCancel(event);
      } else {
        final result = _shortcutManager.pointerUp(
          event,
          getConfiguration: () =>
              input.context.read<SettingsCubit>().state.inputConfiguration,
          onTriggered: (shortcutId, pointerEvent) => invokePointerShortcut(
            input.context,
            shortcutId,
            pointerEvent,
            cubit,
            input.getHandler,
            input.getEventContext,
          ),
          onFallback: (events) =>
              unawaited(_replayPointerEvents(events, input)),
        );
        await _replayPointerEvents(result.releasedEvents, input);
        if (result.consumed) return;
      }
    }

    cubit.inputCubit.updateLastPosition(event.localPosition);
    final wasRulerInteraction = _ruler != null;
    _resetRulerInteraction();
    if (!wasRulerInteraction && _isHandlerGesture) {
      await input.getHandler().onPointerUp(event, input.getEventContext());
    }
    cubit.inputCubit.removePointer(event.pointer);
    _pointerKinds.remove(event.pointer);
    if (wasRulerInteraction) cubit.inputCubit.removeButtons();
    cubit.toolCubit.resetReleaseHandler(input.bloc, cubit.rendererCubit);
  }

  Future<void> _replayPointerEvents(
    List<PointerEvent> events,
    _PointerInputContext input,
  ) async {
    for (final event in events) {
      switch (event) {
        case PointerDownEvent():
          await handlePointerDown(event, input, skipShortcuts: true);
        case PointerMoveEvent():
          await handlePointerMove(event, input, skipShortcuts: true);
        case PointerUpEvent():
          await handlePointerUp(event, input, skipShortcuts: true);
        default:
          break;
      }
    }
  }

  void handlePointerCancel(PointerCancelEvent event, EditorController cubit) {
    if (_shortcutManager.pointerCancel(event)) return;
    _resetRulerInteraction();
    cubit.inputCubit.removePointer(event.pointer);
    _pointerKinds.remove(event.pointer);
    cubit.inputCubit.removeButtons();
    if (cubit.inputCubit.state.pointers.isEmpty) {
      _handlerHandlesScaleGesture = null;
    }
  }

  void _resetRulerInteraction() {
    _ruler?.endTransform();
    _ruler = null;
    _rulerPointer = null;
  }

  void _rebaseScaleGesture(ScaleUpdateDetails details) {
    _gesturePointerCount = details.pointerCount;
    _gestureFocalPoint = details.localFocalPoint;
    _gestureScale = details.scale;
    _gestureRotation = details.rotation;
  }

  void _delayBakeUnlessSmooth(
    ButterflySettings settings,
    VoidCallback delayBake,
  ) {
    if (!settings.hasFlag('smoothNavigation')) delayBake();
  }

  void handleScaleStart(ScaleStartDetails details, _PointerInputContext input) {
    final cubit = input.cubit;
    final handler = input.getHandler();
    final eventContext = input.getEventContext();
    _handlerHandlesScaleGesture ??= !_isTouchMoveGesture(cubit);

    if (_rulerPointer == null) {
      _ruler = RulerHandler.getInteractiveRuler(
        cubit.toolCubit.state,
        handler,
        details.localFocalPoint,
        eventContext.viewportSize,
      );
      _ruler?.beginTransform(details.localFocalPoint);
    }

    if (_ruler != null) {
      _handlerHandlesScaleGesture = false;
    } else if (_handlerHandlesScaleGesture != false) {
      _handlerHandlesScaleGesture = handler.onScaleStart(details, eventContext);
    } else {
      handler.onScaleStartAbort(details, eventContext);
    }

    _gestureFocalPoint = details.localFocalPoint;
    _gestureScale = 1;
    _gestureRotation = 0;
    _gesturePointerCount = details.pointerCount;
  }

  void handleScaleUpdate(
    ScaleUpdateDetails details,
    _PointerInputContext input,
  ) {
    final handler = input.getHandler();
    final ruler = _ruler;
    if (ruler != null) {
      if (_rulerPointer == null) {
        ruler.transformWithScaleUpdate(input.getEventContext(), details);
      }
      return;
    }
    if (_isHandlerGesture) {
      handler.onScaleUpdate(details, input.getEventContext());
      return;
    }

    final cubit = input.cubit;
    final settings = input.context.read<SettingsCubit>().state;
    final hasSelectHandler =
        cubit.toolCubit.fetchHandler<SelectHandler>(
          editable: cubit.saveCubit.state.embedding?.editable != false,
        ) !=
        null;
    if (!hasSelectHandler && !settings.inputGestures) return;

    if (details.pointerCount != _gesturePointerCount) {
      _rebaseScaleGesture(details);
      return;
    }

    final sensitivity = settings.gestureSensitivity;
    final rotationDelta = details.rotation - _gestureRotation;
    _gestureRotation = details.rotation;
    if (settings.rotateOnGesture) {
      cubit.transformCubit.rotateConstrained(
        rotationDelta / sensitivity,
        cursor: details.localFocalPoint,
        runtime: cubit,
      );
    }

    if (details.scale == 1) {
      cubit.transformCubit.moveConstrained(
        cubit.transformCubit.state.localToGlobalDelta(
              -details.focalPointDelta,
            ) /
            sensitivity,
        runtime: cubit,
        bloc: input.bloc,
        currentArea: input.state.currentArea,
      );
    } else {
      final scaleDelta = details.scale - _gestureScale;
      cubit.transformCubit.zoomConstrained(
        scaleDelta / sensitivity + 1,
        cursor: _gestureFocalPoint,
        runtime: cubit,
      );
    }
    _gestureScale = details.scale;
    _delayBakeUnlessSmooth(settings, input.delayBake);
  }

  void handleScaleEnd(ScaleEndDetails details, _PointerInputContext input) {
    final cubit = input.cubit;
    if (_ruler != null) {
      _resetRulerInteraction();
      _handlerHandlesScaleGesture = null;
      cubit.inputCubit.removeButtons();
      return;
    }

    final isNavigation = !_isHandlerGesture;
    if (isNavigation && details.pointerCount > 0) return;

    input.getHandler().onScaleEnd(details, input.getEventContext());
    if (isNavigation) {
      final settings = input.context.read<SettingsCubit>().state;
      final sensitivity = settings.gestureSensitivity;
      cubit.rendererCubit.cancelDelayedBake();
      cubit.transformCubit.slideConstrained(
        cubit.transformCubit.state.localToGlobalDelta(
              details.velocity.pixelsPerSecond,
            ) /
            sensitivity,
        details.scaleVelocity,
        runtime: cubit,
        currentArea: input.state.currentArea,
      );
      _delayBakeUnlessSmooth(settings, input.delayBake);
    }
    _resetRulerInteraction();
    cubit.inputCubit.removeButtons();
  }

  void handlePointerSignal(
    PointerSignalEvent event,
    _PointerInputContext input,
  ) {
    if (input.state is! DocumentLoadSuccess || event is! PointerScrollEvent) {
      return;
    }

    final settings = input.context.read<SettingsCubit>().state;
    final sensitivity = settings.scrollSensitivity;
    final cubit = input.cubit;
    final scrollDelta = event.scrollDelta / sensitivity;
    final keyboard = HardwareKeyboard.instance;

    if (!keyboard.isShiftPressed && keyboard.isControlPressed) {
      cubit.transformCubit.zoomConstrained(
        -(scrollDelta.dx + scrollDelta.dy / 2) / 100 + 1,
        cursor: event.localPosition,
        runtime: cubit,
      );
    } else {
      final panDelta = keyboard.isShiftPressed
          ? Offset(scrollDelta.dy, scrollDelta.dx)
          : scrollDelta;
      cubit.transformCubit.moveConstrained(
        cubit.transformCubit.state.localToGlobalDelta(panDelta),
        runtime: cubit,
        bloc: input.bloc,
        currentArea: input.state.currentArea,
      );
      cubit.transformCubit.zoomConstrained(
        event.size / (-sensitivity * 100) + 1,
        cursor: event.localPosition,
        runtime: cubit,
      );
    }
    _delayBakeUnlessSmooth(settings, input.delayBake);
  }

  Future<void> _changeTemporaryTool(
    PointerDeviceKind kind,
    int buttons,
    _PointerInputContext input,
  ) async {
    final context = input.context;
    final cubit = input.cubit;
    final config = context.read<SettingsCubit>().state.inputConfiguration;
    cubit.toolCubit.resetDownHandler(input.bloc, cubit.rendererCubit);
    var mapping = config.getPointerMapping(kind, buttons);

    final pressedKeys = HardwareKeyboard.instance.logicalKeysPressed;
    for (final shortcut in config.holdShortcuts) {
      if (pressedKeys.contains(LogicalKeyboardKey(shortcut.keyId))) {
        mapping = shortcut.mapping;
        break;
      }
    }

    switch (mapping?.getCategory()) {
      case null:
      case InputMappingCategory.activeTool:
        return;
      case InputMappingCategory.handTool:
        cubit.toolCubit.changeTemporaryHandlerMove(cubit.rendererCubit);
        return;
      default:
        final index = mapping?.getToolPositionIndex();
        if (index != null) {
          await cubit.toolCubit.changeTemporaryHandlerIndex(
            context,
            cubit,
            index,
            temporaryState: TemporaryState.removeAfterClick,
          );
        }
    }
  }
}
