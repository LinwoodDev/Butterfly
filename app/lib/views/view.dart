import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_painter.dart';

const kSecondaryStylusButton = 0x20;

class MainViewViewport extends StatefulWidget {
  const MainViewViewport({super.key});

  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

enum _MouseState { normal, inverse, scale }

class _MainViewViewportState extends State<MainViewViewport> {
  double size = 1.0;
  GlobalKey paintKey = GlobalKey();
  _MouseState _mouseState = _MouseState.normal;
  bool _isShiftPressed = false, _isAltPressed = false, _isCtrlPressed = false;

  @override
  void initState() {
    super.initState();

    RawKeyboard.instance.addListener(_handleKey);
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKey);
    super.dispose();
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
      void _bake() {
        context.read<DocumentBloc>().bake(
            viewportSize: constraints.biggest,
            pixelRatio: MediaQuery.of(context).devicePixelRatio);
      }

      void _delayBake() {
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
            _bake();
          }
        });
      }

      final current = context.read<DocumentBloc>().state;
      if (current is DocumentLoadSuccess &&
          current.cameraViewport.toSize() !=
              Size(constraints.biggest.width.ceilToDouble(),
                  constraints.biggest.height.ceilToDouble())) {
        _bake();
      }
      return BlocBuilder<DocumentBloc, DocumentState>(
          builder: (context, state) {
        if (state is! DocumentLoadSuccess) {
          return const Center(child: CircularProgressIndicator());
        }

        var openView = false;
        final CurrentIndexCubit cubit = context.read<CurrentIndexCubit>();

        EventContext getEventContext() => EventContext(
            context,
            constraints.biggest,
            _isShiftPressed,
            _isAltPressed,
            _isCtrlPressed);

        return GestureDetector(
            onTapUp: (details) {
              cubit.getHandler().onTapUp(details, getEventContext());
            },
            onTapDown: (details) {
              cubit.getHandler().onTapDown(details, getEventContext());
            },
            onSecondaryTapUp: (details) {
              cubit.getHandler().onSecondaryTapUp(details, getEventContext());
            },
            onScaleUpdate: (details) {
              cubit.getHandler().onScaleUpdate(details, getEventContext());
              if (details.scale == 1) return;
              if (openView) openView = details.scale == 1;
              final transformCubit = context.read<TransformCubit>();
              final currentIndex = context.read<CurrentIndexCubit>();
              final settings = context.read<SettingsCubit>().state;
              if (currentIndex.fetchHandler<HandHandler>() == null &&
                  !settings.inputGestures) return;
              var current = details.scale;
              current = current - size;
              current += 1;
              var sensitivity =
                  context.read<SettingsCubit>().state.touchSensitivity;
              var point = details.localFocalPoint;
              transformCubit.zoom((1 - current) / -sensitivity + 1, point);
              size = details.scale;
            },
            onLongPressEnd: (details) {
              cubit.getHandler().onLongPressEnd(details, getEventContext());
            },
            onScaleEnd: (details) {
              cubit.getHandler().onScaleEnd(details, getEventContext());
              final currentIndex = context.read<CurrentIndexCubit>();
              if (currentIndex.fetchHandler<HandHandler>() == null &&
                  !cubit.state.moveEnabled) return;
              _delayBake();
            },
            onScaleStart: (details) {
              cubit.getHandler().onScaleStart(details, getEventContext());
              size = 1;
            },
            onDoubleTapDown: (details) {
              cubit.getHandler().onDoubleTapDown(details, getEventContext());
            },
            onLongPressDown: (details) {
              cubit.getHandler().onLongPressDown(details, getEventContext());
            },
            child: Listener(
                onPointerSignal: (pointerSignal) {
                  if (pointerSignal is PointerScrollEvent) {
                    // dx and dy are the delta between the last scroll event
                    var dx = pointerSignal.scrollDelta.dx;
                    var dy = pointerSignal.scrollDelta.dy;
                    // Get zoom by dx and dy
                    var scale = pointerSignal.size;
                    var sensitivity =
                        context.read<SettingsCubit>().state.mouseSensitivity;
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
                    _delayBake();
                  }
                },
                onPointerDown: (PointerDownEvent event) {
                  cubit.addPointer(event.pointer);
                  final document = state.document;
                  final currentArea = state.currentArea;
                  if (event.buttons == kPrimaryStylusButton) {
                    cubit.changeTemporaryHandlerHand(document, currentArea);
                  } else if (event.buttons == kSecondaryStylusButton) {
                    cubit.changeTemporaryHandlerSecondary(
                        document, currentArea);
                  }
                  cubit.getHandler().onPointerDown(event, getEventContext());
                },
                onPointerUp: (PointerUpEvent event) async {
                  cubit.removePointer(event.pointer);
                  cubit.getHandler().onPointerUp(event, getEventContext());
                  cubit.resetTemporaryHandler(
                      state.document, state.currentArea);
                },
                behavior: HitTestBehavior.translucent,
                onPointerHover: (event) {
                  cubit.getHandler().onPointerHover(event, getEventContext());
                },
                onPointerMove: (PointerMoveEvent event) async {
                  if (cubit.state.moveEnabled &&
                      event.kind != PointerDeviceKind.stylus) {
                    if (event.pointer == cubit.state.pointers.first) {
                      final transformCubit = context.read<TransformCubit>();
                      transformCubit
                          .move(event.delta / transformCubit.state.size);
                    }
                    return;
                  }
                  cubit.getHandler().onPointerMove(event, getEventContext());
                },
                child: BlocBuilder<TransformCubit, CameraTransform>(
                  builder: (context, transform) {
                    return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                      builder: (context, currentIndex) => Stack(children: [
                        Container(color: Colors.white),
                        CustomPaint(
                          size: Size.infinite,
                          foregroundPainter: ForegroundPainter(
                            cubit.foregrounds,
                            state.document,
                            Theme.of(context).primaryColor,
                            transform,
                            cubit.state.selection?.rects ?? [],
                          ),
                          painter: ViewPainter(state.document,
                              cameraViewport: currentIndex.cameraViewport,
                              transform: transform,
                              invisibleLayers: state.invisibleLayers,
                              currentArea: state.currentArea),
                          isComplex: true,
                          willChange: true,
                        )
                      ]),
                    );
                  },
                )));
      });
    })));
  }
}
