import 'dart:math';

import 'package:flutter/painting.dart';
import 'package:xml/xml.dart';

import '../models/element.dart';
import '../models/path_point.dart';
import '../models/property.dart';

class SvgConverter {
  List<PadElement> getContents(XmlElement e) {
    return e.childElements
        .map<PadElement?>((e) {
          switch (e.name.qualified.toLowerCase()) {
            case 'path':
              return getPenElement(e);
            default:
              return null;
          }
        })
        .whereType<PadElement>()
        .toList();
  }

  PenElement getPenElement(XmlElement e) {
    var d = e.getAttribute('d') ?? '';
    var strokeWidth =
        double.tryParse(e.getAttribute('stroke-width') ?? '') ?? 1;
    var points = <PathPoint>[];
    var lastPosition = Offset.zero;

    String number = '';
    String operation = '';
    var color = e.getAttribute('stroke') ?? 'black';
    var fill = ['none', 'transparent'].contains(e.getAttribute('fill'));
    if (fill) {
      color = e.getAttribute('fill') ?? 'black';
    }

    d = d.trim().replaceAll('-', ',-');

    while (d.isNotEmpty || operation.isNotEmpty) {
      var cmd = d.isEmpty ? '' : d[0];
      d = d.isEmpty ? '' : d.substring(1);
      // Add the number to the current operation
      if (RegExp(r'[0-9]|\.|\,|\  |\-').hasMatch(cmd)) {
        number += cmd;
        continue;
      }
      // Split with space and ,
      final args =
          number.split(RegExp(r'[\s,]')).where((s) => s.isNotEmpty).toList();
      switch (operation) {
        case 'M':
          lastPosition =
              Offset(_processExpression(args[0]), _processExpression(args[1]));
          points.add(PathPoint.fromOffset(lastPosition, 0));
          break;
        case 'm':
          lastPosition = Offset(lastPosition.dx + _processExpression(args[0]),
              lastPosition.dy + _processExpression(args[1]));
          points.add(PathPoint.fromOffset(lastPosition, 0));
          break;
        case 'L':
          points.add(PathPoint.fromOffset(
              Offset(_processExpression(args[0]), _processExpression(args[1])),
              strokeWidth));
          break;
        case 'l':
          lastPosition = Offset(lastPosition.dx + _processExpression(args[0]),
              lastPosition.dy + _processExpression(args[1]));
          points.add(PathPoint.fromOffset(lastPosition, strokeWidth));
          break;
        case 'H':
          points.add(PathPoint.fromOffset(
              Offset(_processExpression(args[0]), lastPosition.dy),
              strokeWidth));
          break;
        case 'h':
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx + _processExpression(args[0]),
                  lastPosition.dy),
              strokeWidth));
          break;
        case 'V':
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx, _processExpression(args[0])),
              strokeWidth));
          break;
        case 'v':
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx,
                  lastPosition.dy + _processExpression(args[0])),
              strokeWidth));
          break;
        case 'C':
          points.add(PathPoint.fromOffset(
              Offset(_processExpression(args[0]), _processExpression(args[1])),
              strokeWidth));
          points.add(PathPoint.fromOffset(
              Offset(_processExpression(args[2]), _processExpression(args[3])),
              strokeWidth));
          points.add(PathPoint.fromOffset(
              Offset(_processExpression(args[4]), _processExpression(args[5])),
              strokeWidth));
          break;
        case 'c':
          lastPosition = Offset(lastPosition.dx + _processExpression(args[0]),
              lastPosition.dy + _processExpression(args[1]));
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx, lastPosition.dy), strokeWidth));
          lastPosition = Offset(lastPosition.dx + _processExpression(args[2]),
              lastPosition.dy + _processExpression(args[3]));
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx, lastPosition.dy), strokeWidth));
          lastPosition = Offset(lastPosition.dx + _processExpression(args[4]),
              lastPosition.dy + _processExpression(args[5]));
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx, lastPosition.dy), strokeWidth));
          break;
        case 'S':
          points.add(PathPoint.fromOffset(
              Offset(_processExpression(args[0]), _processExpression(args[1])),
              strokeWidth));
          points.add(PathPoint.fromOffset(
              Offset(_processExpression(args[2]), _processExpression(args[3])),
              strokeWidth));
          break;
        case 's':
          lastPosition = Offset(lastPosition.dx + _processExpression(args[0]),
              lastPosition.dy + _processExpression(args[1]));
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx, lastPosition.dy), strokeWidth));
          lastPosition = Offset(lastPosition.dx + _processExpression(args[2]),
              lastPosition.dy + _processExpression(args[3]));
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx, lastPosition.dy), strokeWidth));
          break;
        case 'Q':
          points.add(PathPoint.fromOffset(
              Offset(_processExpression(args[0]), _processExpression(args[1])),
              strokeWidth));
          points.add(PathPoint.fromOffset(
              Offset(_processExpression(args[2]), _processExpression(args[3])),
              strokeWidth));
          break;
        case 'q':
          lastPosition = Offset(lastPosition.dx + _processExpression(args[0]),
              lastPosition.dy + _processExpression(args[1]));
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx, lastPosition.dy), strokeWidth));
          lastPosition = Offset(lastPosition.dx + _processExpression(args[2]),
              lastPosition.dy + _processExpression(args[3]));
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx, lastPosition.dy), strokeWidth));
          break;
        case 'T':
          points.add(PathPoint.fromOffset(
              Offset(_processExpression(args[0]), _processExpression(args[1])),
              strokeWidth));
          break;
        case 't':
          lastPosition = Offset(lastPosition.dx + _processExpression(args[0]),
              lastPosition.dy + _processExpression(args[1]));
          points.add(PathPoint.fromOffset(
              Offset(lastPosition.dx, lastPosition.dy), strokeWidth));
          break;
        case 'A':
          final rx = _processExpression(args[0]);
          final ry = _processExpression(args[1]);
          final xAxisRotation = _processExpression(args[2]);
          final largeArcFlag = _processExpression(args[3]);
          final sweepFlag = _processExpression(args[4]);
          final x = _processExpression(args[5]);
          final y = _processExpression(args[6]);
          // Calculate points and add to list
          final current = _calculateArc(Offset.zero, Offset(x, y), rx, ry,
              xAxisRotation, largeArcFlag, sweepFlag);
          current.map((e) => PathPoint(x, y)).forEach(points.add);
          break;
        case 'a':
          final rx = _processExpression(args[0]);
          final ry = _processExpression(args[1]);
          final xAxisRotation = _processExpression(args[2]);
          final largeArcFlag = _processExpression(args[3]);
          final sweepFlag = _processExpression(args[4]);
          final x = _processExpression(args[5]);
          final y = _processExpression(args[6]);
          // Calculate points and add to list
          final current = _calculateArc(lastPosition, Offset(x, y), rx, ry,
              xAxisRotation, largeArcFlag, sweepFlag);
          current.map((e) => PathPoint(x, y)).forEach(points.add);
          break;
        case 'Z':
        case 'z':
          // Close path
          points.add(PathPoint.fromOffset(
              Offset(points.first.x, points.first.y), strokeWidth));
          break;
      }
      operation = cmd;
      number = '';
    }
    return PenElement(
        points: points,
        property: PenProperty(
            color: stringToColor(color),
            fill: fill,
            strokeWidth: 0,
            strokeMultiplier: 1));
  }

  List<Offset> _calculateArc(Offset lastPosition, Offset position, double rx,
      double ry, double xAxisRotation, double largeArcFlag, double sweepFlag) {
    // https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths

    // Convert to radians
    xAxisRotation = xAxisRotation * pi / 180;
    final xAxisRotationCos = cos(xAxisRotation);
    final xAxisRotationSin = sin(xAxisRotation);

    // Calculate the center of the ellipse
    final centerX = (lastPosition.dx + position.dx) / 2;
    final centerY = (lastPosition.dy + position.dy) / 2;

    // Calculate the start angle and end angle
    final startAngle = atan2(
        (lastPosition.dy - centerY) * xAxisRotationCos -
            (lastPosition.dx - centerX) * xAxisRotationSin,
        (lastPosition.dy - centerY) * xAxisRotationSin +
            (lastPosition.dx - centerX) * xAxisRotationCos);
    var endAngle = atan2(
        (position.dy - centerY) * xAxisRotationCos -
            (position.dx - centerX) * xAxisRotationSin,
        (position.dy - centerY) * xAxisRotationSin +
            (position.dx - centerX) * xAxisRotationCos);

    // Ensure the start angle is less than the end angle
    final angle = endAngle - startAngle;
    if (angle < 0) {
      endAngle += 2 * pi;
    }

    // Calculate the number of segments
    final segments = max((angle.abs() / (pi / 2).ceil()), 1);

    // Calculate the angle per segment
    final anglePerSegment = angle / segments;

    // Calculate the tangent angles
    final tangentAngle1 = startAngle + anglePerSegment * 0.25;
    final tangentAngle2 = startAngle + anglePerSegment * 0.75;

    // Calculate the tangent points
    final tangentX1 = centerX +
        (rx * cos(tangentAngle1) * xAxisRotationCos -
            ry * sin(tangentAngle1) * xAxisRotationSin);
    final tangentY1 = centerY +
        (rx * cos(tangentAngle1) * xAxisRotationSin +
            ry * sin(tangentAngle1) * xAxisRotationCos);
    final tangentX2 = centerX +
        (rx * cos(tangentAngle2) * xAxisRotationCos -
            ry * sin(tangentAngle2) * xAxisRotationSin);
    final tangentY2 = centerY +
        (rx * cos(tangentAngle2) * xAxisRotationSin +
            ry * sin(tangentAngle2) * xAxisRotationCos);

    // Calculate the control points
    final controlX1 = tangentX1 +
        (rx * cos(tangentAngle1 - anglePerSegment / 2) * xAxisRotationCos -
            ry * sin(tangentAngle1 - anglePerSegment / 2) * xAxisRotationSin);
    final controlY1 = tangentY1 +
        (rx * cos(tangentAngle1 - anglePerSegment / 2) * xAxisRotationSin +
            ry * sin(tangentAngle1 - anglePerSegment / 2) * xAxisRotationCos);
    final controlX2 = tangentX2 +
        (rx * cos(tangentAngle2 + anglePerSegment / 2) * xAxisRotationCos -
            ry * sin(tangentAngle2 + anglePerSegment / 2) * xAxisRotationSin);
    final controlY2 = tangentY2 +
        (rx * cos(tangentAngle2 + anglePerSegment / 2) * xAxisRotationSin +
            ry * sin(tangentAngle2 + anglePerSegment / 2) * xAxisRotationCos);

    // Calculate the points
    final points = <Offset>[];
    for (var i = 0; i <= segments; i++) {
      final angle = startAngle + i * anglePerSegment;
      final x = centerX +
          (rx * cos(angle) * xAxisRotationCos -
              ry * sin(angle) * xAxisRotationSin);
      final y = centerY +
          (rx * cos(angle) * xAxisRotationSin +
              ry * sin(angle) * xAxisRotationCos);
      points.add(Offset(x, y));
    }

    // Calculate the first control point
    final firstControlX = points[0].dx +
        (rx * cos(startAngle + anglePerSegment / 2) * xAxisRotationCos -
            ry * sin(startAngle + anglePerSegment / 2) * xAxisRotationSin);
    final firstControlY = points[0].dy +
        (rx * cos(startAngle + anglePerSegment / 2) * xAxisRotationSin +
            ry * sin(startAngle + anglePerSegment / 2) * xAxisRotationCos);

    // Calculate the last control point
    final lastControlX = points[points.length - 1].dx +
        (rx * cos(endAngle - anglePerSegment / 2) * xAxisRotationCos -
            ry * sin(endAngle - anglePerSegment / 2) * xAxisRotationSin);
    final lastControlY = points[points.length - 1].dy +
        (rx * cos(endAngle - anglePerSegment / 2) * xAxisRotationSin +
            ry * sin(endAngle - anglePerSegment / 2) * xAxisRotationCos);

    // Add the first point
    points.insert(0, Offset(firstControlX, firstControlY));

    // Add the last point
    points.add(Offset(lastControlX, lastControlY));

    // Add the first control point
    points.insert(1, Offset(controlX1, controlY1));

    // Add the last control point
    points.add(Offset(controlX2, controlY2));

    // Return the points
    return points;
  }

  double _processExpression(String expression) {
    expression = expression.trim();
    if (expression.isEmpty) {
      return 0;
    }
    // Split the expression on +, -, *, /, ^, (, )
    var parts = expression.split(RegExp(r'[\+\-\*\/\^\(\)]'));
    // Remove empty parts
    parts = parts.where((part) => part.isNotEmpty).toList();
    if (parts.length == 1) {
      // Only one part, return the value
      return double.tryParse(parts[0]) ?? 0;
    }
    if (parts.length != 2) {
      throw Exception('Invalid expression');
    }
    // Get the numbers
    final num1 = num.parse(parts[0]).toDouble();
    final num2 = num.parse(parts[1]).toDouble();
    final operation =
        expression.substring(parts[0].length, parts[0].length + 1);
    // Process the expression
    switch (operation) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case '*':
        return num1 * num2;
      case '/':
        return num1 / num2;
      case '^':
        return pow(num1, num2).toDouble();
      default:
        throw Exception('Invalid expression');
    }
  }

  int stringToColor(String text) {
    text = text.toLowerCase();
    text = text.trim();
    if (kColorNames.containsKey(text)) {
      return kColorNames[text]!;
    }
    if (text.startsWith('#')) {
      text = text.substring(1);
    }
    if (text.startsWith('rgba')) {
      return parseRgba(text);
    }
    if (text.startsWith('rgb')) {
      return parseRgb(text);
    }
    if (text.length == 6) {
      text = 'ff$text';
    }
    if (text.length == 3) {
      var r = text[0];
      var g = text[1];
      var b = text[2];
      text = 'ff$r$r$g$g$b$b';
    }
    if (text.length != 8) {
      throw ArgumentError(
          'Color hex must be either 3, 6, or 8 characters long');
    }
    return int.parse(text, radix: 16);
  }

  int parseRgba(String text) {
    var parts = text.split(',');
    if (parts.length != 4) {
      throw ArgumentError('Invalid rgba color');
    }
    var r = double.parse(parts[1]);
    var g = double.parse(parts[2]);
    var b = double.parse(parts[3]);
    var a = double.parse(parts[4]);
    return Color.fromARGB(a.round(), r.round(), g.round(), b.round()).value;
  }

  int parseRgb(String text) {
    var parts = text.split(',');
    if (parts.length != 3) {
      throw ArgumentError('Invalid rgb color');
    }
    var r = double.parse(parts[1]);
    var g = double.parse(parts[2]);
    var b = double.parse(parts[3]);
    return Color.fromARGB(255, r.round(), g.round(), b.round()).value;
  }

