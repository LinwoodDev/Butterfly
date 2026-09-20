import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';

class PresentationTimelineView extends StatefulWidget {
  final List<int> animationKeys;
  final List<int> slideFrames;
  final int currentFrame;
  final int duration;
  final ValueChanged<int>? onFrameChanged;

  const PresentationTimelineView({
    super.key,
    required this.animationKeys,
    this.slideFrames = const [],
    required this.currentFrame,
    required this.duration,
    this.onFrameChanged,
  });

  @override
  State<PresentationTimelineView> createState() =>
      _PresentationTimelineViewState();
}

class _PresentationTimelineViewState extends State<PresentationTimelineView> {
  static const _minimumZoom = 0.05;
  static const _maximumZoom = 1000.0;

  double? _zoom;
  double _baseZoom = 1;
  double _basePosition = 0;
  double _scaleFocalPoint = 0;
  double _position = 0;

  double _clampZoom(double value) => value.clamp(_minimumZoom, _maximumZoom);

  double _clampPosition(double value, double width, double zoom) {
    final contentWidth = widget.duration * zoom;
    if (contentWidth <= width) return 0;
    return value.clamp(width - contentWidth, 0);
  }

  @override
  void didUpdateWidget(covariant PresentationTimelineView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _zoom = null;
      _position = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.2)),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      padding: const EdgeInsets.all(2),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final fitZoom = widget.duration > 0
              ? constraints.maxWidth / widget.duration
              : 1.0;
          final computedZoom = _clampZoom(_zoom ?? fitZoom);
          final computedPosition = _clampPosition(
            _position,
            constraints.maxWidth,
            computedZoom,
          );
          return Semantics(
            key: const ValueKey('presentationTimelineSemantics'),
            slider: true,
            value: widget.currentFrame.toString(),
            increasedValue: (widget.currentFrame + 1)
                .clamp(0, widget.duration)
                .toString(),
            decreasedValue: (widget.currentFrame - 1)
                .clamp(0, widget.duration)
                .toString(),
            onIncrease: () => widget.onFrameChanged?.call(
              (widget.currentFrame + 1).clamp(0, widget.duration),
            ),
            onDecrease: () => widget.onFrameChanged?.call(
              (widget.currentFrame - 1).clamp(0, widget.duration),
            ),
            child: Listener(
              onPointerSignal: (event) {
                if (event is! PointerScrollEvent) {
                  return;
                }
                final delta = event.scrollDelta.dx + event.scrollDelta.dy;
                if (delta == 0) {
                  return;
                }
                final zoom = _clampZoom(computedZoom * (1 - delta / 1000));
                final frameAtPointer =
                    (event.localPosition.dx - computedPosition) / computedZoom;
                setState(() {
                  _zoom = zoom;
                  _position = _clampPosition(
                    event.localPosition.dx - frameAtPointer * zoom,
                    constraints.maxWidth,
                    zoom,
                  );
                });
              },
              child: GestureDetector(
                behavior: .opaque,
                child: ClipRect(
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: PresentationTimelinePainter(
                      animationKeys: widget.animationKeys,
                      slideFrames: widget.slideFrames,
                      currentFrame: widget.currentFrame,
                      duration: widget.duration,
                      zoom: computedZoom,
                      position: computedPosition,
                      cursorColor: colorScheme.primary,
                      keyColor: colorScheme.secondary,
                      slideColor: colorScheme.tertiary,
                      backgroundColor: colorScheme.surface,
                    ),
                  ),
                ),
                onHorizontalDragUpdate: (details) {
                  setState(
                    () => _position = _clampPosition(
                      computedPosition + details.delta.dx,
                      constraints.maxWidth,
                      computedZoom,
                    ),
                  );
                },
                onScaleStart: (details) {
                  _baseZoom = computedZoom;
                  _basePosition = computedPosition;
                  _scaleFocalPoint = details.localFocalPoint.dx;
                },
                onScaleUpdate: (details) {
                  final zoom = _clampZoom(_baseZoom * details.scale);
                  final frameAtFocal =
                      (_scaleFocalPoint - _basePosition) / _baseZoom;
                  setState(() {
                    _zoom = zoom;
                    _position = _clampPosition(
                      details.localFocalPoint.dx - frameAtFocal * zoom,
                      constraints.maxWidth,
                      zoom,
                    );
                  });
                },
                onDoubleTap: () => setState(() {
                  _zoom = null;
                  _position = 0;
                }),
                onTapUp: (details) {
                  final x = details.localPosition.dx - computedPosition;
                  final frame = (x / computedZoom).round();
                  widget.onFrameChanged?.call(frame.clamp(0, widget.duration));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class PresentationTimelinePainter extends CustomPainter {
  final List<int> animationKeys;
  final List<int> slideFrames;
  final int currentFrame;
  final int duration;
  final double zoom;
  final double position;
  final Color cursorColor, keyColor, slideColor, backgroundColor;

  PresentationTimelinePainter({
    required this.animationKeys,
    this.slideFrames = const [],
    required this.currentFrame,
    required this.duration,
    required this.zoom,
    required this.position,
    required this.cursorColor,
    required this.keyColor,
    required this.slideColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    final slideSet = slideFrames.toSet();
    final keyPaint = Paint()
      ..color = keyColor.withValues(alpha: 0.75)
      ..strokeWidth = 1;
    final sortedKeys =
        animationKeys.where((key) => !slideSet.contains(key)).toList()..sort();
    var lastKeyX = double.negativeInfinity;
    for (final key in sortedKeys) {
      final x = key * zoom + position;
      if (x < 0 || x > size.width || x - lastKeyX < 2) continue;
      canvas.drawLine(
        Offset(x, size.height * 0.58),
        Offset(x, size.height),
        keyPaint,
      );
      lastKeyX = x;
    }

    final slidePaint = Paint()
      ..color = slideColor
      ..strokeWidth = 2;
    final sortedSlides = slideFrames.toList()..sort();
    var lastSlideX = double.negativeInfinity;
    for (final frame in sortedSlides) {
      final x = frame * zoom + position;
      if (x < 0 || x > size.width || x - lastSlideX < 4) continue;
      canvas.drawLine(
        Offset(x, size.height * 0.18),
        Offset(x, size.height),
        slidePaint,
      );
      lastSlideX = x;
    }

    final cursorPaint = Paint()
      ..color = cursorColor
      ..strokeWidth = 2;
    final cursorX = currentFrame * zoom + position;
    canvas.drawLine(
      Offset(cursorX, 0),
      Offset(cursorX, size.height),
      cursorPaint,
    );
  }

  @override
  bool shouldRepaint(covariant PresentationTimelinePainter oldDelegate) {
    return oldDelegate.animationKeys != animationKeys ||
        oldDelegate.slideFrames != slideFrames ||
        oldDelegate.currentFrame != currentFrame ||
        oldDelegate.duration != duration ||
        oldDelegate.zoom != zoom ||
        oldDelegate.position != position ||
        oldDelegate.cursorColor != cursorColor ||
        oldDelegate.keyColor != keyColor ||
        oldDelegate.slideColor != slideColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
