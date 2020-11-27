import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

const sketchBox = 'sketchpadBox';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ColoredPathAdapter());
  await Hive.openBox<ColoredPath>(sketchBox);
  runApp(DrawApp());
}

class DrawApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: DrawingScreen()),
    );
  }
}

class ColoredPath {
  static const colors = [Colors.black, Colors.red, Colors.green, Colors.blue, Colors.amber];

  static List<Paint> _paints;

  Paint get paint {
    if (_paints == null) {
      _paints = [];
      for (var color in colors) {
        _paints.add(Paint()
          ..strokeCap = StrokeCap.round
          ..isAntiAlias = true
          ..color = color
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke);
      }
    }
    return _paints[colorIndex];
  }

  final int colorIndex;

  final path = Path();

  List<Offset> points = [];

  ColoredPath(this.colorIndex);

  void addPoint(Offset point) {
    if (points.isEmpty) {
      path.moveTo(point.dx, point.dy);
    } else {
      path.lineTo(point.dx, point.dy);
    }
    points.add(point);
  }
}

class ColoredPathAdapter extends TypeAdapter<ColoredPath> {
  @override
  final typeId = 0;

  @override
  ColoredPath read(BinaryReader reader) {
    var path = ColoredPath(reader.readByte());
    var len = reader.readUint32();
    for (var i = 0; i < len; i++) {
      path.addPoint(Offset(reader.readDouble(), reader.readDouble()));
    }
    return path;
  }

  @override
  void write(BinaryWriter writer, ColoredPath obj) {
    writer.writeByte(obj.colorIndex);
    writer.writeUint32(obj.points.length);
    for (var point in obj.points) {
      writer.writeDouble(point.dx);
      writer.writeDouble(point.dy);
    }
  }
}

class DrawingScreen extends StatefulWidget {
  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  var selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: Hive.box<ColoredPath>(sketchBox).listenable(),
                builder: drawPathsFromBox,
              ),
              DrawingArea(selectedColorIndex),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < ColoredPath.colors.length; i++) buildColorCircle(i),
            ClearButton(),
            UndoButton(),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget drawPathsFromBox(BuildContext context, Box<ColoredPath> box, Widget child) {
    return Stack(
      children: <Widget>[
        for (var path in box.values)
          CustomPaint(
            size: Size.infinite,
            painter: PathPainter(path),
          ),
      ],
    );
  }

  Widget buildColorCircle(int colorIndex) {
    var selected = selectedColorIndex == colorIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColorIndex = colorIndex;
        });
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: selected ? 50 : 36,
          width: selected ? 50 : 36,
          color: ColoredPath.colors[colorIndex],
        ),
      ),
    );
  }
}

class DrawingArea extends StatefulWidget {
  final int selectedColorIndex;

  DrawingArea(this.selectedColorIndex);

  @override
  _DrawingAreaState createState() => _DrawingAreaState();
}

class _DrawingAreaState extends State<DrawingArea> {
  var path = ColoredPath(0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        addPoint(details.globalPosition);
      },
      onPanStart: (details) {
        path = ColoredPath(widget.selectedColorIndex);
        addPoint(details.globalPosition);
      },
      onPanEnd: (details) {
        Hive.box<ColoredPath>(sketchBox).add(path);
        setState(() {
          path = ColoredPath(0);
        });
      },
      child: CustomPaint(
        size: Size.infinite,
        painter: PathPainter(path),
      ),
    );
  }

  void addPoint(Offset point) {
    var renderBox = context.findRenderObject() as RenderBox;
    setState(() {
      path.addPoint(renderBox.globalToLocal(point));
    });
  }
}

class PathPainter extends CustomPainter {
  final ColoredPath path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(path.path, path.paint);
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;
}

class ClearButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<ColoredPath>(sketchBox).listenable(),
      builder: (context, box, _) {
        return IconButton(
          icon: Icon(Icons.delete),
          onPressed: box.length == 0 ? null : () => box.clear(),
        );
      },
    );
  }
}

class UndoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<ColoredPath>(sketchBox).listenable(),
      builder: (context, box, _) {
        return IconButton(
          icon: Icon(Icons.undo),
          onPressed: box.length == 0 ? null : () => box.deleteAt(box.length - 1),
        );
      },
    );
  }
}
