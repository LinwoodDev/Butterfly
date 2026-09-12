import 'dart:math';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

const cornerSize = 40.0;
const visibleSize = cornerSize / 2.5;
const _targetTransformSpacing = cornerSize * 2;
const _rotationButtonDistance = cornerSize * 1.5;

class LassoSelectionForegroundRenderer extends Renderer<List<Offset>> {
  final ColorScheme scheme;
  LassoSelectionForegroundRenderer(super.element, this.scheme);

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    final paint = Paint()
      ..color = scheme.primaryContainer
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    final fillPaint = Paint()
      ..color = scheme.primaryContainer.withValues(alpha: 0.2)
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
  double scaleY,
});

extension TransformResultGeometry on TransformResult {
  Offset scalePoint(Offset point, Rect selection) {
    final relative = point - selection.topLeft;
    return selection.topLeft +
        position +
        Offset(relative.dx * scaleX, relative.dy * scaleY);
  }

  Rect scaleRect(Rect rect, Rect selection) => .fromPoints(
    scalePoint(rect.topLeft, selection),
    scalePoint(rect.bottomRight, selection),
  );
}

class RectSelectionForegroundManager {
  final bool enableRotation;
  Rect _selection = .zero;
  SelectionScaleMode _scaleMode = .scale;
  bool _proportionalModifier = false;
  bool _centeredModifier = false;
  double _viewportRotation = 0;
  double rotation = 0;

  Offset _toLocal(Offset point) => point.rotate(Offset.zero, -rotation);
  bool contains(Offset point) => selection.contains(_toLocal(point));
  SelectionTransformCorner? _corner;
  Offset? _startPosition, _currentPosition;

  RectSelectionForegroundManager({this.enableRotation = true});

  Rect get selection => _selection;

  SelectionTransformCorner? get corner => _corner;

  bool get isInsideSelection =>
      selection.contains(_currentPosition ?? Offset.zero);

  void updateCurrentPosition(Offset position) {
    _currentPosition = _toLocal(position);
  }

  void updateCursor(double scale, double sensitivity, [double rotation = 0]) {
    _viewportRotation = rotation;
    if (_currentPosition == null) return;
    _corner = _getCornerHit(_currentPosition!, scale, sensitivity);
  }

  Rect getHitRect(double scale, double sensitivity) {
    final targetSize = cornerSize / scale * sensitivity;
    return Rect.fromCenter(
      center: _selection.center,
      width: max(_selection.width, targetSize),
      height: max(_selection.height, targetSize),
    );
  }

  void reset() {
    resetTransform();
    _scaleMode = SelectionScaleMode.scale;
  }

  void resetTransform() {
    _proportionalModifier = false;
    _centeredModifier = false;
    _corner = null;
    _startPosition = null;
    _currentPosition = null;
  }

  void select(Rect? selection, {double rotation = 0}) {
    this.rotation = rotation;
    _selection = selection ?? Rect.zero;
    resetTransform();
  }

  void deselect() => select(null);

  SelectionTransformCorner? getCornerHit(
    Offset position,
    double scale,
    double sensitivity,
  ) => _getCornerHit(_toLocal(position), scale, sensitivity);

  SelectionTransformCorner? _getCornerHit(
    Offset position,
    double scale,
    double sensitivity,
  ) {
    if (!isValid) return null;
    final hits = SelectionTransformCorner.values.where((corner) {
      final cornerPosition = corner.getFromRect(_selection, scale: scale);
      if (corner == .center && !enableRotation) {
        return false;
      }
      return Rect.fromCenter(
        center: cornerPosition,
        width: cornerSize / scale * sensitivity,
        height: cornerSize / scale * sensitivity,
      ).contains(position);
    }).toList();
    if (hits.isEmpty) return null;
    if (hits.length == SelectionTransformCorner.values.length) return null;
    double distance(SelectionTransformCorner corner) {
      final cornerPosition = corner.getFromRect(_selection, scale: scale);
      final delta = cornerPosition - position;
      return delta.dx * delta.dx + delta.dy * delta.dy;
    }

    return hits.reduce(
      (closest, corner) =>
          distance(corner) < distance(closest) ? corner : closest,
    );
  }

  void toggleTransformMode() =>
      _scaleMode = (SelectionScaleMode.scale == _scaleMode
      ? SelectionScaleMode.scaleProp
      : SelectionScaleMode.scale);

  void updateModifiers({required bool proportional, required bool centered}) {
    _proportionalModifier = proportional;
    _centeredModifier = centered;
  }

  SelectionScaleMode get _effectiveScaleMode =>
      (_scaleMode == .scaleProp) != _proportionalModifier
      ? SelectionScaleMode.scaleProp
      : SelectionScaleMode.scale;

