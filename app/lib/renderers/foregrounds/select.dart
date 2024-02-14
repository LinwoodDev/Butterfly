import 'dart:math';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';

const cornerSize = 32.0;
const visibleSize = cornerSize / 2;

class LassoSelectionForegroundRenderer extends Renderer<List<Offset>> {
  final ColorScheme scheme;
  LassoSelectionForegroundRenderer(super.element, this.scheme);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    final paint = Paint()
      ..color = scheme.primaryContainer
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    final fillPaint = Paint()
      ..color = scheme.primaryContainer.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    final path = Path();
    path.addPolygon(element, true);
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, paint);
  }
}

typedef TransformResult = ({
  Offset position,
  double rotation,
  double scaleX,
  double scaleY
});

class RectSelectionForegroundManager {
  final bool enableRotation;
  Rect _selection = Rect.zero;
  SelectionScaleMode _transformMode = SelectionScaleMode.scale;
  SelectionTransformCorner? _transformCorner;
  Offset? _startPosition;

  RectSelectionForegroundManager({this.enableRotation = true});

  void resetTransform() {
    _transformMode = SelectionScaleMode.scale;
    _transformCorner = null;
  }

  void select(Rect selection) {
    _selection = selection;
    resetTransform();
  }

  void deselect() => select(Rect.zero);

  SelectionTransformCorner? getCornerHit(Offset position, double scale) {
    if (_selection.isEmpty) return null;
    final hits = SelectionTransformCorner.values.where((element) {
      final corner = element.getFromRect(_selection);
      if (element == SelectionTransformCorner.center && !enableRotation) {
        return false;
      }
      return Rect.fromCenter(
              center: corner,
              width: cornerSize / scale,
              height: cornerSize / scale)
          .contains(position);
    }).toList();
    if (hits.length == SelectionTransformCorner.values.length) return null;
    return hits.firstOrNull;
  }

  void toggleTransformMode() =>
      _transformMode = (SelectionScaleMode.scale == _transformMode
          ? SelectionScaleMode.scaleProp
          : SelectionScaleMode.scale);

  void startTransform(Offset position, double scale) {
    _startPosition = position;
    final hit = getCornerHit(position, scale);
    _transformCorner = hit;
  }

  bool get isTransforming => _startPosition != null;
  bool get isMoving => isTransforming && _transformCorner == null;
  bool get isScaling => isTransforming && _transformCorner != null;

  TransformResult? getTransform(Offset position) {
    final previous = _startPosition ?? position;
    if (previous == position) {
      return null;
    }
    final delta = position - previous;
    var scaleX = 1.0;
    var scaleY = 1.0;
    var moved = Offset.zero;
    var rotation = 0.0;
    switch (_transformCorner) {
      case SelectionTransformCorner.topLeft:
        moved = delta;
        scaleX += -delta.dx / _selection.size.width;
        scaleY += -delta.dy / _selection.size.height;
      case SelectionTransformCorner.topCenter:
        scaleY += -delta.dy / _selection.size.height;
        moved = Offset(0, delta.dy);
      case SelectionTransformCorner.topRight:
        moved = Offset(0, delta.dy);
        scaleX += delta.dx / _selection.size.width;
        scaleY += -delta.dy / _selection.size.height;
      case SelectionTransformCorner.centerLeft:
        moved = Offset(delta.dx, 0);
        scaleX += -delta.dx / _selection.size.width;
        break;
      case SelectionTransformCorner.centerRight:
        scaleX += delta.dx / _selection.size.width;
      case SelectionTransformCorner.bottomLeft:
        moved = Offset(delta.dx, 0);
        scaleX += -delta.dx / _selection.size.width;
        scaleY += delta.dy / _selection.size.height;
      case SelectionTransformCorner.bottomCenter:
        scaleY += delta.dy / _selection.size.height;
      case SelectionTransformCorner.bottomRight:
        scaleX += delta.dx / _selection.size.width;
        scaleY += delta.dy / _selection.size.height;
      case SelectionTransformCorner.center when enableRotation:
        rotation = position.getRotation(_selection.center) / pi * 180;
      default:
        moved = delta;
    }
    if (_transformMode == SelectionScaleMode.scaleProp) {
      final scale = max(scaleX, scaleY);
      scaleX = scale;
      scaleY = scale;
    }
    return (
      scaleX: scaleX,
      scaleY: scaleY,
      position: moved,
      rotation: rotation,
    );
  }

  void transform(SelectionScaleMode mode, SelectionTransformCorner corner) {
    _transformMode = mode;
    _transformCorner = corner;
  }

  RectSelectionForegroundRenderer get renderer =>
      RectSelectionForegroundRenderer(
          _selection, _transformMode, _transformCorner, enableRotation);
}

class RectSelectionForegroundRenderer extends Renderer<Rect> {
  final SelectionScaleMode? transformMode;
  final SelectionTransformCorner? transformCorner;
  final bool enableRotation;

  RectSelectionForegroundRenderer(super.element,
      [this.transformMode, this.transformCorner, this.enableRotation = true]);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    if (element.isEmpty) return;
    final paint = Paint()
      ..color = colorScheme?.primaryContainer ?? Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    canvas.drawRect(element, paint);
    if (transformMode == null) return;
    final color = transformMode == SelectionScaleMode.scaleProp
        ? Colors.red
        : Colors.blue;
    final transformPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    final realSize = visibleSize / transform.size;
    if (element.width < 2 * realSize || element.height < 2 * realSize) return;
    final showCenter =
        element.width > 3 * realSize && element.height > 3 * realSize;
    SelectionTransformCorner.values
        .where((element) => !element.isCenter() || showCenter)
        .forEach((corner) {
      final position = corner.getFromRect(element);
      if (corner == SelectionTransformCorner.center) {
        canvas.drawCircle(
          position,
          realSize,
          transformPaint
            ..style = corner == transformCorner
                ? PaintingStyle.fill
                : PaintingStyle.stroke,
        );
      } else {
        canvas.drawRect(
          Rect.fromCenter(
            center: position,
            width: realSize,
            height: realSize,
          ),
          transformPaint
            ..style = corner == transformCorner
                ? PaintingStyle.fill
                : PaintingStyle.stroke,
        );
      }
    });
  }
}

enum SelectionScaleMode { scale, scaleProp }

enum SelectionTransformCorner {
  // For rotating
  center,

  topLeft,
  topCenter,
  topRight,
  centerLeft,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

extension SelectionTransformCornerExtension on SelectionTransformCorner {
  bool isCenter() => switch (this) {
        SelectionTransformCorner.topCenter ||
        SelectionTransformCorner.centerLeft ||
        SelectionTransformCorner.centerRight ||
        SelectionTransformCorner.bottomCenter =>
          true,
        _ => false,
      };

  Offset getFromRect(Rect rect) => switch (this) {
        SelectionTransformCorner.topLeft => rect.topLeft,
        SelectionTransformCorner.topCenter => rect.topCenter,
        SelectionTransformCorner.topRight => rect.topRight,
        SelectionTransformCorner.centerLeft => rect.centerLeft,
        SelectionTransformCorner.centerRight => rect.centerRight,
        SelectionTransformCorner.bottomLeft => rect.bottomLeft,
        SelectionTransformCorner.bottomCenter => rect.bottomCenter,
        SelectionTransformCorner.bottomRight => rect.bottomRight,
        SelectionTransformCorner.center => rect.center,
      };
}
