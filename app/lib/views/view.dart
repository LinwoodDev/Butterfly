import 'dart:async';
import 'dart:math';

import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/helpers/pdf_direct.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_painter.dart';
import 'zoom_box.dart';

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
  String? _lastDirectPdfAlignedSessionKey;
  String? _lastDirectPdfAlignedPageKey;

  // Touch gesture buffering
  final List<PointerEvent> _bufferedEvents = [];
  final Map<int, Offset> _touchStartPositions = {};
  int _fingersInvolved = 0;
  bool _isTouchTapGesture = false;
  Timer? _touchTapTimer;
  final Set<int> _overlayBlockedPointers = {};
  Timer? _directPdfPagePreviewCommitTimer;
  double _directPdfPagePreviewAccumulator = 0;
  int? _directPdfPreviewTargetIndex;

  void _resetTouchTap() {
    _bufferedEvents.clear();
    _touchStartPositions.clear();
    _isTouchTapGesture = false;
    _fingersInvolved = 0;
  }

  bool _canUseDirectPdfPagePreview(DocumentLoaded state) {
    if (!state.isDirectPdfSession || state.currentArea == null) {
      return false;
    }
    if (state.data.getPages(true).length <= 1) {
      return false;
    }
    return context.read<TransformCubit>().state.size <= 1.05;
  }

  void _clearDirectPdfPagePreview({bool clearAccumulator = true}) {
    _directPdfPagePreviewCommitTimer?.cancel();
    _directPdfPagePreviewCommitTimer = null;
    final hadPreview = _directPdfPreviewTargetIndex != null;
    _directPdfPreviewTargetIndex = null;
    if (clearAccumulator) {
      _directPdfPagePreviewAccumulator = 0;
    }
    if (hadPreview && mounted) {
      setState(() {});
    }
  }

  void _updateDirectPdfPagePreview(
    DocumentLoaded state,
    double delta, {
    required double threshold,
    bool commitOnIdle = false,
  }) {
    if (!_canUseDirectPdfPagePreview(state) || threshold <= 0) {
      return;
    }
    final pages = state.data.getPages(true);
    final currentIndex = pages.indexOf(state.pageName);
    if (currentIndex == -1) return;

    _directPdfPagePreviewAccumulator += delta;
    final steps = _directPdfPagePreviewAccumulator.abs() ~/ threshold;
    final direction = _directPdfPagePreviewAccumulator > 0
        ? 1
        : _directPdfPagePreviewAccumulator < 0
        ? -1
        : 0;
    final nextIndex = direction == 0 || steps == 0
        ? currentIndex
        : (currentIndex + direction * steps).clamp(0, pages.length - 1);
    final nextPreview = nextIndex == currentIndex ? null : nextIndex;
    if (nextPreview != _directPdfPreviewTargetIndex && mounted) {
      setState(() {
        _directPdfPreviewTargetIndex = nextPreview;
      });
    }

    if (commitOnIdle) {
      _directPdfPagePreviewCommitTimer?.cancel();
      _directPdfPagePreviewCommitTimer = Timer(
        const Duration(milliseconds: 220),
        () async {
          if (!mounted) return;
          final blocState = context.read<DocumentBloc>().state;
          if (blocState is! DocumentLoadSuccess) {
            _clearDirectPdfPagePreview();
            return;
          }
          await _commitDirectPdfPagePreview(blocState);
        },
      );
    }
  }

  Future<void> _commitDirectPdfPagePreview(DocumentLoaded state) async {
    _directPdfPagePreviewCommitTimer?.cancel();
    _directPdfPagePreviewCommitTimer = null;
    final targetIndex = _directPdfPreviewTargetIndex;
    final pages = state.data.getPages(true);
    final currentIndex = pages.indexOf(state.pageName);
    if (mounted) {
      setState(() {
        _directPdfPreviewTargetIndex = null;
        _directPdfPagePreviewAccumulator = 0;
      });
    } else {
      _directPdfPreviewTargetIndex = null;
      _directPdfPagePreviewAccumulator = 0;
    }
    if (targetIndex == null ||
        targetIndex == currentIndex ||
        targetIndex < 0 ||
        targetIndex >= pages.length) {
      return;
    }
    context.read<DocumentBloc>().add(PageChanged(pages[targetIndex]));
  }

  ZoomBoxHitRegion _zoomBoxHitRegion(
    CurrentIndexCubit cubit,
    Offset localPosition,
    EventContext context,
    PointerDeviceKind? kind,
  ) {
    for (final handler
        in cubit.state.toggleableHandlers.values.whereType<ZoomBoxHandler>()) {
      final hit = handler.hitTest(
        localPosition,
        context.viewportSize,
        context.getCameraTransform(),
        kind,
      );
      if (hit != ZoomBoxHitRegion.none) return hit;
    }
    return ZoomBoxHitRegion.none;
  }

  bool _shouldBlockMainPointerEvent(
    PointerEvent event,
    CurrentIndexCubit cubit,
    EventContext context,
  ) {
    if (_overlayBlockedPointers.contains(event.pointer)) return true;
    return _zoomBoxHitRegion(cubit, event.localPosition, context, event.kind) ==
        ZoomBoxHitRegion.controls;
  }

  List<Handler> _toggleableHandlers(CurrentIndexCubit cubit) =>
      cubit.state.toggleableHandlers.values.toList(growable: false);

  void _dispatchToggleablePointerDown(
    PointerDownEvent event,
    EventContext context,
    CurrentIndexCubit cubit,
  ) {
    for (final handler in _toggleableHandlers(cubit)) {
      handler.onPointerDown(event, context);
    }
  }

  void _dispatchToggleablePointerMove(
    PointerMoveEvent event,
    EventContext context,
    CurrentIndexCubit cubit,
  ) {
    for (final handler in _toggleableHandlers(cubit)) {
      handler.onPointerMove(event, context);
    }
  }

  void _dispatchToggleablePointerUp(
    PointerUpEvent event,
    EventContext context,
    CurrentIndexCubit cubit,
  ) {
    for (final handler in _toggleableHandlers(cubit)) {
      handler.onPointerUp(event, context);
    }
  }

  void _dispatchToggleablePointerHover(
    PointerHoverEvent event,
    EventContext context,
    CurrentIndexCubit cubit,
  ) {
    for (final handler in _toggleableHandlers(cubit)) {
      handler.onPointerHover(event, context);
    }
  }

  Future<void> _flushBufferedEvents(
    CurrentIndexCubit cubit,
    Handler Function() getHandler,
    EventContext Function() getEventContext,
    Future<void> Function(PointerDeviceKind, int) changeTemporaryTool,
  ) async {
    for (final e in _bufferedEvents) {
      final eventContext = getEventContext();
      if (e is PointerDownEvent) {
        if (_shouldBlockMainPointerEvent(e, cubit, eventContext)) {
          _overlayBlockedPointers.add(e.pointer);
          continue;
        }
        _isScalingDisabled = e.kind == PointerDeviceKind.trackpad
            ? false
            : null;
        cubit.addPointer(e.pointer);
        cubit.setButtons(e.buttons);
        final handler = getHandler();
        if (handler.canChange(e, eventContext)) {
          await changeTemporaryTool(e.kind, e.buttons);
        }
        if (_isScalingDisabled ?? true) {
          _dispatchToggleablePointerDown(e, eventContext, cubit);
          getHandler().onPointerDown(e, eventContext);
        }
      } else if (e is PointerMoveEvent) {
        if (_overlayBlockedPointers.contains(e.pointer)) continue;
        cubit.updateLastPosition(e.localPosition);
        if (_isScalingDisabled ?? true) {
          _dispatchToggleablePointerMove(e, eventContext, cubit);
          getHandler().onPointerMove(e, eventContext);
        }
      } else if (e is PointerUpEvent) {
        if (_overlayBlockedPointers.remove(e.pointer)) continue;
        cubit.updateLastPosition(e.localPosition);
        if (_isScalingDisabled ?? true) {
          await getHandler().onPointerUp(e, eventContext);
          _dispatchToggleablePointerUp(e, eventContext, cubit);
        }
        cubit.removePointer(e.pointer);
      } else if (e is PointerCancelEvent) {
        _overlayBlockedPointers.remove(e.pointer);
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
    final eventContext = getEventContext();
    // Detect pen/stylus input
    if (event.kind == PointerDeviceKind.stylus ||
        event.kind == PointerDeviceKind.invertedStylus) {
      cubit.setPenDetected(true);
    }
    if (_shouldBlockMainPointerEvent(event, cubit, eventContext)) {
      _overlayBlockedPointers.add(event.pointer);
      return;
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
    if (handler.canChange(event, eventContext)) {
      await changeTemporaryTool(event.kind, event.buttons);
    }
    if (_isScalingDisabled ?? true) {
      _dispatchToggleablePointerDown(event, eventContext, cubit);
      getHandler().onPointerDown(event, eventContext);
    }
  }

  Future<void> _handlePointerMove(
    PointerMoveEvent event,
    CurrentIndexCubit cubit,
    DocumentLoaded state,
    Handler Function() getHandler,
    EventContext Function() getEventContext,
    Future<void> Function(PointerDeviceKind, int) changeTemporaryTool,
    VoidCallback delayBake,
  ) async {
    final eventContext = getEventContext();
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
    if (_overlayBlockedPointers.contains(event.pointer)) {
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
        cubit.move(
          -event.delta / transform.size,
          currentArea: state.currentArea,
        );
        delayBake();
      }
      return;
    }
    if (_isScalingDisabled ?? true) {
      _dispatchToggleablePointerMove(event, eventContext, cubit);
      getHandler().onPointerMove(event, eventContext);
    }
  }

  Future<void> _handlePointerUp(
    PointerUpEvent event,
    CurrentIndexCubit cubit,
    Handler Function() getHandler,
    EventContext Function() getEventContext,
    Future<void> Function(PointerDeviceKind, int) changeTemporaryTool,
  ) async {
    final eventContext = getEventContext();
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
            if (shortcutId == 'long_press') {
              final firstEvent = _bufferedEvents.first;
              final handler = getHandler();
              final eventContext = getEventContext();
              handler.onLongPressDown(
                LongPressDownDetails(
                  globalPosition: firstEvent.position,
                  localPosition: firstEvent.localPosition,
                  kind: PointerDeviceKind.touch,
                ),
                eventContext,
              );
              handler.onLongPressStart(
                LongPressStartDetails(
                  globalPosition: firstEvent.position,
                  localPosition: firstEvent.localPosition,
                ),
                eventContext,
              );
              handler.onLongPressEnd(
                LongPressEndDetails(
                  globalPosition: firstEvent.position,
                  localPosition: firstEvent.localPosition,
                ),
                eventContext,
              );
            } else {
              final def = keybinder.definitions.firstWhereOrNull(
                (d) => d.id == shortcutId,
              );
              if (def != null) {
                Actions.maybeInvoke(context, def.intent);
              }
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
    if (_overlayBlockedPointers.remove(event.pointer)) {
      return;
    }

    cubit.updateLastPosition(event.localPosition);
    if (_isScalingDisabled ?? true) {
      await getHandler().onPointerUp(event, eventContext);
      _dispatchToggleablePointerUp(event, eventContext, cubit);
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
    _overlayBlockedPointers.remove(event.pointer);
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
    _touchTapTimer?.cancel();
    _directPdfPagePreviewCommitTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final bloc = context.read<DocumentBloc>();
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    if (state != AppLifecycleState.resumed) {
      await context.read<CurrentIndexCubit>().resetInput(bloc);
      if (shouldForceDirectPdfSaveOnExit(blocState)) {
        await bloc.save(force: true);
      }
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
              final settings = context.read<SettingsCubit>().state;
              final config = settings.inputConfiguration;
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

            return BlocBuilder<DocumentBloc, DocumentState>(
              builder: (context, state) {
                if (state is! DocumentLoaded) {
                  _lastDirectPdfAlignedSessionKey = null;
                  _lastDirectPdfAlignedPageKey = null;
                  return const Center(child: CircularProgressIndicator());
                }

                final pendingDirectPdfAlignment =
                    state.isDirectPdfSession &&
                    state.currentArea != null &&
                    constraints.biggest.width > 0 &&
                    constraints.biggest.height > 0 &&
                    _lastDirectPdfAlignedPageKey !=
                        '${state.directPdfSourceUri ?? state.location.identifier}'
                            '::${state.pageName}';
                if (pendingDirectPdfAlignment) {
                  final sessionKey =
                      state.directPdfSourceUri ?? state.location.identifier;
                  final pageKey = '$sessionKey::${state.pageName}';
                  final resetZoom =
                      _lastDirectPdfAlignedSessionKey != sessionKey;
                  final targetZoom = resetZoom
                      ? 1.0
                      : context.read<TransformCubit>().state.size;
                  _lastDirectPdfAlignedSessionKey = sessionKey;
                  _lastDirectPdfAlignedPageKey = pageKey;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    final blocState = context.read<DocumentBloc>().state;
                    if (blocState is! DocumentLoaded ||
                        !blocState.isDirectPdfSession ||
                        blocState.currentArea == null) {
                      return;
                    }
                    final currentSessionKey =
                        blocState.directPdfSourceUri ??
                        blocState.location.identifier;
                    final currentPageKey =
                        '$currentSessionKey::${blocState.pageName}';
                    if (currentPageKey != pageKey) return;
                    context.read<TransformCubit>().centerToArea(
                      blocState.currentArea!,
                      constraints.biggest,
                      targetZoom,
                    );
                    unawaited(
                      context.read<DocumentBloc>().bake(
                        viewportSize: constraints.biggest,
                        pixelRatio: MediaQuery.devicePixelRatioOf(context),
                        reset: true,
                      ),
                    );
                  });
                } else {
                  _lastDirectPdfAlignedSessionKey = null;
                  _lastDirectPdfAlignedPageKey = null;
                }

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
                  builder: (context, currentIndex) {
                    if (state is DocumentLoadSuccess &&
                        currentIndex.cameraViewport.toSize() !=
                            Size(
                              constraints.biggest.width.ceilToDouble(),
                              constraints.biggest.height.ceilToDouble(),
                            ) &&
                        !pendingDirectPdfAlignment) {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => bake(),
                      );
                    }
                    return Actions(
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
                                  onTapDown: (details) => getHandler()
                                      .onTapDown(details, getEventContext()),
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
                                    final directPdfPreviewThreshold = min(
                                      180.0,
                                      max(
                                        72.0,
                                        constraints.biggest.height * 0.18,
                                      ),
                                    );
                                    if (details.scale == 1 &&
                                        _canUseDirectPdfPagePreview(state) &&
                                        details.focalPointDelta.dy.abs() >
                                            details.focalPointDelta.dx.abs()) {
                                      _updateDirectPdfPagePreview(
                                        state,
                                        -details.focalPointDelta.dy,
                                        threshold: directPdfPreviewThreshold,
                                      );
                                      return;
                                    }
                                    if (details.scale == 1) {
                                      cubit.move(
                                        -details.focalPointDelta /
                                            sensitivity /
                                            cubit
                                                .state
                                                .transformCubit
                                                .state
                                                .size,
                                        currentArea: state.currentArea,
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
                                  onLongPressEnd: (details) =>
                                      getHandler().onLongPressEnd(
                                        details,
                                        getEventContext(),
                                      ),
                                  onScaleEnd: (details) {
                                    getHandler().onScaleEnd(
                                      details,
                                      getEventContext(),
                                    );
                                    if (_directPdfPreviewTargetIndex != null ||
                                        _directPdfPagePreviewAccumulator != 0) {
                                      unawaited(
                                        _commitDirectPdfPagePreview(state),
                                      );
                                      ruler = null;
                                      previousRulerRotation = 0;
                                      cubit.removeButtons();
                                      cubit.resetReleaseHandler(bloc);
                                      return;
                                    }
                                    if (!(_isScalingDisabled ?? true)) {
                                      var sensitivity = context
                                          .read<SettingsCubit>()
                                          .state
                                          .gestureSensitivity;
                                      cubit.slide(
                                        details.velocity.pixelsPerSecond /
                                            sensitivity /
                                            cubit
                                                .state
                                                .transformCubit
                                                .state
                                                .size,
                                        details.scaleVelocity,
                                        currentArea: state.currentArea,
                                      );
                                      delayBake();
                                    }
                                    ruler = null;
                                    previousRulerRotation = 0;
                                    cubit.removeButtons();
                                    cubit.resetReleaseHandler(bloc);
                                  },
                                  onScaleStart: (details) {
                                    _directPdfPagePreviewCommitTimer?.cancel();
                                    _directPdfPagePreviewCommitTimer = null;
                                    _directPdfPagePreviewAccumulator = 0;
                                    if (_directPdfPreviewTargetIndex != null) {
                                      setState(() {
                                        _directPdfPreviewTargetIndex = null;
                                      });
                                    }
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
                                        if (_mouseState == _MouseState.normal &&
                                            _canUseDirectPdfPagePreview(
                                              state,
                                            ) &&
                                            dy.abs() > dx.abs()) {
                                          _updateDirectPdfPagePreview(
                                            state,
                                            dy,
                                            threshold: 72,
                                            commitOnIdle: true,
                                          );
                                          return;
                                        }
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
                                              (_mouseState ==
                                                          _MouseState.inverse
                                                      ? Offset(dy, dx)
                                                      : Offset(dx, dy)) /
                                                  transform.size,
                                              currentArea: state.currentArea,
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
                                    onPointerDown: (event) =>
                                        _handlePointerDown(
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
                                      final eventContext = getEventContext();
                                      if (_shouldBlockMainPointerEvent(
                                        event,
                                        cubit,
                                        eventContext,
                                      )) {
                                        return;
                                      }
                                      cubit.updateLastPosition(
                                        event.localPosition,
                                      );
                                      _dispatchToggleablePointerHover(
                                        event,
                                        eventContext,
                                        cubit,
                                      );
                                      getHandler().onPointerHover(
                                        event,
                                        eventContext,
                                      );
                                    },
                                    onPointerMove: (event) =>
                                        _handlePointerMove(
                                          event,
                                          cubit,
                                          state,
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
    CurrentIndex currentIndex,
    CurrentIndexCubit cubit,
    DocumentLoaded state,
  ) {
    final toneMode = state.isDirectPdfSession
        ? context.watch<SettingsCubit>().state.pdfPageToneMode
        : PdfPageToneMode.normal;
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
            final colorScheme = ColorScheme.of(context);
            final zoomBoxEntry = currentIndex.toggleableHandlers.entries
                .firstWhereOrNull((entry) => entry.value is ZoomBoxHandler);
            final pageCanvas = CustomPaint(
              size: Size.infinite,
              foregroundPainter: ForegroundPainter(
                currentIndex.getAllForegrounds(),
                state.data,
                state.page,
                state.info,
                colorScheme,
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
                colorScheme: colorScheme,
              ),
              isComplex: true,
              willChange: true,
            );
            Rect? directPdfPageRect;
            if (state.isDirectPdfSession && state.currentArea != null) {
              final area = state.currentArea!;
              final rect = Rect.fromLTWH(
                area.position.x,
                area.position.y,
                area.width,
                area.height,
              );
              directPdfPageRect = Rect.fromPoints(
                frictionTransform.globalToLocal(rect.topLeft),
                frictionTransform.globalToLocal(rect.bottomRight),
              );
            }
            return Stack(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color.alphaBlend(
                      colorScheme.shadow.withValues(alpha: 0.03),
                      colorScheme.surfaceDim,
                    ),
                  ),
                ),
                if (directPdfPageRect != null) ...[
                  Positioned.fromRect(
                    rect: directPdfPageRect,
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: colorScheme.outlineVariant,
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.shadow.withValues(alpha: 0.18),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ClipRect(
                    clipper: _ViewportRectClipper(directPdfPageRect),
                    child: applyPdfToneMode(pageCanvas, toneMode),
                  ),
                ] else
                  applyPdfToneMode(pageCanvas, toneMode),
                if (zoomBoxEntry != null)
                  ZoomBoxOverlay(
                    handler: zoomBoxEntry.value as ZoomBoxHandler,
                    toolIndex: zoomBoxEntry.key,
                    documentState: state,
                    currentIndex: currentIndex,
                    transform: frictionTransform,
                  ),
                if (state.isDirectPdfSession &&
                    _directPdfPreviewTargetIndex != null)
                  _DirectPdfPagePreviewOverlay(
                    state: state,
                    targetIndex: _directPdfPreviewTargetIndex!,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ViewportRectClipper extends CustomClipper<Rect> {
  final Rect rect;

  const _ViewportRectClipper(this.rect);

  @override
  Rect getClip(Size size) => rect;

  @override
  bool shouldReclip(covariant _ViewportRectClipper oldClipper) =>
      oldClipper.rect != rect;
}

class _DirectPdfPagePreviewOverlay extends StatelessWidget {
  final DocumentLoaded state;
  final int targetIndex;

  const _DirectPdfPagePreviewOverlay({
    required this.state,
    required this.targetIndex,
  });

  @override
  Widget build(BuildContext context) {
    final pageNames = state.data.getPages();
    final realPageNames = state.data.getPages(true);
    if (targetIndex < 0 || targetIndex >= realPageNames.length) {
      return const SizedBox.shrink();
    }
    final currentIndex = realPageNames.indexOf(state.pageName);
    final label = pageNames.elementAtOrNull(targetIndex) ?? state.pageName;
    final directionIcon = targetIndex > currentIndex
        ? Icons.keyboard_arrow_down_rounded
        : Icons.keyboard_arrow_up_rounded;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Positioned.fill(
      child: IgnorePointer(
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.18),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(directionIcon, size: 32, color: colorScheme.primary),
                  const SizedBox(height: 8),
                  Text(label, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    '${targetIndex + 1} / ${realPageNames.length}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