  bool shouldTransform(Offset position, double scale, double sensitivity) {
    if (!isValid) return false;
    return getHitRect(scale, sensitivity).contains(_toLocal(position)) ||
        getCornerHit(position, scale, sensitivity) != null;
  }

  bool startTransform(Offset position, double scale, double sensitivity) {
    if (!isValid) return false;
    final hit = getCornerHit(position, scale, sensitivity);
    if (!getHitRect(scale, sensitivity).contains(_toLocal(position)) &&
        hit == null) {
      return false;
    }
    _startPosition = _toLocal(position);
    _currentPosition = _startPosition;
    _corner = hit;
    return true;
  }

  void startTransformWithCorner(
    SelectionTransformCorner? corner, [
    Offset? position,
  ]) {
    _corner = corner;
    _startPosition = position == null
        ? corner.getFromRect(_selection)
        : _toLocal(position);
    _currentPosition = _startPosition;
  }

  bool get isValid => !_selection.isEmpty;
  bool get isTransforming => _startPosition != null;
  bool get isMoving => isTransforming && _corner == null;
  bool get isScaling => isTransforming && _corner != null;
  Offset get pivot => _selection.center;
  MouseCursor? get cursor {
    final angle = switch (corner) {
      .centerLeft || .centerRight => 0.0,
      .topLeft || .bottomRight => pi / 4,
      .topCenter || .bottomCenter => pi / 2,
      .topRight || .bottomLeft => 3 * pi / 4,
      _ => null,
    };
    if (angle != null) {
      return switch (((angle + _viewportRotation + rotation) / (pi / 4))
              .round() %
          4) {
        0 => SystemMouseCursors.resizeLeftRight,
        1 => SystemMouseCursors.resizeUpLeftDownRight,
        2 => SystemMouseCursors.resizeUpDown,
        _ => SystemMouseCursors.resizeUpRightDownLeft,
      };
    }
    return corner == .center
        ? SystemMouseCursors.grab
        : (isInsideSelection ? SystemMouseCursors.move : null);
  }

  TransformResult? getTransform() {
    final position = _currentPosition;
    final previous = _startPosition;
    if (previous == position || position == null || previous == null) {
      return null;
    }
    final delta = position - previous;
    var scaleX = 1.0;
    var scaleY = 1.0;
    var moved = Offset.zero;
    var rotation = 0.0;
    switch (_corner) {
      case .topLeft:
        moved = delta;
        scaleX += -delta.dx / _selection.size.width;
        scaleY += -delta.dy / _selection.size.height;
      case .topCenter:
        scaleY += -delta.dy / _selection.size.height;
        moved = Offset(0, delta.dy);
      case .topRight:
        moved = Offset(0, delta.dy);
        scaleX += delta.dx / _selection.size.width;
        scaleY += -delta.dy / _selection.size.height;
      case .centerLeft:
        moved = Offset(delta.dx, 0);
        scaleX += -delta.dx / _selection.size.width;
        break;
      case .centerRight:
        scaleX += delta.dx / _selection.size.width;
      case .bottomLeft:
        moved = Offset(delta.dx, 0);
        scaleX += -delta.dx / _selection.size.width;
        scaleY += delta.dy / _selection.size.height;
      case .bottomCenter:
        scaleY += delta.dy / _selection.size.height;
      case .bottomRight:
        scaleX += delta.dx / _selection.size.width;
        scaleY += delta.dy / _selection.size.height;
      case SelectionTransformCorner.center when enableRotation:
        rotation =
            ((position - pivot).direction - (previous - pivot).direction) *
            180 /
            pi;
      default:
        moved = delta;
    }
    if (_effectiveScaleMode == .scaleProp) {
      final scale = (scaleX - 1).abs() > (scaleY - 1).abs() ? scaleX : scaleY;
      scaleX = scale;
      scaleY = scale;
      moved = switch (_corner) {
        .topLeft => Offset(
          _selection.width * (1 - scale),
          _selection.height * (1 - scale),
        ),
        .topCenter || .topRight => Offset(0, _selection.height * (1 - scale)),
        .centerLeft || .bottomLeft => Offset(_selection.width * (1 - scale), 0),
        _ => Offset.zero,
      };
    }
    if (_centeredModifier && _corner != null && _corner != .center) {
      scaleX = 1 + 2 * (scaleX - 1);
      scaleY = 1 + 2 * (scaleY - 1);
      moved = Offset(
        _selection.width * (1 - scaleX) / 2,
        _selection.height * (1 - scaleY) / 2,
      );
    }
    return (
      scaleX: scaleX,
      scaleY: scaleY,
      position: moved,
      rotation: rotation,
    );
  }

  void transform(SelectionScaleMode mode, SelectionTransformCorner corner) {
    _scaleMode = mode;
    _corner = corner;
  }

