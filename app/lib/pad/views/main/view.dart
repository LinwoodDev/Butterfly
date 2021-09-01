import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';

class MainViewViewport extends StatefulWidget {
  final DocumentBloc bloc;

  const MainViewViewport({Key? key, required this.bloc}) : super(key: key);
  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

class _MainViewViewportState extends State<MainViewViewport> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Listener(
          child: CustomPaint(
            size: Size.infinite,
            painter: PathPainter(),
          ),
        ));
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    path.cubicTo(size.width / 4, 3 * size.height / 4, 3 * size.width / 4, size.height / 4,
        size.width, size.height);
    canvas.drawPath(path, paint);
    TextSpan span = new TextSpan(
        style: new TextStyle(fontSize: 24, color: Colors.blue[800]), text: "Welcome to Butterfly");
    TextPainter tp =
        new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas,
        new Offset(size.width / 2 - (tp.size.width / 2), size.height / 2 - (tp.size.height / 2)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