// HTML color names
  static const kColorNames = <String, int>{
    'none': 0x00000000,
    'aliceblue': 0xFFF0F8FF,
    'antiquewhite': 0xFFFAEBD7,
    'aqua': 0xFF00FFFF,
    'aquamarine': 0xFF7FFFD4,
    'azure': 0xFFF0FFFF,
    'beige': 0xFFF5F5DC,
    'bisque': 0xFFFFE4C4,
    'black': 0xFF000000,
    'blanchedalmond': 0xFFFFEBCD,
    'blue': 0xFF0000FF,
    'blueviolet': 0xFF8A2BE2,
    'brown': 0xFFA52A2A,
    'burlywood': 0xFFDEB887,
    'cadetblue': 0xFF5F9EA0,
    'chartreuse': 0xFF7FFF00,
    'chocolate': 0xFFD2691E,
    'coral': 0xFFFF7F50,
    'cornflowerblue': 0xFF6495ED,
    'cornsilk': 0xFFFFF8DC,
    'crimson': 0xFFDC143C,
    'cyan': 0xFF00FFFF,
    'darkblue': 0xFF00008B,
    'darkcyan': 0xFF008B8B,
    'darkgoldenrod': 0xFFB8860B,
    'darkgray': 0xFFA9A9A9,
    'darkgreen': 0xFF006400,
    'darkgrey': 0xFFA9A9A9,
    'darkkhaki': 0xFFBDB76B,
    'darkmagenta': 0xFF8B008B,
    'darkolivegreen': 0xFF556B2F,
    'darkorange': 0xFFFF8C00,
    'darkorchid': 0xFF9932CC,
    'darkred': 0xFF8B0000,
    'darksalmon': 0xFFE9967A,
    'darkseagreen': 0xFF8FBC8F,
    'darkslateblue': 0xFF483D8B,
    'darkslategray': 0xFF2F4F4F,
    'darkslategrey': 0xFF2F4F4F,
    'darkturquoise': 0xFF00CED1,
    'darkviolet': 0xFF9400D3,
    'deeppink': 0xFFFF1493,
    'deepskyblue': 0xFF00BFFF,
    'dimgray': 0xFF696969,
    'dimgrey': 0xFF696969,
    'dodgerblue': 0xFF1E90FF,
    'firebrick': 0xFFB22222,
    'floralwhite': 0xFFFFFAF0,
    'forestgreen': 0xFF228B22,
    'fuchsia': 0xFFFF00FF,
    'gainsboro': 0xFFDCDCDC,
    'ghostwhite': 0xFFF8F8FF,
    'gold': 0xFFFFD700,
    'goldenrod': 0xFFDAA520,
    'gray': 0xFF808080,
    'green': 0xFF008000,
    'greenyellow': 0xFFADFF2F,
    'grey': 0xFF808080,
    'honeydew': 0xFFF0FFF0,
    'hotpink': 0xFFFF69B4,
    'indianred': 0xFFCD5C5C,
    'indigo': 0xFF4B0082,
    'ivory': 0xFFFFFFF0,
    'khaki': 0xFFF0E68C,
    'lavender': 0xFFE6E6FA,
    'lavenderblush': 0xFFFFF0F5,
    'lawngreen': 0xFF7CFC00,
    'lemonchiffon': 0xFFFFFACD,
    'lightblue': 0xFFADD8E6,
    'lightcoral': 0xFFF08080,
    'lightcyan': 0xFFE0FFFF,
    'lightgoldenrodyellow': 0xFFFAFAD2,
    'lightgray': 0xFFD3D3D3,
    'lightgreen': 0xFF90EE90,
    'lightgrey': 0xFFD3D3D3,
    'lightpink': 0xFFFFB6C1,
    'lightsalmon': 0xFFFFA07A,
    'lightseagreen': 0xFF20B2AA,
    'lightskyblue': 0xFF87CEFA,
    'lightslategray': 0xFF778899,
    'lightslategrey': 0xFF778899,
    'lightsteelblue': 0xFFB0C4DE,
    'lightyellow': 0xFFFFFFE0,
    'lime': 0xFF00FF00,
    'limegreen': 0xFF32CD32,
    'linen': 0xFFFAF0E6,
    'magenta': 0xFFFF00FF,
    'maroon': 0xFF800000,
    'mediumaquamarine': 0xFF66CDAA,
    'mediumblue': 0xFF0000CD,
    'mediumorchid': 0xFFBA55D3,
    'mediumpurple': 0xFF9370DB,
    'mediumseagreen': 0xFF3CB371,
    'mediumslateblue': 0xFF7B68EE,
    'mediumspringgreen': 0xFF00FA9A,
    'mediumturquoise': 0xFF48D1CC,
    'mediumvioletred': 0xFFC71585,
    'midnightblue': 0xFF191970,
    'mintcream': 0xFFF5FFFA,
    'mistyrose': 0xFFFFE4E1,
    'moccasin': 0xFFFFE4B5,
    'navajowhite': 0xFFFFDEAD,
    'navy': 0xFF000080,
    'oldlace': 0xFFFDF5E6,
    'olive': 0xFF808000,
    'olivedrab': 0xFF6B8E23,
    'orange': 0xFFFFA500,
    'orangered': 0xFFFF4500,
    'orchid': 0xFFDA70D6,
    'palegoldenrod': 0xFFEEE8AA,
    'palegreen': 0xFF98FB98,
    'paleturquoise': 0xFFAFEEEE,
    'palevioletred': 0xFFDB7093,
    'papayawhip': 0xFFFFEFD5,
    'peachpuff': 0xFFFFDAB9,
    'peru': 0xFFCD853F,
    'pink': 0xFFFFC0CB,
    'plum': 0xFFDDA0DD,
    'powderblue': 0xFFB0E0E6,
    'purple': 0xFF800080,
    'red': 0xFFFF0000,
    'rosybrown': 0xFFBC8F8F,
    'royalblue': 0xFF4169E1,
    'saddlebrown': 0xFF8B4513,
    'salmon': 0xFFFA8072,
    'sandybrown': 0xFFF4A460,
    'seagreen': 0xFF2E8B57,
    'seashell': 0xFFFFF5EE,
    'sienna': 0xFFA0522D,
    'silver': 0xFFC0C0C0,
    'skyblue': 0xFF87CEEB,
    'slateblue': 0xFF6A5ACD,
    'slategray': 0xFF708090,
    'slategrey': 0xFF708090,
    'snow': 0xFFFFFAFA,
    'springgreen': 0xFF00FF7F,
    'steelblue': 0xFF4682B4,
    'tan': 0xFFD2B48C,
    'teal': 0xFF008080,
    'thistle': 0xFFD8BFD8,
    'transparent': 0x00000000,
    'tomato': 0xFFFF6347,
    'turquoise': 0xFF40E0D0,
    'violet': 0xFFEE82EE,
    'wheat': 0xFFF5DEB3,
    'white': 0xFFFFFFFF,
    'whitesmoke': 0xFFF5F5F5,
    'yellow': 0xFFFFFF00,
    'yellowgreen': 0xFF9ACD32,
  };
}