  Rect getTransformedSelection() {
    final transform = getTransform();
    if (transform == null) return _selection;
    return transform.scaleRect(_selection, _selection);
  }

  RectSelectionForegroundRenderer get renderer {
    final rect = getTransformedSelection();
    return RectSelectionForegroundRenderer(
      rect.shift(rect.center.rotate(Offset.zero, rotation) - rect.center),
      rotation: rotation * 180 / pi,
      transformMode: _effectiveScaleMode,
      transformCorner: _corner,
      enableRotation: enableRotation,
      isTransforming: isTransforming,
    );
  }
}

class RectSelectionForegroundRenderer extends Renderer<Rect> {
  final SelectionScaleMode? transformMode;
  final SelectionTransformCorner? transformCorner;
  final bool enableRotation, isTransforming;

  @override
  final double rotation;

  @override
  Rect get rect => element;

  List<Offset> get corners => [
    element.topLeft,
    element.topRight,
    element.bottomRight,
    element.bottomLeft,
  ].map(transformPoint).toList();

  RectSelectionForegroundRenderer(
    super.element, {
    this.transformMode,
    this.transformCorner,
    this.enableRotation = true,
    this.isTransforming = false,
    this.rotation = 0,
  });

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    final rect = Rect.fromLTRB(
      min(element.left, element.right),
      min(element.top, element.bottom),
      max(element.left, element.right),
      max(element.top, element.bottom),
    );
    if (rect.isEmpty || isTransforming) return;
    final paint = Paint()
      ..color = colorScheme?.primaryContainer ?? Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    canvas.drawRect(rect, paint);
    if (transformMode == null) return;
    final realSize = visibleSize / transform.size;
    if (enableRotation) {
      canvas.drawLine(
        element.topCenter,
        SelectionTransformCorner.center.getFromRect(
          element,
          scale: transform.size,
        ),
        paint,
      );
    }
    final color = transformMode == .scaleProp ? Colors.red : Colors.blue;
    final transformPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    final showCenter =
        element.width > 3 * realSize && element.height > 3 * realSize;
    SelectionTransformCorner.values
        .where((element) => !element.isCenter() || showCenter)
        .forEach((corner) {
          final position = corner.getFromRect(element, scale: transform.size);
          if (corner == .center) {
            if (!enableRotation) return;
            canvas.drawCircle(
              position,
              realSize / 1.5,
              transformPaint
                ..style = corner == transformCorner
                    ? PaintingStyle.fill
                    : .stroke,
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
                    : .stroke,
            );
          }
        });

    final icon = transformMode == .scaleProp
        ? PhosphorIconsFill.lock
        : PhosphorIconsLight.lockOpen;
    final textPainter = TextPainter(
      textDirection: .ltr,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontSize: realSize * 2,
          color: color,
        ),
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      element.center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
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

extension SelectionTransformCornerExtension on SelectionTransformCorner? {
  bool isCenter() => switch (this) {
    .topCenter || .centerLeft || .centerRight || .bottomCenter => true,
    _ => false,
  };

  Offset getFromRect(Rect rect, {double? scale}) {
    if (scale == null) {
      return switch (this) {
        .topLeft => rect.topLeft,
        .topCenter => rect.topCenter,
        .topRight => rect.topRight,
        .centerLeft => rect.centerLeft,
        .centerRight => rect.centerRight,
        .bottomLeft => rect.bottomLeft,
        .bottomCenter => rect.bottomCenter,
        .bottomRight => rect.bottomRight,
        _ => rect.topCenter + const Offset(0, -100),
      };
    }

    final spacing = rect.transformHandleSpacing(scale);
    final handlePosition = switch (this) {
      .topLeft => rect.topLeft + Offset(-spacing.dx, -spacing.dy),
      .topCenter => rect.topCenter + Offset(0, -spacing.dy),
      .topRight => rect.topRight + Offset(spacing.dx, -spacing.dy),
      .centerLeft => rect.centerLeft + Offset(-spacing.dx, 0),
      .centerRight => rect.centerRight + Offset(spacing.dx, 0),
      .bottomLeft => rect.bottomLeft + Offset(-spacing.dx, spacing.dy),
      .bottomCenter => rect.bottomCenter + Offset(0, spacing.dy),
      .bottomRight => rect.bottomRight + Offset(spacing.dx, spacing.dy),
      _ =>
        rect.topCenter +
            Offset(0, -(_rotationButtonDistance / scale + spacing.dy)),
    };
    return handlePosition;
  }
}

extension _TransformRectExtension on Rect {
  Offset transformHandleSpacing(double scale) {
    final targetSpacing = _targetTransformSpacing / scale;
    return Offset(
      max(0, (targetSpacing - width) / 2),
      max(0, (targetSpacing - height) / 2),
    );
  }
}
