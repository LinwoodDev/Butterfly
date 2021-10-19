import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/label.dart';
import 'package:butterfly/models/elements/path.dart';
import 'package:flutter/material.dart';

class ViewPainter extends CustomPainter {
  final AppDocument document;
  final ElementLayer? editingLayer;
  final bool renderBackground;

  ViewPainter(this.document, this.editingLayer, {this.renderBackground = true});
  @override
  void paint(Canvas canvas, Size size, {Offset offset = Offset.zero}) {
    var background = document.background;
    if (background is BoxBackground && renderBackground) {
      canvas.drawColor(background.boxColor, BlendMode.srcOver);
      if (background.boxWidth > 0 && background.boxXCount > 0) {
        double x = -offset.dx;
        x += background.boxXSpace;
        int count = 0;
        while (x < size.width) {
          canvas.drawLine(
              Offset(x, 0),
              Offset(x, size.height),
              Paint()
                ..strokeWidth = background.boxXStroke
                ..color = background.boxXColor);
          count++;
          if (count >= background.boxXCount) {
            count = 0;
            x += background.boxXSpace;
          }
          x += background.boxWidth;
        }
      }
      if (background.boxHeight > 0 && background.boxYCount > 0) {
        double y = -offset.dy;
        y += background.boxYSpace;
        int count = 0;
        while (y < size.width) {
          canvas.drawLine(
              Offset(0, y),
              Offset(size.width, y),
              Paint()
                ..strokeWidth = background.boxYStroke
                ..color = background.boxYColor);
          count++;
          if (count >= background.boxYCount) {
            count = 0;
            y += background.boxYSpace;
          }
          y += background.boxHeight;
        }
      }
    }
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    List<ElementLayer>.from(document.content)
      ..addAll([if (editingLayer != null) editingLayer!])
      ..asMap().forEach((index, element) {
        if (element is PathElement) {
          element.paint(canvas, offset);
        } else if (element is LabelElement) {
          TextSpan span = TextSpan(
              style: TextStyle(
                  fontSize: element.size,
                  color: element.color,
                  fontWeight: element.fontWeight,
                  decorationColor: element.decorationColor,
                  decorationStyle: element.decorationStyle,
                  decorationThickness: element.decorationThickness,
                  decoration: TextDecoration.combine([
                    if (element.underline) TextDecoration.underline,
                    if (element.lineThrough) TextDecoration.lineThrough,
                    if (element.overline) TextDecoration.overline,
                  ])),
              text: element.text);
          TextPainter tp = TextPainter(
              text: span,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              textScaleFactor: 1.0);
          tp.layout();
          var position = element.position;
          position += offset;
          tp.paint(canvas, position);
        }
      });
    canvas.restore();
  }

  @override
  bool shouldRepaint(ViewPainter oldDelegate) => document != oldDelegate.document;
}
