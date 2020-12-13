import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef SplitWindowBuilder = Widget Function(
    BuildContext context, SplitView view, SplitWindow window, bool expanded);

class SplitWindow {
  final SplitWindowBuilder builder;
  final double maxSize;
  final double minSize;
  final double size;

  void expand(BuildContext context, SplitView view, SplitWindow window) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => builder(context, view, window, true)));
  }

  SplitWindow({@required this.builder, this.minSize, this.maxSize, this.size});
}

class SplitView extends StatefulWidget {
  final SplitWindow first;
  final SplitWindow second;
  final double ratio;
  final Icon icon;
  final Axis axis;

  const SplitView(
      {Key key,
      @required this.first,
      @required this.second,
      this.ratio = 0.5,
      this.axis = Axis.horizontal,
      this.icon = const Icon(Icons.drag_handle)})
      : assert(first != null),
        assert(second != null),
        assert(ratio >= 0),
        assert(ratio <= 1),
        super(key: key);

  @override
  _SplitViewState createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  final _dividerWidth = 16.0;

  //from 0-1
  double _ratio;
  double _maxSize;

  get _firstSize => _ratio * _maxSize;
  get _secondSize => (1 - _ratio) * _maxSize;

  @override
  void initState() {
    super.initState();
    _ratio = widget.ratio;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      assert(_ratio <= 1);
      assert(_ratio >= 0);
      var constraintsSize =
          widget.axis == Axis.horizontal ? constraints.maxWidth : constraints.maxHeight;
      if (_maxSize == null ||
          widget.first.minSize != null && widget.first.minSize > _firstSize ||
          widget.second.minSize != null && widget.second.minSize > _secondSize ||
          widget.first.maxSize != null && widget.first.maxSize < _firstSize ||
          widget.second.maxSize != null && widget.second.maxSize < _secondSize) {
        _maxSize = constraintsSize - _dividerWidth;
        if (widget.first.size != null) _ratio = widget.first.size / _maxSize;
        if (widget.second.size != null) _ratio = (_maxSize - widget.second.size) / _maxSize;
      }
      if (_maxSize != constraintsSize) {
        _maxSize = constraintsSize - _dividerWidth;
      }
      var list = widget.axis == Axis.horizontal
          ? Row(
              children: _buildBody(constraints),
            )
          : Column(children: _buildBody(constraints));
      return SizedBox(
          width: widget.axis == Axis.horizontal ? constraints.maxWidth : null,
          height: widget.axis == Axis.horizontal ? null : constraints.maxHeight,
          child: list);
    });
  }

  _buildBody(BoxConstraints constraints) {
    return [
      Builder(
          builder: (context) => SizedBox(
              width: widget.axis == Axis.horizontal ? _firstSize : null,
              height: widget.axis == Axis.horizontal ? null : _firstSize,
              child: SizedBox.expand(
                  child: widget.first.builder(context, widget, widget.first, false)))),
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
            width: widget.axis == Axis.horizontal ? _dividerWidth : constraints.maxWidth,
            height: widget.axis == Axis.horizontal ? constraints.maxHeight : _dividerWidth,
            child: RotationTransition(
                child: widget.icon,
                turns: AlwaysStoppedAnimation(widget.axis == Axis.horizontal ? 0.25 : 0))),
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            var last = _ratio;
            _ratio +=
                (widget.axis == Axis.horizontal ? details.delta.dx : details.delta.dy) / _maxSize;
            if (widget.first.minSize != null && widget.first.minSize > _firstSize ||
                widget.second.minSize != null && widget.second.minSize > _secondSize ||
                widget.first.maxSize != null && widget.first.maxSize < _firstSize ||
                widget.second.maxSize != null && widget.second.maxSize < _secondSize) _ratio = last;
            if (_ratio > 1)
              _ratio = 1;
            else if (_ratio < 0.0) _ratio = 0.0;
          });
        },
      ),
      Builder(
          builder: (context) => SizedBox(
              width: widget.axis == Axis.horizontal ? _secondSize : null,
              height: widget.axis == Axis.horizontal ? null : _secondSize,
              child: SizedBox.expand(
                  child: widget.second.builder(context, widget, widget.second, false))))
    ];
  }
}
