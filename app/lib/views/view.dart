import 'dart:async';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/services/pointer_shortcuts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_painter.dart';

class MainViewViewport extends StatefulWidget {
  const MainViewViewport({super.key});

  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

enum _MouseState { normal, inverse, scale }

typedef _HandlerGetter = Handler Function();
typedef _EventContextGetter = EventContext Function();
typedef _TemporaryToolChanger =
    Future<void> Function(PointerDeviceKind kind, int buttons);
typedef _PointerInputContext = ({
  EditorController cubit,
  DocumentLoaded state,
  _HandlerGetter getHandler,
  _EventContextGetter getEventContext,
  _TemporaryToolChanger changeTemporaryTool,
  VoidCallback delayBake,
});

class _MainViewViewportState extends State<MainViewViewport>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  double size = 1.0;
  double gestureRotation = 0;
  GlobalKey paintKey = GlobalKey();
  _MouseState _mouseState = _MouseState.normal;
  bool _isShiftPressed = false, _isAltPressed = false, _isCtrlPressed = false;
  bool? _isScalingDisabled;
  RulerHandler? _ruler;
  Animation<Offset>? _positionAnimation;

  final Map<int, PointerDeviceKind> _pointerKinds = {};
  final PointerShortcutManager _pointerShortcutManager =
      PointerShortcutManager();
  int _slideAnimationId = 0;
  static const Curve _slideCurve = Curves.easeOutCubic;

  bool _isTouchMoveGesture(EditorController controller) =>
      controller.inputCubit.moveEnabled &&
      controller.inputCubit.state.pointers.every(
        (pointer) => _pointerKinds[pointer] == PointerDeviceKind.touch,
      );

