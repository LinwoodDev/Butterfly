import 'dart:async';
import 'dart:math';

import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
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

class _MainViewViewportState extends State<MainViewViewport>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  double size = 1.0;
  GlobalKey paintKey = GlobalKey();
  _MouseState _mouseState = _MouseState.normal;
  bool _isShiftPressed = false, _isAltPressed = false, _isCtrlPressed = false;
  bool? _isScalingDisabled;
  Animation<Offset>? _positionAnimation;

  // Touch gesture buffering
  final List<PointerEvent> _bufferedEvents = [];
  final Map<int, Offset> _touchStartPositions = {};
  int _fingersInvolved = 0;
  bool _isTouchTapGesture = false;
  Timer? _touchTapTimer;

  void _resetTouchTap() {
    _bufferedEvents.clear();
    _touchStartPositions.clear();
    _isTouchTapGesture = false;
    _fingersInvolved = 0;
  }

  Future<void> _flushBufferedEvents(
    CurrentIndexCubit cubit,
    Handler Function() getHandler,
    EventContext Function() getEventContext,
    Future<void> Function(PointerDeviceKind, int) changeTemporaryTool,
  ) async {
    for (final e in _bufferedEvents) {
      if (e is PointerDownEvent) {
        _isScalingDisabled = e.kind == PointerDeviceKind.trackpad
            ? false
            : null;
        cubit.addPointer(e.pointer);
        cubit.setButtons(e.buttons);
        final handler = getHandler();
        if (handler.canChange(e, getEventContext())) {
          await changeTemporaryTool(e.kind, e.buttons);
        }
        if (_isScalingDisabled ?? true) {
          getHandler().onPointerDown(e, getEventContext());
        }
      } else if (e is PointerMoveEvent) {
        cubit.updateLastPosition(e.localPosition);
        if (_isScalingDisabled ?? true) {
          getHandler().onPointerMove(e, getEventContext());
        }
      } else if (e is PointerUpEvent) {
        cubit.updateLastPosition(e.localPosition);
        if (_isScalingDisabled ?? true) {
          await getHandler().onPointerUp(e, getEventContext());
        }
        cubit.removePointer(e.pointer);
      } else if (e is PointerCancelEvent) {
        cubit.removePointer(e.pointer);
        cubit.removeButtons();
        if (cubit.state.pointers.isEmpty) {
          _isScalingDisabled = null;
        }
      }
    }
  }

  Future<void> _handlePointerDown(
    PointerDownEvent event,
    CurrentIndexCubit cubit,
    Handler Function() getHandler,
    EventContext Function() getEventContext,
    Future<void> Function(PointerDeviceKind, int) changeTemporaryTool,
  ) async {
    // Detect pen/stylus input
    if (event.kind == PointerDeviceKind.stylus ||
        event.kind == PointerDeviceKind.invertedStylus) {
      cubit.setPenDetected(true);
    }
    if (event.kind == PointerDeviceKind.touch) {
      final config = context.read<SettingsCubit>().state.inputConfiguration;
      if (config.doubleTouchShortcut != null ||
          config.tripleTouchShortcut != null) {
        if (_bufferedEvents.isEmpty) {
          _touchTapTimer?.cancel();
          _fingersInvolved = 0;
          _isTouchTapGesture = true;
        }
        if (_isTouchTapGesture) {
          _bufferedEvents.add(event);
          _touchStartPositions[event.pointer] = event.position;
          _fingersInvolved++;
          return;
        }
      }
    }

    _isScalingDisabled = event.kind == PointerDeviceKind.trackpad
        ? false
        : null;
    cubit.addPointer(event.pointer);
    cubit.setButtons(event.buttons);
    final handler = getHandler();
    if (handler.canChange(event, getEventContext())) {
      await changeTemporaryTool(event.kind, event.buttons);
    }
    if (_isScalingDisabled ?? true) {
      getHandler().onPointerDown(event, getEventContext());
    }
  }

  Future<void> _handlePointerMove(
    PointerMoveEvent event,
    CurrentIndexCubit cubit,
    Handler Function() getHandler,
    EventContext Function() getEventContext,
    Future<void> Function(PointerDeviceKind, int) changeTemporaryTool,
    VoidCallback delayBake,
  ) async {
    if (event.kind == PointerDeviceKind.touch && _isTouchTapGesture) {
      _bufferedEvents.add(event);
      final startPos = _touchStartPositions[event.pointer];
      if (startPos != null && (event.position - startPos).distance > 8.0) {
        _isTouchTapGesture = false;
        _touchTapTimer?.cancel();
        await _flushBufferedEvents(
          cubit,
          getHandler,
          getEventContext,
          changeTemporaryTool,
        );
        _resetTouchTap();
      }
      return;
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
    cubit.updateLastPosition(event.localPosition);
    final currentIndexState = cubit.state;
    if (currentIndexState.moveEnabled &&
        event.kind != PointerDeviceKind.stylus) {
      if (currentIndexState.pointers.isEmpty) {
        return;
      }
      if (event.pointer == currentIndexState.pointers.first) {
        final transform = context.read<TransformCubit>().state;
        cubit.move(-event.delta / transform.size);
        delayBake();
      }
      return;
    }
    if (_isScalingDisabled ?? true) {
      getHandler().onPointerMove(event, getEventContext());
    }
  }

  Future<void> _handlePointerUp(
    PointerUpEvent event,
    CurrentIndexCubit cubit,
    Handler Function() getHandler,
    EventContext Function() getEventContext,
    Future<void> Function(PointerDeviceKind, int) changeTemporaryTool,
  ) async {
    if (event.kind == PointerDeviceKind.touch && _isTouchTapGesture) {
      _bufferedEvents.add(event);
      _touchStartPositions.remove(event.pointer);
      if (_touchStartPositions.isEmpty) {
        _touchTapTimer?.cancel();
        _touchTapTimer = Timer(const Duration(milliseconds: 250), () async {
          if (!_isTouchTapGesture) return;
          final config = context.read<SettingsCubit>().state.inputConfiguration;
          String? shortcutId;
          if (_fingersInvolved == 2) {
            shortcutId = config.doubleTouchShortcut;
          } else if (_fingersInvolved >= 3) {
            shortcutId = config.tripleTouchShortcut;
          }

          if (shortcutId != null && shortcutId.isNotEmpty) {
            final def = keybinder.definitions.firstWhereOrNull(
              (d) => d.id == shortcutId,
            );
            if (def != null) {
              Actions.maybeInvoke(context, def.intent);
            }
          } else {
            await _flushBufferedEvents(
              cubit,
              getHandler,
              getEventContext,
              changeTemporaryTool,
            );
          }
          _resetTouchTap();
        });
      }
      return;
    }

    cubit.updateLastPosition(event.localPosition);
    if (_isScalingDisabled ?? true) {
      await getHandler().onPointerUp(event, getEventContext());
    }
    cubit.removePointer(event.pointer);
  }

  Future<void> _handlePointerCancel(
    PointerCancelEvent event,
    CurrentIndexCubit cubit,
    Handler Function() getHandler,
    EventContext Function() getEventContext,
    Future<void> Function(PointerDeviceKind, int) changeTemporaryTool,
  ) async {
    if (event.kind == PointerDeviceKind.touch && _isTouchTapGesture) {
      _isTouchTapGesture = false;
      _touchTapTimer?.cancel();
      _bufferedEvents.add(event);
      await _flushBufferedEvents(
        cubit,
        getHandler,
        getEventContext,
        changeTemporaryTool,
      );
      _resetTouchTap();
      return;
    }

    cubit.removePointer(event.pointer);
    cubit.removeButtons();
    if (cubit.state.pointers.isEmpty) {
      _isScalingDisabled = null;
    }
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final bloc = context.read<DocumentBloc>();
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    if (state != AppLifecycleState.resumed) {
      context.read<CurrentIndexCubit>().resetInput(bloc);
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
    RulerHandler? ruler;
    double previousRulerRotation = 0;
    return SizedBox.expand(
      child: RepaintBoundary(
        child: LayoutBuilder(
          builder: (context, constraints) {
            void bake() {
              context.read<DocumentBloc>().bake(
                viewportSize: constraints.biggest,
                pixelRatio: MediaQuery.of(context).devicePixelRatio,
              );
            }

            void delayBake() {
              context.read<DocumentBloc>().delayedBake(
                viewportSize: constraints.biggest,
                pixelRatio: MediaQuery.of(context).devicePixelRatio,
                testTransform: true,
              );
            }

            final bloc = context.read<DocumentBloc>();

            Future<void> changeTemporaryTool(
              PointerDeviceKind kind,
              int buttons,
            ) async {
              InputMapping? nextPointerMapping;
              final config = context
                  .read<SettingsCubit>()
                  .state
                  .inputConfiguration;
              final cubit = context.read<CurrentIndexCubit>();
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
                cubit.resetDownHandler(bloc);
                return;
              }
              if (nextPointerMapping.getCategory() ==
                  InputMappingCategory.handTool) {
                cubit.changeTemporaryHandlerMove();
              } else {
                final int? index = nextPointerMapping.getToolPositionIndex();
                if (index != null) {
                  await cubit.changeTemporaryHandlerIndex(
                    context,
                    index,
                    temporaryState: TemporaryState.removeAfterClick,
                  );
                }
              }
            }

            final current = context.read<DocumentBloc>().state;
            if (current is DocumentLoadSuccess &&
                current.cameraViewport.toSize() !=
                    Size(
                      constraints.biggest.width.ceilToDouble(),
                      constraints.biggest.height.ceilToDouble(),
                    )) {
              bake();
            }
            return BlocBuilder<DocumentBloc, DocumentState>(
              builder: (context, state) {
                if (state is! DocumentLoaded) {
                  return const Center(child: CircularProgressIndicator());
                }

                var openView = false;
                var point = Offset.zero;
                final CurrentIndexCubit cubit = context
                    .read<CurrentIndexCubit>();

                Handler getHandler() {
                  if (state is DocumentPresentationState) return state.handler;
                  return cubit.getHandler();
                }

                return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                  buildWhen: (previous, current) =>
                      previous.cameraViewport != current.cameraViewport ||
                      previous.foregrounds != current.foregrounds ||
                      previous.handler != current.handler ||
                      previous.temporaryHandler != current.temporaryHandler ||
                      previous.toggleableForegrounds !=
                          current.toggleableForegrounds ||
                      previous.temporaryForegrounds !=
                          current.temporaryForegrounds ||
                      previous.rendererStates != current.rendererStates ||
                      previous.networkingForegrounds !=
                          current.networkingForegrounds ||
                      previous.temporaryRendererStates !=
                          current.temporaryRendererStates ||
                      previous.cursor != current.cursor ||
                      previous.temporaryCursor != current.temporaryCursor,
                  builder: (context, currentIndex) => Actions(
                    actions: getHandler().getActions(context),
                    child: DefaultTextEditingShortcuts(
                      child: Focus(
                        child: MouseRegion(
                          cursor: currentIndex.currentCursor,
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
                                  cubit.removeButtons();
                                  cubit.resetReleaseHandler(bloc);
                                },
                                onTapDown: (details) => getHandler().onTapDown(
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
                                  if (_isScalingDisabled ?? true) {
                                    handler.onScaleUpdate(
                                      details,
                                      getEventContext(),
                                    );
                                    return;
                                  }
                                  if (ruler != null) {
                                    final deltaRotation =
                                        (details.rotation -
                                            previousRulerRotation) *
                                        180 /
                                        pi;
                                    previousRulerRotation = details.rotation;
                                    ruler?.transform(
                                      getEventContext(),
                                      position: details.focalPointDelta,
                                      rotation: deltaRotation,
                                    );
                                    return;
                                  }
                                  final cubit = context
                                      .read<CurrentIndexCubit>();
                                  if (openView) openView = details.scale == 1;
                                  final settings = context
                                      .read<SettingsCubit>()
                                      .state;
                                  if (cubit.fetchHandler<SelectHandler>() ==
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
                                    cubit.move(
                                      -details.focalPointDelta /
                                          sensitivity /
                                          cubit.state.transformCubit.state.size,
                                    );
                                  } else {
                                    cubit.zoom(
                                      current / sensitivity + 1,
                                      point,
                                    );
                                  }
                                  size = details.scale;
                                  delayBake();
                                },
                                onLongPressEnd: (details) => getHandler()
                                    .onLongPressEnd(details, getEventContext()),
                                onScaleEnd: (details) {
                                  getHandler().onScaleEnd(
                                    details,
                                    getEventContext(),
                                  );
                                  if (!(_isScalingDisabled ?? true)) {
                                    var sensitivity = context
                                        .read<SettingsCubit>()
                                        .state
                                        .gestureSensitivity;
                                    cubit.slide(
                                      details.velocity.pixelsPerSecond /
                                          sensitivity /
                                          cubit.state.transformCubit.state.size,
                                      details.scaleVelocity,
                                    );
                                    delayBake();
                                  }
                                  ruler = null;
                                  previousRulerRotation = 0;
                                  cubit.removeButtons();
                                  cubit.resetReleaseHandler(bloc);
                                },
                                onScaleStart: (details) {
                                  _isScalingDisabled ??=
                                      !cubit.state.moveEnabled;
                                  if (_isScalingDisabled != false) {
                                    _isScalingDisabled = cubit
                                        .getHandler()
                                        .onScaleStart(
                                          details,
                                          getEventContext(),
                                        );
                                  } else {
                                    cubit.getHandler().onScaleStartAbort(
                                      details,
                                      getEventContext(),
                                    );
                                  }
                                  ruler = RulerHandler.getFirstRuler(
                                    currentIndex,
                                    details.localFocalPoint,
                                    constraints.biggest,
                                  );
                                  previousRulerRotation = 0;
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
                                    if (state is! DocumentLoadSuccess) return;
                                    if (pointerSignal is PointerScrollEvent) {
                                      // dx and dy are the delta between the last scroll event
                                      var dx = pointerSignal.scrollDelta.dx;
                                      var dy = pointerSignal.scrollDelta.dy;
                                      // Get zoom by dx and dy
                                      var scale = pointerSignal.size;
                                      var sensitivity = context
                                          .read<SettingsCubit>()
                                          .state
                                          .scrollSensitivity;
                                      scale /= -sensitivity * 100;
                                      scale += 1;
                                      dx /= sensitivity;
                                      dy /= sensitivity;
                                      final cubit = context
                                          .read<CurrentIndexCubit>();
                                      final transform = context
                                          .read<TransformCubit>()
                                          .state;
                                      if (_mouseState == _MouseState.scale) {
                                        // Calculate the new scale using dx and dy
                                        scale = -(dx + dy / 2) / 100 + 1;
                                        cubit.zoom(
                                          scale,
                                          pointerSignal.localPosition,
                                        );
                                      } else {
                                        cubit
                                          ..move(
                                            (_mouseState == _MouseState.inverse
                                                    ? Offset(dy, dx)
                                                    : Offset(dx, dy)) /
                                                transform.size,
                                          )
                                          ..zoom(
                                            scale,
                                            pointerSignal.localPosition,
                                          );
                                      }
                                      delayBake();
                                    }
                                  },
                                  onPointerPanZoomStart: (event) {
                                    _isScalingDisabled = false;
                                  },
                                  onPointerDown: (event) => _handlePointerDown(
                                    event,
                                    cubit,
                                    getHandler,
                                    getEventContext,
                                    changeTemporaryTool,
                                  ),
                                  onPointerUp: (event) => _handlePointerUp(
                                    event,
                                    cubit,
                                    getHandler,
                                    getEventContext,
                                    changeTemporaryTool,
                                  ),
                                  behavior: HitTestBehavior.translucent,
                                  onPointerHover: (event) {
                                    cubit.updateLastPosition(
                                      event.localPosition,
                                    );
                                    getHandler().onPointerHover(
                                      event,
                                      getEventContext(),
                                    );
                                  },
                                  onPointerMove: (event) => _handlePointerMove(
                                    event,
                                    cubit,
                                    getHandler,
                                    getEventContext,
                                    changeTemporaryTool,
                                    delayBake,
                                  ),
                                  onPointerCancel: (event) =>
                                      _handlePointerCancel(
                                        event,
                                        cubit,
                                        getHandler,
                                        getEventContext,
                                        changeTemporaryTool,
                                      ),
                                  child: _buildCanvas(
                                    currentIndex,
                                    cubit,
                                    state,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCanvas(
    CurrentIndex currentIndex,
    CurrentIndexCubit cubit,
    DocumentLoaded state,
  ) {
    return BlocListener<TransformCubit, CameraTransform>(
      listenWhen: (previous, current) =>
          previous.friction?.lastUpdate != current.friction?.lastUpdate,
      listener: (context, transform) {
        final friction = transform.friction;
        if (friction == null) {
          _animationController.stop();
          _positionAnimation = null;
          return;
        }
        _positionAnimation = Tween<Offset>(
          begin:
              friction.beginOffset - (_positionAnimation?.value ?? Offset.zero),
          end: Offset.zero,
        ).animate(_animationController);
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
        _animationController.forward(from: 0);
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
                    currentIndex.getAllForegrounds(),
                    state.data,
                    state.page,
                    state.info,
                    ColorScheme.of(context),
                    frictionTransform,
                    cubit.state.selection,
                    state.settingsCubit.state.navigatorPosition,
                  ),
                  painter: ViewPainter(
                    state.data,
                    state.page,
                    state.info,
                    cameraViewport: currentIndex.cameraViewport,
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
