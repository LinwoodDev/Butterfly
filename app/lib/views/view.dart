import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/painter.dart';
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

class _MainViewViewportState extends State<MainViewViewport> {
  double size = 1.0;
  GlobalKey paintKey = GlobalKey();
  bool shift = false;

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
    shift = event.data.isShiftPressed;
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

                      if (state.bakedViewport?.toSize() !=
                          Size(constraints.biggest.width.roundToDouble(),
                              constraints.biggest.height.roundToDouble())) {
                        _bake();
                      }

                      var openView = false;

                      return GestureDetector(
                          onSecondaryTapUp: (details) {
                            state.currentIndex.handler
                                .onSecondaryTapUp(context, details);
                          },
                          onScaleUpdate: (details) {
                            if (state.currentPainter is! AreaPainter &&
                                (state.currentPainter != null ||
                                    details.scale == 1)) return;
                            if (openView) openView = details.scale == 1;
                            var cubit = context.read<TransformCubit>();
                            var current = details.scale;
                            current = current - size;
                            current += 1;
                            var sensitivity = context
                                .read<SettingsCubit>()
                                .state
                                .touchSensitivity;
                            cubit.zoom((1 - current) / -sensitivity + 1,
                                details.localFocalPoint);
                            if (state.currentPainter != null &&
                                details.pointerCount == 2) {
                              cubit.move(details.focalPointDelta);
                            }
                            size = details.scale;
                          },
                          onLongPressEnd: (details) {
                            state.currentIndex.handler
                                .onLongPressEnd(context, details);
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
                                  cubit
                                    ..move(shift
                                        ? Offset(-dy, -dx)
                                        : Offset(-dx, -dy))
                                    ..zoom(scale, pointerSignal.localPosition);
                                  _bake(cubit.state);
                                }
                              },
                              onPointerDown: (PointerDownEvent event) {
                                state.currentIndex.handler
                                    .onPointerDown(context, event);
                              },
                              onPointerUp: (PointerUpEvent event) async {
                                state.currentIndex.handler
                                    .onPointerUp(context, event);
                              },
                              behavior: HitTestBehavior.translucent,
                              onPointerHover: (event) {
                                state.currentIndex.handler
                                    .onPointerHover(context, event);
                              },
                              onPointerMove: (PointerMoveEvent event) async {
                                state.currentIndex.handler
                                    .onPointerMove(context, event);
                              },
                              child:
                                  BlocBuilder<TransformCubit, CameraTransform>(
                                builder: (context, transform) {
                                  return Stack(children: [
                                    Container(color: Colors.white),
                                    CustomPaint(
                                      size: Size.infinite,
                                      foregroundPainter: ForegroundPainter(
                                        state.currentIndex.foregrounds,
                                        transform,
                                        state.currentIndex.selections,
                                        state.document.areas,
                                      ),
                                      painter: ViewPainter(state.document,
                                          elements: state.elements,
                                          bakedViewport: state.bakedViewport,
                                          transform: transform,
                                          currentArea: state.currentArea),
                                      isComplex: true,
                                      willChange: true,
                                    )
                                  ]);
                                },
                              )));
                    }))));
  }
}
