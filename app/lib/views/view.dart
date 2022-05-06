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

class MainViewViewport extends StatefulWidget {
  const MainViewViewport({Key? key}) : super(key: key);

  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

enum _MouseState { normal, inverse, scale }

class _MainViewViewportState extends State<MainViewViewport> {
  double size = 1.0;
  GlobalKey paintKey = GlobalKey();
  _MouseState _mouseState = _MouseState.normal;

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
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: ClipRRect(
            child: LayoutBuilder(
                builder: (context, constraints) =>
                    BlocBuilder<DocumentBloc, DocumentState>(
                        builder: (context, state) {
                      if (state is! DocumentLoadSuccess) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      void _bake([CameraTransform? transform]) {
                        context.read<DocumentBloc>().add(ImageBaked(
                            constraints.biggest,
                            MediaQuery.of(context).devicePixelRatio,
                            transform ?? context.read<TransformCubit>().state));
                      }

                      if (state.cameraViewport.toSize() !=
                          Size(constraints.biggest.width.roundToDouble(),
                              constraints.biggest.height.roundToDouble())) {
                        _bake();
                      }

                      var openView = false;
                      final CurrentIndexCubit cubit =
                          context.read<CurrentIndexCubit>();

                      return GestureDetector(
                          onTapUp: (details) {
                            cubit
                                .getHandler()
                                .onTapUp(constraints.biggest, context, details);
                          },
                          onTapDown: (details) {
                            cubit.getHandler().onTapDown(
                                constraints.biggest, context, details);
                          },
                          onSecondaryTapUp: (details) {
                            cubit.getHandler().onSecondaryTapUp(
                                constraints.biggest, context, details);
                          },
                          onScaleUpdate: (details) {
                            if (details.scale == 1) return;
                            if (openView) openView = details.scale == 1;
                            var transformCubit = context.read<TransformCubit>();
                            var current = details.scale;
                            current = current - size;
                            current += 1;
                            var sensitivity = context
                                .read<SettingsCubit>()
                                .state
                                .touchSensitivity;
                            transformCubit.zoom(
                                (1 - current) / -sensitivity + 1,
                                details.localFocalPoint);
                            if (cubit.fetchHandler<HandHandler>() != null &&
                                details.pointerCount == 2) {
                              transformCubit.move(details.focalPointDelta);
                            }
                            size = details.scale;
                          },
                          onLongPressEnd: (details) {
                            cubit.getHandler().onLongPressEnd(
                                constraints.biggest, context, details);
                          },
                          onScaleEnd: (details) => _bake(),
                          onScaleStart: (details) {
                            size = 1;
                          },
                          child: Listener(
                              onPointerSignal: (pointerSignal) {
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
                                    scale =
                                        -(dx + dy / 2) / sensitivity / 100 + 1;
                                    cubit.zoom(
                                        scale, pointerSignal.localPosition);
                                  } else {
                                    cubit
                                      ..move(_mouseState == _MouseState.inverse
                                          ? Offset(-dy, -dx)
                                          : Offset(-dx, -dy))
                                      ..zoom(
                                          scale, pointerSignal.localPosition);
                                  }
                                  _bake(cubit.state);
                                }
                              },
                              onPointerDown: (PointerDownEvent event) {
                                cubit.getHandler().onPointerDown(
                                    constraints.biggest, context, event);
                              },
                              onPointerUp: (PointerUpEvent event) async {
                                cubit.getHandler().onPointerUp(
                                    constraints.biggest, context, event);
                              },
                              behavior: HitTestBehavior.translucent,
                              onPointerHover: (event) {
                                cubit.getHandler().onPointerHover(
                                    constraints.biggest, context, event);
                              },
                              onPointerMove: (PointerMoveEvent event) async {
                                cubit.getHandler().onPointerMove(
                                    constraints.biggest, context, event);
                              },
                              child:
                                  BlocBuilder<TransformCubit, CameraTransform>(
                                builder: (context, transform) {
                                  return BlocBuilder<CurrentIndexCubit,
                                      CurrentIndex>(
                                    builder: (context, currentIndex) =>
                                        Stack(children: [
                                      Container(color: Colors.white),
                                      CustomPaint(
                                        size: Size.infinite,
                                        foregroundPainter: ForegroundPainter(
                                          currentIndex.foregrounds,
                                          transform,
                                          currentIndex.selections,
                                        ),
                                        painter: ViewPainter(state.document,
                                            cameraViewport:
                                                state.cameraViewport,
                                            transform: transform,
                                            currentArea: state.currentArea),
                                        isComplex: true,
                                        willChange: true,
                                      )
                                    ]),
                                  );
                                },
                              )));
                    }))));
  }
}
