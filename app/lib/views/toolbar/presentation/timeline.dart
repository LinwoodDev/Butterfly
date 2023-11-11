import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PresentationTimelineView extends StatefulWidget {
  final List<int> animationKeys;
  final int currentFrame;
  final int duration;
  final ValueChanged<int>? onFrameChanged;

  const PresentationTimelineView({
    super.key,
    required this.animationKeys,
    required this.currentFrame,
    required this.duration,
    this.onFrameChanged,
  });

  @override
  State<PresentationTimelineView> createState() =>
      _PresentationTimelineViewState();
}

class _PresentationTimelineViewState extends State<PresentationTimelineView> {
  double _zoom = 1;
  double _position = 0;

  @override
  void didUpdateWidget(covariant PresentationTimelineView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentFrame != oldWidget.currentFrame ||
        widget.duration != oldWidget.duration) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.onBackground.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(2),
      child: Listener(
        onPointerSignal: (event) {
          if (event is! PointerScrollEvent) {
            return;
          }
          final delta = event.scrollDelta.dx + event.scrollDelta.dy;
          if (delta == 0) {
            return;
          }
          setState(() => _zoom *= 1 - delta / 100 / 10);
        },
        child: GestureDetector(
          child: ClipRect(
            child: CustomPaint(
              painter: PresentationTimelinePainter(
                animationKeys: widget.animationKeys,
                currentFrame: widget.currentFrame,
                duration: widget.duration,
                zoom: _zoom,
                position: _position,
                cursorColor: colorScheme.primary,
                keyColor: colorScheme.secondary,
                backgroundColor: colorScheme.surface,
              ),
            ),
          ),
          onHorizontalDragUpdate: (details) {
            setState(() => _position += details.delta.dx);
          },
          onScaleUpdate: (details) {
            setState(() => _zoom *= details.scale);
          },
          onTapUp: (details) {
            final x = details.localPosition.dx - _position;
            final frame = (x / _zoom).round();
            widget.onFrameChanged?.call(frame);
          },
        ),
      ),
    );
  }
}

class PresentationTimelinePainter extends CustomPainter {
  final List<int> animationKeys;
  final int currentFrame;
  final int duration;
  final double zoom;
  final double position;
  final Color cursorColor, keyColor, backgroundColor;

  PresentationTimelinePainter({
    required this.animationKeys,
    required this.currentFrame,
    required this.duration,
    required this.zoom,
    required this.position,
    required this.cursorColor,
    required this.keyColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // set zoom relative to duration
    canvas.scale(zoom, 1);
    canvas.translate(position / zoom, 0);
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 1 / zoom
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Offset.zero & Size(duration.toDouble(), size.height), backgroundPaint);
    final cursorPaint = Paint()
      ..color = cursorColor
      ..strokeWidth = 1 / zoom
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(currentFrame.toDouble(), 0),
        Offset(currentFrame.toDouble(), size.height), cursorPaint);
    final keyPaint = Paint()
      ..color = keyColor
      ..strokeWidth = 1 / zoom
      ..style = PaintingStyle.fill;
    for (final key in animationKeys) {
      canvas.drawLine(Offset(key.toDouble(), 0),
          Offset(key.toDouble(), size.height * 0.5), keyPaint);
    }
  }

  @override
  bool shouldRepaint(covariant PresentationTimelinePainter oldDelegate) {
    return oldDelegate.animationKeys != animationKeys ||
        oldDelegate.currentFrame != currentFrame ||
        oldDelegate.duration != duration ||
        oldDelegate.zoom != zoom ||
        oldDelegate.position != position ||
        oldDelegate.cursorColor != cursorColor ||
        oldDelegate.keyColor != keyColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
