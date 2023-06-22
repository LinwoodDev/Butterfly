import 'dart:io';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/intent.dart';
import '../services/import.dart';
import '../view_painter.dart';

const kSecondaryStylusButton = 0x20;

class MainViewViewport extends StatefulWidget {
  const MainViewViewport({super.key});

  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

enum _MouseState { normal, inverse, scale }

class _MainViewViewportState extends State<MainViewViewport>
    with WidgetsBindingObserver {
  double size = 1.0;
  GlobalKey paintKey = GlobalKey();
  _MouseState _mouseState = _MouseState.normal;
  bool _isShiftPressed = false,
      _isAltPressed = false,
      _isCtrlPressed = false,
      _isScalingDisabled = false;

  @override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_handleKey);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    RawKeyboard.instance.removeListener(_handleKey);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final bloc = context.read<DocumentBloc>();
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    if (state == AppLifecycleState.resumed) {
      if (!kIsWeb && Platform.isAndroid) {
        final intentType = await getIntentType();
        final intentData = await getIntentData();
        if (intentType != null && intentData != null) {
          final assetType = AssetFileTypeHelper.fromMime(intentType);
          if (assetType == null) return;
          if (mounted) {
            context
                .read<ImportService>()
                .import(assetType, intentData, blocState.data);
          }
        }
      }
      bloc.refresh();
    } else {
      context.read<CurrentIndexCubit>().resetInput(bloc);
    }
  }

  void _handleKey(RawKeyEvent event) {
    if (event.data.isShiftPressed) {
      _mouseState = _MouseState.inverse;
    } else if (event.data.isControlPressed) {
      _mouseState = _MouseState.scale;
    } else {
      _mouseState = _MouseState.normal;
    }

    _isShiftPressed = event.data.isShiftPressed;
    _isAltPressed = event.data.isAltPressed;
    _isCtrlPressed = event.data.isControlPressed;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: ClipRRect(child: LayoutBuilder(builder: (context, constraints) {
      void bake() {
        context.read<DocumentBloc>().bake(
            viewportSize: constraints.biggest,
            pixelRatio: MediaQuery.of(context).devicePixelRatio);
      }

      void delayBake() {
        final transform = context.read<TransformCubit>().state;
        final currentSize = transform.size;
        final currentPosition = transform.position;
        Future.delayed(const Duration(milliseconds: 100), () {
          final state = context.read<DocumentBloc>().state;
          if (state is! DocumentLoadSuccess) return;
          final transform = context.read<TransformCubit>().state;
          if (currentSize == transform.size &&
              currentPosition == transform.position &&
              (currentSize != state.cameraViewport.scale ||
                  currentPosition != state.cameraViewport.toOffset())) {
            bake();
          }
        });
      }

      Future<void> changeTemporaryPainter(
          PointerDeviceKind kind, int buttons) async {
        int? nextPointerIndex;
        final bloc = context.read<DocumentBloc>();
        final config = context.read<SettingsCubit>().state.inputConfiguration;
        switch (kind) {
          case PointerDeviceKind.touch:
            nextPointerIndex = config.touch;
            break;
          case PointerDeviceKind.mouse:
            if (buttons == kPrimaryMouseButton) {
              nextPointerIndex = config.leftMouse;
            } else if (buttons == kMiddleMouseButton) {
              nextPointerIndex = config.middleMouse;
            } else if (buttons == kSecondaryMouseButton) {
              nextPointerIndex = config.rightMouse;
            }
            break;
          case PointerDeviceKind.stylus:
            nextPointerIndex = config.pen;
            if (buttons == kPrimaryStylusButton) {
              nextPointerIndex = config.firstPenButton;
            } else if (buttons == kSecondaryStylusButton) {
              nextPointerIndex = config.secondPenButton;
            }
            break;
          default:
            return;
        }
        final cubit = context.read<CurrentIndexCubit>();
        if (nextPointerIndex == null) {
          cubit.resetTemporaryHandler(bloc);
        } else if (nextPointerIndex <= 0) {
          cubit.changeTemporaryHandlerMove();
        } else {
          await cubit.changeTemporaryHandlerIndex(bloc, nextPointerIndex);
        }
      }

      final current = context.read<DocumentBloc>().state;
      if (current is DocumentLoadSuccess &&
          current.cameraViewport.toSize() !=
              Size(constraints.biggest.width.ceilToDouble(),
                  constraints.biggest.height.ceilToDouble())) {
        bake();
      }
      return BlocBuilder<DocumentBloc, DocumentState>(
          builder: (context, state) {
        if (state is! DocumentLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        var openView = false;
        final CurrentIndexCubit cubit = context.read<CurrentIndexCubit>();
        var point = Offset.zero;

        Handler getHandler() {
          if (state is DocumentPresentationState) return state.handler;
          return cubit.getHandler();
        }

        return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
            buildWhen: (previous, current) =>
                previous.cameraViewport != current.cameraViewport ||
                previous.foregrounds != current.foregrounds ||
                previous.temporaryForegrounds != current.temporaryForegrounds,
            builder: (context, currentIndex) => Actions(
                actions: getHandler().getActions(context),
                child: DefaultTextEditingShortcuts(
                  child: Focus(
                    child: Builder(builder: (context) {
                      EventContext getEventContext() {
                        return EventContext(context, constraints.biggest,
                            _isShiftPressed, _isAltPressed, _isCtrlPressed);
                      }

                      return GestureDetector(
                        onTapUp: (details) {
                          getHandler().onTapUp(details, getEventContext());
                        },
                        onTapDown: (details) {
                          getHandler().onTapDown(details, getEventContext());
                        },
                        onSecondaryTapUp: (details) {
                          getHandler()
                              .onSecondaryTapUp(details, getEventContext());
                        },
                        onScaleUpdate: (details) {
                          final handler = getHandler();
                          handler.onScaleUpdate(details, getEventContext());
                          if (_isScalingDisabled) return;
                          final currentIndex =
                              context.read<CurrentIndexCubit>();
                          final transformCubit = context.read<TransformCubit>();
                          if (details.scale == 1) {
                            return;
                          }
                          if (openView) openView = details.scale == 1;
                          final settings = context.read<SettingsCubit>().state;
                          if (currentIndex.fetchHandler<HandHandler>() ==
                                  null &&
                              !settings.inputGestures) return;
                          var current = details.scale;
                          current = current - size;
                          current += 1;
                          var sensitivity = context
                              .read<SettingsCubit>()
                              .state
                              .touchSensitivity;
                          transformCubit.zoom(
                              (1 - current) / -sensitivity + 1, point);
                          size = details.scale;
                        },
                        onLongPressEnd: (details) {
                          getHandler()
                              .onLongPressEnd(details, getEventContext());
                        },
                        onScaleEnd: (details) {
                          getHandler().onScaleEnd(details, getEventContext());
                          if (!_isScalingDisabled) delayBake();
                          _isScalingDisabled = false;
                        },
                        onScaleStart: (details) {
                          _isScalingDisabled = cubit
                              .getHandler()
                              .onScaleStart(details, getEventContext());
                          size = 1;
                          point = details.localFocalPoint;
                        },
                        onDoubleTapDown: (details) {
                          getHandler()
                              .onDoubleTapDown(details, getEventContext());
                        },
                        onDoubleTap: () {
                          getHandler().onDoubleTap(getEventContext());
                        },
                        onLongPressDown: (details) {
                          getHandler()
                              .onLongPressDown(details, getEventContext());
                        },
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
                                  .mouseSensitivity;
                              scale /= -sensitivity * 100;
                              scale += 1;
                              var cubit = context.read<TransformCubit>();
                              if (_mouseState == _MouseState.scale) {
                                // Calculate the new scale using dx and dy
                                scale = -(dx + dy / 2) / sensitivity / 100 + 1;
                                cubit.zoom(scale, pointerSignal.localPosition);
                              } else {
                                cubit
                                  ..move((_mouseState == _MouseState.inverse
                                          ? Offset(-dy, -dx)
                                          : Offset(-dx, -dy)) /
                                      cubit.state.size)
                                  ..zoom(scale, pointerSignal.localPosition);
                              }
                              delayBake();
                            }
                          },
                          onPointerDown: (PointerDownEvent event) async {
                            cubit.addPointer(event.pointer);
                            cubit.setButtons(event.buttons);
                            final handler = getHandler();
                            if (handler.canChange(event, getEventContext())) {
                              await changeTemporaryPainter(
                                  event.kind, event.buttons);
                            }
                            getHandler()
                                .onPointerDown(event, getEventContext());
                          },
                          onPointerUp: (PointerUpEvent event) async {
                            getHandler().onPointerUp(event, getEventContext());
                            cubit.removePointer(event.pointer);
                            cubit.removeButtons();
                          },
                          behavior: HitTestBehavior.translucent,
                          onPointerHover: (event) {
                            getHandler()
                                .onPointerHover(event, getEventContext());
                          },
                          onPointerMove: (PointerMoveEvent event) async {
                            if (cubit.state.moveEnabled &&
                                event.kind != PointerDeviceKind.stylus) {
                              if (event.pointer == cubit.state.pointers.first) {
                                final transformCubit =
                                    context.read<TransformCubit>();
                                transformCubit.move(
                                    event.delta / transformCubit.state.size);
                                delayBake();
                              }
                              getHandler().onPointerGestureMove(
                                  event, getEventContext());
                              return;
                            }
                            getHandler()
                                .onPointerMove(event, getEventContext());
                          },
                          child: BlocBuilder<TransformCubit, CameraTransform>(
                            builder: (context, transform) => Stack(children: [
                              Container(color: Colors.white),
                              CustomPaint(
                                size: Size.infinite,
                                foregroundPainter: ForegroundPainter(
                                  [
                                    ...cubit.foregrounds,
                                  ],
                                  state.data,
                                  state.page,
                                  state.info,
                                  Theme.of(context).colorScheme,
                                  transform,
                                  cubit.state.selection,
                                  currentIndex.cameraViewport.tool,
                                ),
                                painter: ViewPainter(
                                  state.data,
                                  state.page,
                                  state.info,
                                  cameraViewport: currentIndex.cameraViewport,
                                  transform: transform,
                                  invisibleLayers: state.invisibleLayers,
                                  currentArea: state.currentArea,
                                  colorScheme: Theme.of(context).colorScheme,
                                ),
                                isComplex: true,
                                willChange: true,
                              )
                            ]),
                          ),
                        ),
                      );
                    }),
                  ),
                )));
      });
    })));
  }
}
