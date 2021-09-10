import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/paint.dart';
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
  Matrix4? _homeMatrix;
  static const Size _paintViewport = const Size(1000, 2000);
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
            //final viewportSize = Size(constraints.maxWidth, constraints.maxHeight);
            if (_homeMatrix == null) {
              _homeMatrix = Matrix4.identity()
                  /*..translate(viewportSize.width / 2 - _paintViewport.width / 2,
                    viewportSize.height / 2 - _paintViewport.height / 2)*/
                  ;
            }
            if (state is DocumentLoadSuccess) {
              Matrix4 transform = state.transform ?? _homeMatrix!;
              return ClipRect(
                  child: Container(
                      color: Colors.white,
                      child: Transform(
                          transform: transform,
                          child: Listener(
                              onPointerSignal: (pointerSignal) {
                                if (pointerSignal is PointerScrollEvent) {
                                  // Scale the matrix
                                  var up = transform.up;
                                  print(up);
                                  if (up.y < 3.5 && pointerSignal.scrollDelta.dy < 0 ||
                                      up.y > 0.5 && pointerSignal.scrollDelta.dy > 0) {
                                    widget.bloc.add(TransformChanged(Matrix4.copy(transform)
                                      ..scale(1 - pointerSignal.scrollDelta.dy / 200,
                                          1 - pointerSignal.scrollDelta.dy / 200, 1)));
                                  }
                                }
                              },
                              onPointerDown: (PointerDownEvent event) {
                                if (event.kind == PointerDeviceKind.stylus)
                                  widget.bloc.add(EditingLayerChanged(
                                      PaintElement(points: [event.localPosition])));
                              },
                              onPointerUp: (PointerUpEvent event) {
                                if (event.kind == PointerDeviceKind.stylus &&
                                    state.currentEditLayer != null) {
                                  widget.bloc.add(LayerCreated());
                                }
                              },
                              onPointerMove: (PointerMoveEvent event) {
                                if (event.kind != PointerDeviceKind.stylus)
                                  widget.bloc.add(TransformChanged(Matrix4.copy(transform)
                                    ..translate(event.delta.dx, event.delta.dy)));
                                else if (state.currentEditLayer != null &&
                                    state.currentEditLayer is PaintElement) {
                                  // Add point to custom paint
                                  var layer = state.currentEditLayer as PaintElement;
                                  widget.bloc.add(EditingLayerChanged(layer.copyWith(
                                      points: List.from(layer.points)..add(event.localPosition))));
                                }
                              },
                              child: Container(
                                color: Colors.grey,
                                child: SizedBox.expand(
                                  child: CustomPaint(
                                    size: _paintViewport,
                                    painter: PathPainter(state.document, state.currentEditLayer),
                                  ),
                                ),
                              )))));
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
    path.lineTo(size.width, size.height);
    path.cubicTo(size.width / 4, 3 * size.height / 4, 3 * size.width / 4, size.height / 4,
        size.width, size.height);
    path.addRect(Rect.fromLTWH(size.width / 2 - 125, size.height / 2 - 50 + offsetY, 250, 100));
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
