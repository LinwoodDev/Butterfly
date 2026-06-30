import 'dart:async';

import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_painter.dart';

const kFallbackSecondaryStylusButton = 0x20;

class MainViewViewport extends StatefulWidget {
  const MainViewViewport({super.key});

  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

enum _MouseState { normal, inverse, scale }

typedef _TapDetails = ({
  PointerDeviceKind kind,
  int buttons,
  Offset position,
  Duration timeStamp,
  int count,
});

typedef _HandlerGetter = Handler Function();
typedef _EventContextGetter = EventContext Function();
typedef _TemporaryToolChanger =
    Future<void> Function(PointerDeviceKind kind, int buttons);

class _MainViewViewportState extends State<MainViewViewport>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  double size = 1.0;
  GlobalKey paintKey = GlobalKey();
  _MouseState _mouseState = _MouseState.normal;
  bool _isShiftPressed = false, _isAltPressed = false, _isCtrlPressed = false;
  bool? _isScalingDisabled;
  RulerHandler? _ruler;
  Animation<Offset>? _positionAnimation;

  final Map<int, PointerDeviceKind> _pointerKinds = {};
  Timer? _tapTimer;
  _TapDetails? _lastTap;
  int _slideAnimationId = 0;
  static const Curve _slideCurve = Curves.easeOutCubic;
  static const Duration _multiTapTimeout = Duration(milliseconds: 500);
  static const Duration _multiTapResolveDelay = Duration(milliseconds: 250);
  static const double _multiTapDistance = 18;
  static const String _longPressShortcutId = 'long_press';

  bool _isMouseOrPen(PointerDeviceKind kind) =>
      kind == PointerDeviceKind.mouse ||
      kind == PointerDeviceKind.stylus ||
      kind == PointerDeviceKind.invertedStylus;

  bool _isMousePenOrTouch(PointerDeviceKind kind) =>
      _isMouseOrPen(kind) || kind == PointerDeviceKind.touch;

  bool _isTouchMoveGesture(EditorController controller) =>
      controller.inputCubit.moveEnabled &&
      controller.inputCubit.state.pointers.every(
        (pointer) => _pointerKinds[pointer] == PointerDeviceKind.touch,
      );

  void _rememberTap(PointerDownEvent event) {
    if (event.kind != PointerDeviceKind.mouse &&
        event.kind != PointerDeviceKind.stylus &&
        event.kind != PointerDeviceKind.invertedStylus &&
        event.kind != PointerDeviceKind.touch) {
      return;
    }

    final lastTap = _lastTap;
    final isContinuation =
        lastTap != null &&
        lastTap.kind == event.kind &&
        lastTap.buttons == event.buttons &&
        event.timeStamp - lastTap.timeStamp <= _multiTapTimeout &&
        (event.position - lastTap.position).distance <= _multiTapDistance;
    final tapCount = isContinuation ? (lastTap.count % 3) + 1 : 1;
    _tapTimer?.cancel();
    _lastTap = (
      kind: event.kind,
      buttons: event.buttons,
      position: event.position,
      timeStamp: event.timeStamp,
      count: tapCount,
    );
  }

  String? _getMouseShortcut(
    InputConfiguration config,
    int buttons,
    bool isDoubleTap,
  ) {
    if ((buttons & kSecondaryMouseButton) != 0) {
      return isDoubleTap
          ? config.doubleRightMouseShortcut
          : config.tripleRightMouseShortcut;
    }
    if ((buttons & kMiddleMouseButton) != 0) {
      return isDoubleTap
          ? config.doubleMiddleMouseShortcut
          : config.tripleMiddleMouseShortcut;
    }
    if ((buttons & kPrimaryMouseButton) != 0) {
      return isDoubleTap
          ? config.doubleLeftMouseShortcut
          : config.tripleLeftMouseShortcut;
    }
    return null;
  }

  String? _getPenShortcut(
    InputConfiguration config,
    int buttons,
    bool isDoubleTap,
  ) {
    if ((buttons & kSecondaryStylusButton) != 0 ||
        (buttons & kFallbackSecondaryStylusButton) != 0) {
      return isDoubleTap
          ? config.doubleSecondPenButtonShortcut
          : config.tripleSecondPenButtonShortcut;
    }
    if ((buttons & kPrimaryStylusButton) != 0) {
      return isDoubleTap
          ? config.doubleFirstPenButtonShortcut
          : config.tripleFirstPenButtonShortcut;
    }
    return isDoubleTap ? config.doublePenShortcut : config.triplePenShortcut;
  }

