import 'package:butterfly/models/tools/type.dart';
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
  final GlobalKey _targetKey = GlobalKey();
  final TransformationController _transformationController = TransformationController();
  static const Size _paintViewport = const Size(1000, 2000);
  @override
  void initState() {
    super.initState();
  }

  bool? enabled;
  bool disabledBecauseStylus = false;

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
              _transformationController.value = _homeMatrix!;
            }
            if (enabled == null && state is DocumentLoadSuccess)
              enabled = state.currentTool.type == ToolType.view;
            return ClipRect(
              child: Container(
                  color: Colors.white,
                  child: Listener(
                    onPointerDown: (event) {
                      if (event.kind == PointerDeviceKind.stylus && (enabled ?? true)) {
                        setState(() {
                          print("Pointer enabled");

                          enabled = false;
                          disabledBecauseStylus = true;
                        });
                      }
                    },
                    onPointerUp: (event) {
                      if (event.kind == PointerDeviceKind.stylus && disabledBecauseStylus) {
                        setState(() {
                          enabled = true;
                          print("Pointer disabled");
                          disabledBecauseStylus = false;
                        });
                      }
                    },
                    child: InteractiveViewer(
                      key: _targetKey,
                      panEnabled: enabled ?? false,
                      scaleEnabled: enabled ?? false,
                      minScale: 0.1,
                      maxScale: 5,
                      transformationController: _transformationController,
                      boundaryMargin: EdgeInsets.symmetric(
                          horizontal: viewportSize.width, vertical: viewportSize.height),
                      child: SizedBox.expand(
                        child: Container(
                          color: Colors.grey,
                          child: CustomPaint(
                            size: _paintViewport,
                            painter: PathPainter(),
                          ),
                        ),
                      ),
                    ),
                  )),
            );
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
