import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/paint.dart';
import 'package:butterfly/models/tool.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainViewViewport extends StatefulWidget {
  final DocumentBloc bloc;

  const MainViewViewport({Key? key, required this.bloc}) : super(key: key);
  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

class _MainViewViewportState extends State<MainViewViewport> {
  final TransformationController _transformationController = TransformationController();
  GlobalKey transformKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<DocumentBloc, DocumentState>(
          bloc: widget.bloc,
          builder: (context, state) {
            if (state is DocumentLoadSuccess) {
              _transformationController.value = state.transform ?? _transformationController.value;
              var transform = _transformationController.value;
              var translation = transform.getTranslation();
              final viewportSize = Size(constraints.maxWidth * 8 * translation.x,
                  constraints.maxHeight * 8 * translation.y);
              print("REBUILD!");
              return Listener(
                  onPointerSignal: (pointerSignal) {
                    /*if (pointerSignal is PointerScrollEvent) {
                          // Scale the matrix
                          var up = transform.up;
                          if (up.y < 3.5 && pointerSignal.scrollDelta.dy < 0 ||
                              up.y > 0.5 && pointerSignal.scrollDelta.dy > 0) {
                            widget.bloc.add(TransformChanged(Matrix4.copy(transform)
                              ..scale(1 - pointerSignal.scrollDelta.dy / 200,
                                  1 - pointerSignal.scrollDelta.dy / 200, 1)
                              ..translate(
                                  pointerSignal.localPosition.dx *
                                      pointerSignal.scrollDelta.dx /
                                      200,
                                  pointerSignal.localPosition.dy *
                                      pointerSignal.scrollDelta.dy /
                                      200,
                                  0)));
                          }
                        }*/
                  },
                  onPointerDown: (PointerDownEvent event) {
                    if (event.kind == PointerDeviceKind.stylus ||
                        state.currentTool == ToolType.edit)
                      widget.bloc.add(EditingLayerChanged(PaintElement(points: [
                        (transformKey.currentContext?.findRenderObject() as RenderBox)
                            .globalToLocal(event.position)
                      ])));
                  },
                  onPointerUp: (PointerUpEvent event) {
                    if ((event.kind == PointerDeviceKind.stylus ||
                            state.currentTool == ToolType.edit) &&
                        state.currentEditLayer != null) {
                      widget.bloc.add(LayerCreated());
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  onPointerMove: (PointerMoveEvent event) {
                    var translation = transform.getTranslation();
                    if (event.kind != PointerDeviceKind.stylus &&
                        state.currentTool != ToolType.edit) {
                      var next = Matrix4.copy(transform)
                        ..translate(
                          event.localPosition.dx,
                          event.localPosition.dy,
                        );
                      print(next == state.transform);
                      widget.bloc.add(TransformChanged(next));
                    } else if (state.currentEditLayer != null &&
                        state.currentEditLayer is PaintElement) {
                      // Add point to custom paint
                      var layer = state.currentEditLayer as PaintElement;
                      var offset = event.position;
                      /*offset = Offset(offset.dx * transform.up.y * transform.up.y,
                            offset.dy * transform.up.y);*/
                      offset = ((transformKey.currentContext?.findRenderObject() as RenderBox)
                          .globalToLocal(offset));
                      widget.bloc.add(EditingLayerChanged(
                          layer.copyWith(points: List.from(layer.points)..add(offset))));
                    }
                  },
                  child: InteractiveViewer(
                      constrained: false,
                      panEnabled: false,
                      scaleEnabled: false,
                      transformationController: _transformationController,
                      child: CustomPaint(
                        key: transformKey,
                        size: viewportSize,
                        painter: PathPainter(state.document, state.currentEditLayer),
                      )));
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
    path.addRect(Rect.fromLTWH(50, 50, 250, 100));
    canvas.drawPath(path, paint);
    TextSpan span = new TextSpan(
        style: new TextStyle(fontSize: 24, color: Colors.blue[800]), text: "Welcome to Butterfly");
    TextPainter tp =
        new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(
        canvas,
        new Offset(size.width / 2 - (tp.size.width / 2),
            size.height / 2 - (tp.size.height / 2) + offsetY));
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
