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

  late Matrix4 transform;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return LayoutBuilder(builder: (context, constraints) {
            final viewportSize = Size(constraints.maxWidth, constraints.maxHeight);
            if (_homeMatrix == null) {
              _homeMatrix = Matrix4.identity()
                ..translate(viewportSize.width / 2 - _paintViewport.width / 2,
                    viewportSize.height / 2 - _paintViewport.height / 2);
              transform = _homeMatrix!;
            }
            if (state is DocumentLoadSuccess) {
              return ClipRect(
                  child: Container(
                      color: Colors.white,
                      child: RawGestureDetector(
                        gestures: {
                          ScaleGestureRecognizer:
                              GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
                            () => ScaleGestureRecognizer(),
                            (ScaleGestureRecognizer instance) {
                              instance
                                ..onUpdate = (details) {
                                  setState(() {
                                    transform = transform.scaled(details.scale);
                                  });
                                };
                            },
                          ),
                        },
                        child: Listener(
                            onPointerSignal: (pointerSignal) {
                              if (pointerSignal is PointerScrollEvent)
                                setState(() {
                                  // Scale the matrix
                                  transform = transform
                                    ..scale(1 - pointerSignal.scrollDelta.dy / 1000,
                                        1 - pointerSignal.scrollDelta.dy / 1000, 1);
                                });
                            },
                            onPointerMove: (PointerMoveEvent event) {
                              if (event.kind != PointerDeviceKind.stylus)
                                setState(
                                    () => transform..translate(event.delta.dx, event.delta.dy));
                              else {
                                // Add
                              }
                            },
                            child: Container(
                                color: Colors.grey,
                                child: Transform(
                                  transform: transform,
                                  child: SizedBox.expand(
                                    child: CustomPaint(
                                      size: _paintViewport,
                                      painter: PathPainter(),
                                    ),
                                  ),
                                ))),
                      )));
            }
            return Container();
          });
        });
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    const offsetY = -200;
    Path path = Path();
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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
