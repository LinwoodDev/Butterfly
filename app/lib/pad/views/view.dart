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
  GlobalKey transformKey = GlobalKey();
  @override
  void initState() {
    super.initState();
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
              /*Offset toScene(Offset viewportPoint) {
                // On viewportPoint, perform the inverse transformation of the scene to get
                // where the point would be in the scene before the transformation.
                final Matrix4 inverseMatrix = Matrix4.inverted(transform);
                final Vector3 untransformed = inverseMatrix.transform3(Vector3(
                  viewportPoint.dx,
                  viewportPoint.dy,
                  0,
                ));
                return Offset(untransformed.x, untransformed.y);
              }*/

              Offset getPoint(Offset offset) {
                var localOffset = (transformKey.currentContext?.findRenderObject() as RenderBox)
                    .globalToLocal(offset);
                var globalOffset = offset - localOffset;
                globalOffset *= transform.up.y * transform.up.y;
                // print("----------");
                // print("Offset: $offset");
                // print("Scale: ${transform.up.y}");
                // print("----------");

                return offset - globalOffset;
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
                              1 - pointerSignal.scrollDelta.dy / 200, 1)
                          ..translate(
                              pointerSignal.localPosition.dx * pointerSignal.scrollDelta.dx / 200,
                              pointerSignal.localPosition.dy * pointerSignal.scrollDelta.dy / 200,
                              0)));
                      }
                    }
                  },
                  onPointerDown: (PointerDownEvent event) {
                    if (event.kind == PointerDeviceKind.stylus ||
                        state.currentTool == ToolType.edit) {
                      widget.bloc.add(
                          EditingLayerChanged(PaintElement(points: [getPoint(event.position)])));
                    }
                  },
                  onPointerUp: (PointerUpEvent event) {
                    if ((event.kind == PointerDeviceKind.stylus ||
                            state.currentTool == ToolType.edit) &&
                        state.currentEditLayer != null) {
                      widget.bloc.add(const LayerCreated());
                    }
                  },
                  behavior: HitTestBehavior.translucent,
                  onPointerMove: (PointerMoveEvent event) {
                    var translation = transform.getTranslation();
                    if (event.kind != PointerDeviceKind.stylus &&
                        state.currentTool != ToolType.edit) {
                      widget.bloc.add(TransformChanged(Matrix4.copy(transform)
                        ..translate(
                          ((translation.x + event.delta.dx * 4).clamp(-paintViewport.width, 0) -
                                  translation.x) /
                              transform.up.y,
                          ((translation.y + event.delta.dy * 4).clamp(-paintViewport.height, 0) -
                                  translation.y) /
                              transform.up.y,
                        )));
                    } else if (state.currentEditLayer != null &&
                        state.currentEditLayer is PaintElement) {
                      // Add point to custom paint
                      var layer = state.currentEditLayer as PaintElement;
                      widget.bloc.add(EditingLayerChanged(layer.copyWith(
                          points: List.from(layer.points)..add(getPoint(event.position)))));
                    }
                  },
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.topLeft,
                      minWidth: paintViewport.width,
                      maxWidth: paintViewport.width,
                      minHeight: paintViewport.height,
                      maxHeight: paintViewport.height,
                      child: Transform(
                        filterQuality: FilterQuality.high,
                        transform: transform,
                        child: SizedBox.fromSize(
                          size: paintViewport,
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
    const offsetY = -200;
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