  String? _getMultiTapShortcut(InputConfiguration config, _TapDetails tap) {
    if (tap.count < 2) return null;
    final isDoubleTap = tap.count == 2;
    switch (tap.kind) {
      case PointerDeviceKind.mouse:
        return _getMouseShortcut(config, tap.buttons, isDoubleTap);
      case PointerDeviceKind.stylus:
        return _getPenShortcut(config, tap.buttons, isDoubleTap);
      case PointerDeviceKind.invertedStylus:
        return isDoubleTap
            ? config.doubleInvertedPenShortcut
            : config.tripleInvertedPenShortcut;
      case PointerDeviceKind.touch:
        return isDoubleTap
            ? config.doubleTouchShortcut
            : config.tripleTouchShortcut;
      default:
        return null;
    }
  }

  bool _hasConfiguredMultiTapShortcut(PointerDownEvent event) {
    final config = context.read<SettingsCubit>().state.inputConfiguration;
    final doubleTap = (
      kind: event.kind,
      buttons: event.buttons,
      position: event.position,
      timeStamp: event.timeStamp,
      count: 2,
    );
    final tripleTap = (
      kind: event.kind,
      buttons: event.buttons,
      position: event.position,
      timeStamp: event.timeStamp,
      count: 3,
    );
    return _getMultiTapShortcut(config, doubleTap) != null ||
        _getMultiTapShortcut(config, tripleTap) != null;
  }