  Future<void> _handlePointerDown(
    PointerDownEvent event,
    _PointerInputContext input, {
    bool skipShortcuts = false,
  }) async {
    final cubit = input.cubit;
    final getHandler = input.getHandler;
    final getEventContext = input.getEventContext;
    final changeTemporaryTool = input.changeTemporaryTool;
    if (!skipShortcuts) {
      // Detect pen/stylus input
      if (event.kind == PointerDeviceKind.stylus ||
          event.kind == PointerDeviceKind.invertedStylus) {
        cubit.inputCubit.detectPen(true);
      }
      final result = _pointerShortcutManager.pointerDown(
        event,
        context.read<SettingsCubit>().state.inputConfiguration,
      );
      await _replayPointerEvents(result.releasedEvents, input);
      if (result.consumed) return;
    }

    _isScalingDisabled = event.kind == PointerDeviceKind.trackpad
        ? false
        : null;
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
    _PointerInputContext input, {
    bool skipShortcuts = false,
  }) async {
    final cubit = input.cubit;
    final state = input.state;
    final getHandler = input.getHandler;
    final getEventContext = input.getEventContext;
    final delayBake = input.delayBake;
    if (!skipShortcuts) {
      final result = _pointerShortcutManager.pointerMove(event);
      await _replayPointerEvents(result.releasedEvents, input);
      if (result.consumed) return;
    }

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
          transform.localToGlobalDelta(-event.delta),
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
    _PointerInputContext input, {
    bool skipShortcuts = false,
  }) async {
    final cubit = input.cubit;
    final getHandler = input.getHandler;
    final getEventContext = input.getEventContext;
    if (!skipShortcuts) {
      if (_ruler != null) {
        _pointerShortcutManager.pointerCancel(event);
      } else {
        final result = _pointerShortcutManager.pointerUp(
          event,
          getConfiguration: () =>
              context.read<SettingsCubit>().state.inputConfiguration,
          onTriggered: (shortcutId, pointerEvent) => invokePointerShortcut(
            context,
            shortcutId,
            pointerEvent,
            cubit,
            getHandler,
            getEventContext,
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
    if (!wasRulerInteraction && (_isScalingDisabled ?? true)) {
      await getHandler().onPointerUp(event, getEventContext());
    }
    cubit.inputCubit.removePointer(event.pointer);
    _pointerKinds.remove(event.pointer);
    if (wasRulerInteraction) {
      cubit.inputCubit.removeButtons();
    }
  }

  Future<void> _replayPointerEvents(
    List<PointerEvent> events,
    _PointerInputContext input,
  ) async {
    for (final event in events) {
      switch (event) {
        case PointerDownEvent():
          await _handlePointerDown(event, input, skipShortcuts: true);
        case PointerMoveEvent():
          await _handlePointerMove(event, input, skipShortcuts: true);
        case PointerUpEvent():
          await _handlePointerUp(event, input, skipShortcuts: true);
        default:
          break;
      }
    }
  }

  void _handlePointerCancel(PointerCancelEvent event, EditorController cubit) {
    if (_pointerShortcutManager.pointerCancel(event)) return;
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
    _pointerShortcutManager.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final bloc = context.read<DocumentBloc>();
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    if (state != AppLifecycleState.resumed) {
      _pointerShortcutManager.reset();
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
              final settings = context.read<SettingsCubit>().state;
              final config = settings.inputConfiguration;
              final cubit = context.read<EditorController>();
              cubit.toolCubit.resetDownHandler(bloc, cubit.rendererCubit);
              var nextPointerMapping = config.getPointerMapping(kind, buttons);

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
                          previous.handler != current.handler ||
                          previous.temporaryHandler !=
                              current.temporaryHandler ||
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

                                    final pointerInput = (
                                      cubit: cubit,
                                      state: state,
                                      getHandler: getHandler,
                                      getEventContext: getEventContext,
                                      changeTemporaryTool: changeTemporaryTool,
                                      delayBake: delayBake,
                                    );
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
                                        final rotationDelta =
                                            details.rotation - gestureRotation;
                                        gestureRotation = details.rotation;
                                        cubit.transformCubit.rotateConstrained(
                                          rotationDelta / sensitivity,
                                          cursor: details.localFocalPoint,
                                          runtime: cubit,
                                        );
                                        if (details.scale == 1) {
                                          cubit.transformCubit.moveConstrained(
                                            cubit.transformCubit.state
                                                    .localToGlobalDelta(
                                                      -details.focalPointDelta,
                                                    ) /
                                                sensitivity,
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
                                            cubit.transformCubit.state
                                                    .localToGlobalDelta(
                                                      details
                                                          .velocity
                                                          .pixelsPerSecond,
                                                    ) /
                                                sensitivity,
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
                                        gestureRotation = 0;
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
                                                    transform
                                                        .localToGlobalDelta(
                                                          _mouseState ==
                                                                  _MouseState
                                                                      .inverse
                                                              ? Offset(dy, dx)
                                                              : Offset(dx, dy),
                                                        ),
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
                                              pointerInput,
                                            ),
                                        onPointerUp: (event) =>
                                            _handlePointerUp(
                                              event,
                                              pointerInput,
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
                                              pointerInput,
                                            ),
                                        onPointerCancel: (event) =>
                                            _handlePointerCancel(event, cubit),
                                        child: _buildCanvas(
                                          rendererState,
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
                RepaintBoundary(
                  child: CustomPaint(
                    size: Size.infinite,
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
                  ),
                ),
                BlocBuilder<ToolCubit, ToolRuntimeState>(
                  buildWhen: (previous, current) =>
                      previous.foregrounds != current.foregrounds ||
                      previous.temporaryForegrounds !=
                          current.temporaryForegrounds ||
                      previous.toggleableForegrounds !=
                          current.toggleableForegrounds ||
                      previous.networkingForegrounds !=
                          current.networkingForegrounds ||
                      previous.selection != current.selection,
                  builder: (context, toolState) => RepaintBoundary(
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: ForegroundPainter(
                        toolState.getAllForegrounds(),
                        state.data,
                        state.page,
                        state.info,
                        ColorScheme.of(context),
                        frictionTransform,
                        toolState.selection,
                        state.settingsCubit.state.navigatorPosition,
                      ),
                      willChange: true,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
