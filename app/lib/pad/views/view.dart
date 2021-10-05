import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/paint.dart';
import 'package:butterfly/models/tool.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:vector_math/vector_math_64.dart' show Vector3;

class MainViewViewport extends StatefulWidget {
  final DocumentBloc bloc;

  const MainViewViewport({Key? key, required this.bloc}) : super(key: key);
  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

class _MainViewViewportState extends State<MainViewViewport> {
  bool _moveEnabled = false;
  late TransformationController _controller;
  GlobalKey transformKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    _controller.addListener(() => widget.bloc.add(TransformChanged(_controller.value)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return LayoutBuilder(builder: (context, constraints) {
            final viewportSize = Size(constraints.maxWidth, constraints.maxHeight);
            if (state is DocumentLoadSuccess) {
              Matrix4 transform = state.transform ?? Matrix4.identity();
              var translation = -transform.getTranslation();
              var paintViewport = Size(translation.x * 4 + viewportSize.width * 4,
                  translation.y * 4 + viewportSize.height * 4);
              _controller.value = state.transform ?? _controller.value;
              List<ElementLayer> raycast(Offset offset) {
                return state.document.content.where((element) => element.hit(offset)).toList();
              }

              return SizedBox.expand(
                child: Listener(
                  onPointerSignal: (pointerSignal) {
                    if (pointerSignal is PointerScrollEvent) {
                      // Scale the matrix
                      var up = transform.up;
                      if (up.y < 3.5 && pointerSignal.scrollDelta.dy < 0 ||
                          up.y > 0.5 && pointerSignal.scrollDelta.dy > 0) {
                        widget.bloc.add(TransformChanged(Matrix4.copy(transform)
                          ..scale(1 - pointerSignal.scrollDelta.dy / 200,
                              1 - pointerSignal.scrollDelta.dy / 200, 1)));
                      }
                    }
                  },
                  onPointerDown: (PointerDownEvent event) {
                    if (event.kind == PointerDeviceKind.stylus ||
                        state.currentTool == ToolType.edit && !state.editOption.eraser) {
                      widget.bloc.add(EditOptionChanged(state.editOption.copyWith(eraser: false)));
                      widget.bloc.add(EditingLayerChanged(PaintElement(
                          color: state.editOption.color,
                          strokeWidth: state.editOption.strokeWidth,
                          points: [_controller.toScene(event.localPosition)])));
                    } else if (event.kind != PointerDeviceKind.stylus &&
                        state.currentTool == ToolType.view) {
                      setState(() => _moveEnabled = true);
                    }
                  },
                  onPointerUp: (PointerUpEvent event) {
                    if ((event.kind == PointerDeviceKind.stylus ||
                            state.currentTool == ToolType.edit) &&
                        state.currentEditLayer != null) {
                      widget.bloc.add(const LayerCreated());
                    }
                    setState(() => _moveEnabled = false);
                  },
                  behavior: HitTestBehavior.translucent,
                  onPointerMove: (PointerMoveEvent event) {
                    if ((event.kind == PointerDeviceKind.stylus ||
                        state.currentTool == ToolType.edit)) {
                      if (state.editOption.eraser) {
                        widget.bloc
                            .add(LayersRemoved(raycast(_controller.toScene(event.localPosition))));
                      } else if (state.currentEditLayer != null &&
                          state.currentEditLayer is PaintElement) {
                        // Add point to custom paint
                        var layer = state.currentEditLayer as PaintElement;
                        widget.bloc.add(EditingLayerChanged(layer.copyWith(
                            points: List.from(layer.points)
                              ..add(_controller.toScene(event.localPosition)))));
                      }
                    }
                  },
                  child: InteractiveViewer(
                    constrained: false,
                    transformationController: _controller,
                    panEnabled: _moveEnabled,
                    minScale: 0.5,
                    maxScale: 2.5,
                    scaleEnabled: _moveEnabled,
                    child: Container(
                      color: Colors.white,
                      child: CustomPaint(
                        key: transformKey,
                        size: paintViewport,
                        painter: PathPainter(state.document, state.currentEditLayer),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          });
        });
  }
}

class PathPainter extends CustomPainter {
  final AppDocument document;
  final ElementLayer? editingLayer;

  PathPainter(this.document, this.editingLayer);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    Path path = Path();
    path.cubicTo(0, 500, 0, 500, 5000, 500);
    path.addRect(const Rect.fromLTWH(50, 50, 250, 100));
    canvas.drawPath(path, paint);
    TextSpan span = TextSpan(
        style: TextStyle(fontSize: 24, color: Colors.blue[800]), text: "Welcome to Butterfly");
    TextPainter tp =
        TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, const Offset(500, 500));
    List.from(document.content)
      ..addAll([if (editingLayer != null) editingLayer])
      ..forEach((element) {
        if (element is PaintElement) {
          canvas.drawPath(element.buildPath(), element.buildPaint());
        }
      });
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => document != oldDelegate.document;
}