  void _invokeLongPressShortcut(
    PointerEvent event,
    PointerDeviceKind kind,
    EditorController cubit,
    _HandlerGetter getHandler,
    _EventContextGetter getEventContext,
  ) {
    final handler = getHandler();
    final eventContext = getEventContext();
    cubit.inputCubit.updateLastPosition(event.localPosition);
    handler.onLongPressDown(
      LongPressDownDetails(
        globalPosition: event.position,
        localPosition: event.localPosition,
        kind: kind,
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
  }

  void _invokeInputShortcut(
    String? shortcutId,
    PointerEvent event,
    PointerDeviceKind kind,
    EditorController cubit,
    _HandlerGetter getHandler,
    _EventContextGetter getEventContext,
  ) {
    if (shortcutId == null || shortcutId.isEmpty) return;
    if (shortcutId == _longPressShortcutId) {
      _invokeLongPressShortcut(event, kind, cubit, getHandler, getEventContext);
      return;
    }
    final def = keybinder.definitions.firstWhereOrNull(
      (d) => d.id == shortcutId,
    );
    if (def == null) return;
    Actions.maybeInvoke(context, def.intent);
  }

  void _scheduleMultiTapShortcut(
    PointerUpEvent event,
    EditorController cubit,
    _HandlerGetter getHandler,
    _EventContextGetter getEventContext,
  ) {
    final tap = _lastTap;
    if (tap == null ||
        !_isMousePenOrTouch(event.kind) ||
        tap.kind != event.kind ||
        event.timeStamp - tap.timeStamp > _multiTapTimeout) {
      return;
    }
    final config = context.read<SettingsCubit>().state.inputConfiguration;
    final shortcutId = _getMultiTapShortcut(config, tap);

    _tapTimer?.cancel();
    final delay = tap.count == 1 ? _multiTapTimeout : _multiTapResolveDelay;
    _tapTimer = Timer(delay, () async {
      if (shortcutId == null || shortcutId.isEmpty) return;
      _invokeInputShortcut(
        shortcutId,
        event,
        tap.kind,
        cubit,
        getHandler,
        getEventContext,
      );
    });
  }

  Future<void> _handlePointerDown(
    PointerDownEvent event,
    EditorController cubit,
    _HandlerGetter getHandler,
    _EventContextGetter getEventContext,
    _TemporaryToolChanger changeTemporaryTool,
  ) async {
    // Detect pen/stylus input
    if (event.kind == PointerDeviceKind.stylus ||
        event.kind == PointerDeviceKind.invertedStylus) {
      cubit.inputCubit.detectPen(true);
    }
    _isScalingDisabled = event.kind == PointerDeviceKind.trackpad
        ? false
        : null;

    if (_hasConfiguredMultiTapShortcut(event)) {
      _rememberTap(event);
    }

    _pointerKinds[event.pointer] = event.kind;
    cubit.inputCubit.addPointer(event.pointer);
    cubit.inputCubit.setButtons(event.buttons);
    final handler = getHandler();
    final ruler = RulerHandler.getInteractiveRuler(
      cubit.toolCubit.state,
      handler,
      event.localPosition,
      getEventContext().viewportSize,
    );
    if (event.kind != PointerDeviceKind.touch && ruler != null) {
      _ruler = ruler;
      ruler.beginTransform(event.localPosition);
      return;
    }
    if (handler.canChange(event, getEventContext())) {
      await changeTemporaryTool(event.kind, event.buttons);
    }
    if (_isScalingDisabled ?? true) {
      await getHandler().onPointerDown(event, getEventContext());
    }
  }

  Future<void> _handlePointerMove(
    PointerMoveEvent event,
    EditorController cubit,
    DocumentLoaded state,
    _HandlerGetter getHandler,
    _EventContextGetter getEventContext,
    VoidCallback delayBake,
  ) async {
    final renderObject = context.findRenderObject();
    if (kIsWeb) {
      if (renderObject is! RenderBox) {
        return;
      }
      if (!renderObject.paintBounds.contains(event.localPosition)) {
        return;
      }
    }
    cubit.inputCubit.updateLastPosition(event.localPosition);
    final ruler = _ruler;
    if (ruler != null && event.kind != PointerDeviceKind.touch) {
      ruler.transformWithPointerMove(getEventContext(), event);
      return;
    }
    final inputState = cubit.inputCubit.state;
    if (_isTouchMoveGesture(cubit)) {
      if (inputState.pointers.isEmpty) {
        return;
      }
      if (event.pointer == inputState.pointers.first) {
        final transform = context.read<TransformCubit>().state;
        cubit.transformCubit.moveConstrained(
          -event.delta / transform.size,
          runtime: cubit,
          bloc: context.read<DocumentBloc>(),
          currentArea: state.currentArea,
        );
        if (!context.read<SettingsCubit>().state.hasFlag('smoothNavigation')) {
          delayBake();
        }
      }
      return;
    }
    if (_isScalingDisabled ?? true) {
      await getHandler().onPointerMove(event, getEventContext());
    }
  }

  Future<void> _handlePointerUp(
    PointerUpEvent event,
    EditorController cubit,
    _HandlerGetter getHandler,
    _EventContextGetter getEventContext,
  ) async {
    cubit.inputCubit.updateLastPosition(event.localPosition);
    final wasRulerInteraction = _ruler != null;
    _resetRulerInteraction();
    if (!wasRulerInteraction && (_isScalingDisabled ?? true)) {
      await getHandler().onPointerUp(event, getEventContext());
    }
    cubit.inputCubit.removePointer(event.pointer);
    _pointerKinds.remove(event.pointer);
    if (wasRulerInteraction) {
      cubit.inputCubit.removeButtons();
    } else {
      _scheduleMultiTapShortcut(event, cubit, getHandler, getEventContext);
    }
  }

  void _handlePointerCancel(PointerCancelEvent event, EditorController cubit) {
    _resetRulerInteraction();
    cubit.inputCubit.removePointer(event.pointer);
    _pointerKinds.remove(event.pointer);
    cubit.inputCubit.removeButtons();
    if (cubit.inputCubit.state.pointers.isEmpty) {
      _isScalingDisabled = null;
    }
  }

  void _resetRulerInteraction() {
    _ruler?.endTransform();
    _ruler = null;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    HardwareKeyboard.instance.addHandler(_handleKey);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    HardwareKeyboard.instance.removeHandler(_handleKey);
    _tapTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final bloc = context.read<DocumentBloc>();
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    if (state != AppLifecycleState.resumed) {
      final controller = context.read<EditorController>();
      controller.toolCubit.resetInput(bloc, controller.inputCubit);
    }
  }

  bool _handleKey(KeyEvent event) {
    _isShiftPressed = HardwareKeyboard.instance.isShiftPressed;
    _isAltPressed = HardwareKeyboard.instance.isAltPressed;
    _isCtrlPressed = HardwareKeyboard.instance.isControlPressed;
    if (_isShiftPressed) {
      _mouseState = _MouseState.inverse;
    } else if (_isCtrlPressed) {
      _mouseState = _MouseState.scale;
    } else {
      _mouseState = _MouseState.normal;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: RepaintBoundary(
        child: LayoutBuilder(
          builder: (context, constraints) {
            void bake() {
              context.read<DocumentBloc>().bake(
                viewportSize: constraints.biggest,
                pixelRatio: MediaQuery.devicePixelRatioOf(context),
              );
            }

            void delayBake() {
              context.read<DocumentBloc>().delayedBake(
                viewportSize: constraints.biggest,
                pixelRatio: MediaQuery.devicePixelRatioOf(context),
                testTransform: false,
              );
            }

            final bloc = context.read<DocumentBloc>();

            Future<void> changeTemporaryTool(
              PointerDeviceKind kind,
              int buttons,
            ) async {
              InputMapping? nextPointerMapping;
              final settings = context.read<SettingsCubit>().state;
              final config = settings.inputConfiguration;
              final cubit = context.read<EditorController>();
              // Mapped to the priority of the buttons
              switch (kind) {
                case PointerDeviceKind.touch:
                  nextPointerMapping = config.touch;
                case PointerDeviceKind.mouse:
                  if ((buttons & kSecondaryMouseButton) != 0) {
                    nextPointerMapping = config.rightMouse;
                  } else if ((buttons & kMiddleMouseButton) != 0) {
                    nextPointerMapping = config.middleMouse;
                  } else if ((buttons & kPrimaryMouseButton) != 0) {
                    nextPointerMapping = config.leftMouse;
                  }
                case PointerDeviceKind.stylus:
                  nextPointerMapping = config.pen;
                  if ((buttons & kSecondaryStylusButton) != 0 ||
                      (buttons & kFallbackSecondaryStylusButton) != 0) {
                    nextPointerMapping = config.secondPenButton;
                  } else if ((buttons & kPrimaryStylusButton) != 0) {
                    nextPointerMapping = config.firstPenButton;
                  }
                case PointerDeviceKind.invertedStylus:
                  nextPointerMapping = config.invertedPen;
                default:
                  nextPointerMapping = null;
              }

              final pressedKeys = HardwareKeyboard.instance.logicalKeysPressed;
              for (final shortcut in config.holdShortcuts) {
                if (pressedKeys.contains(LogicalKeyboardKey(shortcut.keyId))) {
                  nextPointerMapping = shortcut.mapping;
                  break;
                }
              }

              if (nextPointerMapping == null ||
                  nextPointerMapping.getCategory() ==
                      InputMappingCategory.activeTool) {
                cubit.toolCubit.resetDownHandler(bloc, cubit.rendererCubit);
                return;
              }
              if (nextPointerMapping.getCategory() ==
                  InputMappingCategory.handTool) {
                cubit.toolCubit.changeTemporaryHandlerMove(cubit.rendererCubit);
              } else {
                final int? index = nextPointerMapping.getToolPositionIndex();
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

            return BlocBuilder<DocumentBloc, DocumentState>(
              builder: (context, state) {
                if (state is! DocumentLoaded) {
                  return const Center(child: CircularProgressIndicator());
                }

                var point = Offset.zero;
                final EditorController cubit = context.read<EditorController>();

                Handler getHandler() {
                  if (state is DocumentPresentationState) return state.handler;
                  return cubit.toolCubit.getHandler(
                    editable:
                        cubit.saveCubit.state.embedding?.editable != false,
                  );
                }

                return BlocBuilder<RendererCubit, RendererRuntimeState>(
                  buildWhen: (previous, current) =>
                      previous.cameraViewport != current.cameraViewport ||
                      previous.rendererStates != current.rendererStates ||
                      previous.temporaryRendererStates !=
                          current.temporaryRendererStates,
                  builder: (context, rendererState) {
                    return BlocBuilder<ToolCubit, ToolRuntimeState>(
                      buildWhen: (previous, current) =>
                          previous.foregrounds != current.foregrounds ||
                          previous.handler != current.handler ||
                          previous.temporaryHandler !=
                              current.temporaryHandler ||
                          previous.toggleableForegrounds !=
                              current.toggleableForegrounds ||
                          previous.temporaryForegrounds !=
                              current.temporaryForegrounds ||
                          previous.networkingForegrounds !=
                              current.networkingForegrounds ||
                          previous.cursor != current.cursor ||
                          previous.temporaryCursor != current.temporaryCursor,
                      builder: (context, toolState) {
                        var realSize = rendererState.cameraViewport
                            .toRealSize();
                        final viewportSize = constraints.biggest;
                        final isSimiliar =
                            (realSize.width - viewportSize.width).abs() < 2 &&
                            (realSize.height - viewportSize.height).abs() < 2;
                        if (state is DocumentLoadSuccess && !isSimiliar) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) => bake(),
                          );
                        }
                        return Actions(
                          actions: getHandler().getActions(context),
                          child: DefaultTextEditingShortcuts(
                            child: Focus(
                              child: MouseRegion(
                                cursor: toolState.currentCursor,
                                child: Builder(
                                  builder: (context) {
                                    EventContext getEventContext() {
                                      return EventContext(
                                        context,
                                        constraints.biggest,
                                        _isShiftPressed,
                                        _isAltPressed,
                                        _isCtrlPressed,
                                      );
                                    }

                                    return GestureDetector(
                                      onTapUp: (details) async {
                                        getHandler().onTapUp(
                                          details,
                                          getEventContext(),
                                        );
                                        cubit.inputCubit.removeButtons();
                                        cubit.toolCubit.resetReleaseHandler(
                                          bloc,
                                          cubit.rendererCubit,
                                        );
                                      },
                                      onTapDown: (details) =>
                                          getHandler().onTapDown(
                                            details,
                                            getEventContext(),
                                          ),
                                      onSecondaryTapUp: (details) =>
                                          getHandler().onSecondaryTapUp(
                                            details,
                                            getEventContext(),
                                          ),
                                      onScaleUpdate: (details) {
                                        final handler = getHandler();
                                        if (_ruler != null) {
                                          _ruler?.transformWithScaleUpdate(
                                            getEventContext(),
                                            details,
                                          );
                                          return;
                                        }
                                        if (_isScalingDisabled ?? true) {
                                          handler.onScaleUpdate(
                                            details,
                                            getEventContext(),
                                          );
                                          return;
                                        }
                                        final cubit = context
                                            .read<EditorController>();
                                        final settings = context
                                            .read<SettingsCubit>()
                                            .state;
                                        if (cubit.toolCubit.fetchHandler<
                                                  SelectHandler
                                                >(
                                                  editable:
                                                      cubit
                                                          .saveCubit
                                                          .state
                                                          .embedding
                                                          ?.editable !=
                                                      false,
                                                ) ==
                                                null &&
                                            !settings.inputGestures) {
                                          return;
                                        }
                                        var current = details.scale;
                                        current = current - size;
                                        var sensitivity = context
                                            .read<SettingsCubit>()
                                            .state
                                            .gestureSensitivity;
                                        if (details.scale == 1) {
                                          cubit.transformCubit.moveConstrained(
                                            -details.focalPointDelta /
                                                sensitivity /
                                                cubit.transformCubit.state.size,
                                            runtime: cubit,
                                            bloc: bloc,
                                            currentArea: state.currentArea,
                                          );
                                        } else {
                                          cubit.transformCubit.zoomConstrained(
                                            current / sensitivity + 1,
                                            cursor: point,
                                            runtime: cubit,
                                          );
                                        }
                                        size = details.scale;
                                        if (!settings.hasFlag(
                                          'smoothNavigation',
                                        )) {
                                          delayBake();
                                        }
                                      },
                                      onLongPressEnd: (details) =>
                                          getHandler().onLongPressEnd(
                                            details,
                                            getEventContext(),
                                          ),
                                      onScaleEnd: (details) {
                                        if (_ruler != null) {
                                          _resetRulerInteraction();
                                          _isScalingDisabled = null;
                                          cubit.inputCubit.removeButtons();
                                          return;
                                        }
                                        getHandler().onScaleEnd(
                                          details,
                                          getEventContext(),
                                        );
                                        if (!(_isScalingDisabled ?? true)) {
                                          final settings = context
                                              .read<SettingsCubit>()
                                              .state;
                                          final sensitivity =
                                              settings.gestureSensitivity;
                                          cubit.rendererCubit
                                              .cancelDelayedBake();
                                          cubit.transformCubit.slideConstrained(
                                            details.velocity.pixelsPerSecond /
                                                sensitivity /
                                                cubit.transformCubit.state.size,
                                            details.scaleVelocity,
                                            runtime: cubit,
                                            currentArea: state.currentArea,
                                          );
                                          if (!settings.hasFlag(
                                            'smoothNavigation',
                                          )) {
                                            delayBake();
                                          }
                                        }
                                        _resetRulerInteraction();
                                        cubit.inputCubit.removeButtons();
                                        if (_isScalingDisabled ?? true) {
                                          cubit.toolCubit.resetReleaseHandler(
                                            bloc,
                                            cubit.rendererCubit,
                                          );
                                        }
                                      },
                                      onScaleStart: (details) {
                                        _isScalingDisabled ??=
                                            !_isTouchMoveGesture(cubit);
                                        _ruler =
                                            RulerHandler.getInteractiveRuler(
                                              toolState,
                                              cubit.toolCubit.getHandler(
                                                editable:
                                                    cubit
                                                        .saveCubit
                                                        .state
                                                        .embedding
                                                        ?.editable !=
                                                    false,
                                              ),
                                              details.localFocalPoint,
                                              constraints.biggest,
                                            );
                                        if (_ruler != null) {
                                          _isScalingDisabled = false;
                                          _ruler?.beginTransform(
                                            details.localFocalPoint,
                                          );
                                        } else if (_isScalingDisabled !=
                                            false) {
                                          _isScalingDisabled = cubit.toolCubit
                                              .getHandler(
                                                editable:
                                                    cubit
                                                        .saveCubit
                                                        .state
                                                        .embedding
                                                        ?.editable !=
                                                    false,
                                              )
                                              .onScaleStart(
                                                details,
                                                getEventContext(),
                                              );
                                        } else {
                                          cubit.toolCubit
                                              .getHandler(
                                                editable:
                                                    cubit
                                                        .saveCubit
                                                        .state
                                                        .embedding
                                                        ?.editable !=
                                                    false,
                                              )
                                              .onScaleStartAbort(
                                                details,
                                                getEventContext(),
                                              );
                                        }
                                        point = details.localFocalPoint;
                                        size = 1;
                                      },
                                      onLongPressStart: (details) =>
                                          getHandler().onLongPressStart(
                                            details,
                                            getEventContext(),
                                          ),
                                      onLongPressDown: (details) =>
                                          getHandler().onLongPressDown(
                                            details,
                                            getEventContext(),
                                          ),
                                      child: Listener(
                                        onPointerSignal: (pointerSignal) {
                                          if (state is! DocumentLoadSuccess) {
                                            return;
                                          }
                                          if (pointerSignal
                                              is PointerScrollEvent) {
                                            // dx and dy are the delta between the last scroll event
                                            var dx =
                                                pointerSignal.scrollDelta.dx;
                                            var dy =
                                                pointerSignal.scrollDelta.dy;
                                            // Get zoom by dx and dy
                                            var scale = pointerSignal.size;
                                            final settings = context
                                                .read<SettingsCubit>()
                                                .state;
                                            var sensitivity =
                                                settings.scrollSensitivity;
                                            scale /= -sensitivity * 100;
                                            scale += 1;
                                            dx /= sensitivity;
                                            dy /= sensitivity;
                                            final cubit = context
                                                .read<EditorController>();
                                            final transform = context
                                                .read<TransformCubit>()
                                                .state;
                                            if (_mouseState ==
                                                _MouseState.scale) {
                                              // Calculate the new scale using dx and dy
                                              scale = -(dx + dy / 2) / 100 + 1;
                                              cubit.transformCubit
                                                  .zoomConstrained(
                                                    scale,
                                                    cursor: pointerSignal
                                                        .localPosition,
                                                    runtime: cubit,
                                                  );
                                            } else {
                                              cubit.transformCubit
                                                  .moveConstrained(
                                                    (_mouseState ==
                                                                _MouseState
                                                                    .inverse
                                                            ? Offset(dy, dx)
                                                            : Offset(dx, dy)) /
                                                        transform.size,
                                                    runtime: cubit,
                                                    bloc: bloc,
                                                    currentArea:
                                                        state.currentArea,
                                                  );
                                              cubit.transformCubit
                                                  .zoomConstrained(
                                                    scale,
                                                    cursor: pointerSignal
                                                        .localPosition,
                                                    runtime: cubit,
                                                  );
                                            }
                                            if (!settings.hasFlag(
                                              'smoothNavigation',
                                            )) {
                                              delayBake();
                                            }
                                          }
                                        },
                                        onPointerPanZoomStart: (event) {
                                          _isScalingDisabled = false;
                                        },
                                        onPointerDown: (event) =>
                                            _handlePointerDown(
                                              event,
                                              cubit,
                                              getHandler,
                                              getEventContext,
                                              changeTemporaryTool,
                                            ),
                                        onPointerUp: (event) =>
                                            _handlePointerUp(
                                              event,
                                              cubit,
                                              getHandler,
                                              getEventContext,
                                            ),
                                        behavior: HitTestBehavior.translucent,
                                        onPointerHover: (event) {
                                          cubit.inputCubit.updateLastPosition(
                                            event.localPosition,
                                          );
                                          getHandler().onPointerHover(
                                            event,
                                            getEventContext(),
                                          );
                                        },
                                        onPointerMove: (event) =>
                                            _handlePointerMove(
                                              event,
                                              cubit,
                                              state,
                                              getHandler,
                                              getEventContext,
                                              delayBake,
                                            ),
                                        onPointerCancel: (event) =>
                                            _handlePointerCancel(event, cubit),
                                        child: _buildCanvas(
                                          rendererState,
                                          toolState,
                                          cubit,
                                          state,
                                          delayBake,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCanvas(
    RendererRuntimeState rendererState,
    ToolRuntimeState toolState,
    EditorController cubit,
    DocumentLoaded state,
    VoidCallback delayBake,
  ) {
    return BlocListener<TransformCubit, CameraTransform>(
      listenWhen: (previous, current) =>
          previous.friction?.lastUpdate != current.friction?.lastUpdate,
      listener: (context, transform) {
        final friction = transform.friction;
        if (friction == null) {
          _slideAnimationId++;
          _animationController.stop();
          _positionAnimation = null;
          return;
        }
        final slideAnimationId = ++_slideAnimationId;
        _positionAnimation =
            Tween<Offset>(
              begin:
                  friction.beginOffset -
                  (_positionAnimation?.value ?? Offset.zero),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: _animationController, curve: _slideCurve),
            );
        final lastDuration = _animationController.duration?.inMilliseconds ?? 0;
        final lastValue = lastDuration > 0
            ? (1 - _animationController.value) / lastDuration
            : 0;
        final duration = (lastValue + friction.duration * 1000).round();
        if (duration <= 0) {
          _animationController.stop();
          _positionAnimation = null;
          return;
        }
        _animationController.duration = Duration(milliseconds: duration);
        unawaited(
          _animationController.forward(from: 0).then((_) {
            if (!mounted || slideAnimationId != _slideAnimationId) return;
            delayBake();
          }),
        );
      },
      child: BlocBuilder<TransformCubit, CameraTransform>(
        builder: (context, transform) => AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final frictionTransform = transform.withFrictionless(
              _positionAnimation?.value ?? Offset.zero,
              0,
            );
            return Stack(
              children: [
                Container(color: ColorScheme.of(context).surfaceDim),
                CustomPaint(
                  size: Size.infinite,
                  foregroundPainter: ForegroundPainter(
                    toolState.getAllForegrounds(),
                    state.data,
                    state.page,
                    state.info,
                    ColorScheme.of(context),
                    frictionTransform,
                    toolState.selection,
                    state.settingsCubit.state.navigatorPosition,
                  ),
                  painter: ViewPainter(
                    state.data,
                    state.page,
                    state.info,
                    cameraViewport: rendererState.cameraViewport,
                    transform: frictionTransform,
                    invisibleLayers: state.invisibleLayers,
                    currentArea: state.currentArea,
                    colorScheme: ColorScheme.of(context),
                  ),
                  isComplex: true,
                  willChange: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
