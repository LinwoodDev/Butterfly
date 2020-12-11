import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Split Bar'),
      ),
      body: SplitBar(
        onWeightChanged: (weight) => print('weight: $weight'),
        left: Container(
          color: Colors.red,
          child: Placeholder(),
        ),
        right: PageView(
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: Placeholder(),
            ),
            Container(
              color: Colors.green,
              child: Placeholder(),
            ),
            Container(
              color: Colors.yellow,
              child: Placeholder(),
            ),
          ],
        ),
      ),
    );
  }
}

class SplitBar extends StatefulWidget {
  const SplitBar({
    Key key,
    this.left,
    this.right,
    this.touchOverlap = 16.0,
    this.initialWeight = 0.333,
    this.onWeightChanged,
  }) : super(key: key);

  final Widget left;
  final Widget right;
  final double touchOverlap;
  final double initialWeight;
  final ValueChanged<double> onWeightChanged;

  @override
  _SplitBarState createState() => _SplitBarState();
}

class _SplitBarState extends State<SplitBar> {
  double _weight;

  @override
  void initState() {
    super.initState();
    _weight = widget.initialWeight;
  }

  void _handleDragUpdate(DragUpdateDetails d) {
    final RenderBox container = context.findRenderObject();
    final pos = container.globalToLocal(d.globalPosition);
    setState(() => _weight = pos.dx / container.size.width);
    widget.onWeightChanged?.call(_weight);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double left = constraints.maxWidth * _weight;
        final double right = constraints.maxWidth * (1.0 - _weight);
        return Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              left: 0.0,
              right: right,
              bottom: 0.0,
              child: Offstage(
                offstage: left.round() == 0,
                child: widget.left,
              ),
            ),
            Positioned(
              top: 0.0,
              left: left,
              right: 0.0,
              bottom: 0.0,
              child: Offstage(
                offstage: right.round() == 0,
                child: widget.right,
              ),
            ),
            Positioned(
              left: left - widget.touchOverlap,
              right: right - widget.touchOverlap,
              top: 0.0,
              bottom: 0.0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: _handleDragUpdate,
              ),
            ),
          ],
        );
      },
    );
  }
}
