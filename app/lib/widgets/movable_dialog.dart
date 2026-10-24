import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_ui/material_ui.dart';

const double _kTitleBarHeight = 56;
const double _kEdgeHandleSize = 8;
const double _kCornerHandleSize = 16;
const Size _kMinimumSize = Size(280, 150);

/// Shows a dialog like [showDialog] that can be moved by dragging its title
/// area and resized by dragging its edges.
///
/// Only [Dialog]s (and the dialogs built on it, like [AlertDialog]) are moved;
/// full screen dialogs and other content stay as they are.
Future<T?> showMovableDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Color? barrierColor,
  String? barrierLabel,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) => showDialog<T>(
  context: context,
  barrierDismissible: barrierDismissible,
  barrierColor: barrierColor,
  barrierLabel: barrierLabel,
  useSafeArea: useSafeArea,
  useRootNavigator: useRootNavigator,
  routeSettings: routeSettings,
  anchorPoint: anchorPoint,
  builder: (context) => MovableDialog(child: builder(context)),
);

class MovableDialog extends StatefulWidget {
  final Widget child;

  const MovableDialog({super.key, required this.child});

  @override
  State<MovableDialog> createState() => _MovableDialogState();
}

class _MovableDialogState extends State<MovableDialog> {
  RenderObject? _dialog;
  Rect? _box;
  Size _area = Size.zero;
  Offset? _position;
  Size? _size;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _findDialog());
  }

  void _findDialog() {
    if (!mounted) return;
    RenderObject? dialog;
    void visit(Element element, int depth) {
      if (dialog != null || depth > 32) return;
      if (element.widget is Dialog) {
        dialog = element.renderObject;
        return;
      }
      element.visitChildren((child) => visit(child, depth + 1));
    }

    context.visitChildElements((child) => visit(child, 0));
    if (dialog != _dialog) setState(() => _dialog = dialog);
  }

  void _onBoxChanged(Rect? box, Size area) {
    if (!mounted) return;
    setState(() {
      _box = box;
      _area = area;
    });
    // The content may have replaced its dialog.
    if (box == null && !(_dialog?.attached ?? true)) _findDialog();
  }

  double _clamp(double value, double lower, double upper) =>
      value.clamp(lower, math.max(lower, upper));

  void _move(Offset delta) {
    final box = _box;
    if (box == null) return;
    final size = _size ?? box.size;
    final position = (_position ?? box.topLeft) + delta;
    setState(
      () => _position = Offset(
        _clamp(position.dx, 0, _area.width - size.width),
        _clamp(position.dy, 0, _area.height - size.height),
      ),
    );
  }

  void _resize(Alignment edge, Offset delta) {
    final box = _box;
    if (box == null) return;
    final rect = (_position ?? box.topLeft) & (_size ?? box.size);
    final minWidth = math.min(_kMinimumSize.width, rect.width);
    final minHeight = math.min(_kMinimumSize.height, rect.height);
    var left = rect.left, top = rect.top, right = rect.right;
    var bottom = rect.bottom;
    if (edge.x < 0) left = _clamp(left + delta.dx, 0, right - minWidth);
    if (edge.x > 0) {
      right = _clamp(right + delta.dx, left + minWidth, _area.width);
    }
    if (edge.y < 0) top = _clamp(top + delta.dy, 0, bottom - minHeight);
    if (edge.y > 0) {
      bottom = _clamp(bottom + delta.dy, top + minHeight, _area.height);
    }
    setState(() {
      _position = Offset(left, top);
      _size = Size(right - left, bottom - top);
    });
  }

  Widget _buildHandle(Rect box, Alignment edge) {
    final corner = edge.x != 0 && edge.y != 0;
    final handle = corner ? _kCornerHandleSize : _kEdgeHandleSize;
    double start(double edge, double low, double high) => switch (edge) {
      < 0 => low - handle / 2,
      > 0 => high - handle / 2,
      _ => low + _kCornerHandleSize / 2,
    };
    double end(double edge, double low, double high) => switch (edge) {
      < 0 => low + handle / 2,
      > 0 => high + handle / 2,
      _ => high - _kCornerHandleSize / 2,
    };
    final cursor = switch ((edge.x, edge.y)) {
      (0, _) => SystemMouseCursors.resizeUpDown,
      (_, 0) => SystemMouseCursors.resizeLeftRight,
      (< 0, < 0) || (> 0, > 0) => SystemMouseCursors.resizeUpLeftDownRight,
      _ => SystemMouseCursors.resizeUpRightDownLeft,
    };
    return Positioned.fromRect(
      rect: Rect.fromLTRB(
        start(edge.x, box.left, box.right),
        start(edge.y, box.top, box.bottom),
        end(edge.x, box.left, box.right),
        end(edge.y, box.top, box.bottom),
      ),
      child: MouseRegion(
        cursor: cursor,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (details) => _resize(edge, details.delta),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // A resized dialog gets its size from the dialog theme. Nested dialogs
    // capture this theme, so it is always replaced here.
    final dialogTheme = Theme.of(context).dialogTheme;
    final size = _size;
    final child = _MovableDialogBox(
      dialog: _dialog,
      dialogPosition: _position,
      onBoxChanged: _onBoxChanged,
      child: DialogTheme(
        data: size == null
            ? dialogTheme
            : dialogTheme.copyWith(
                insetPadding: EdgeInsets.zero,
                constraints: BoxConstraints.tight(size),
              ),
        child: widget.child,
      ),
    );
    // The dialog keeps its place in the tree, so its state survives when the
    // handles appear.
    final box = _box;
    final titleBar = box == null
        ? Rect.zero
        : Rect.fromLTWH(
            box.left,
            box.top,
            box.width,
            math.min(_kTitleBarHeight, box.height),
          );
    return Stack(
      fit: StackFit.expand,
      children: [
        RawGestureDetector(
          gestures: {
            _TitleBarDragGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<
                  _TitleBarDragGestureRecognizer
                >(() => _TitleBarDragGestureRecognizer(debugOwner: this), (
                  instance,
                ) {
                  instance
                    ..titleBar = titleBar
                    ..onUpdate = (details) => _move(details.delta);
                }),
          },
          child: child,
        ),
        if (box != null) ...[
          Positioned.fromRect(
            rect: titleBar,
            child: const MouseRegion(
              cursor: SystemMouseCursors.move,
              hitTestBehavior: HitTestBehavior.translucent,
            ),
          ),
          for (final edge in const [
            Alignment.centerLeft,
            Alignment.topCenter,
            Alignment.centerRight,
            Alignment.bottomCenter,
            Alignment.topLeft,
            Alignment.topRight,
            Alignment.bottomLeft,
            Alignment.bottomRight,
          ])
            _buildHandle(box, edge),
        ],
      ],
    );
  }
}

class _TitleBarDragGestureRecognizer extends PanGestureRecognizer {
  Rect titleBar = Rect.zero;

  _TitleBarDragGestureRecognizer({super.debugOwner});

  @override
  bool isPointerAllowed(PointerEvent event) =>
      titleBar.contains(event.localPosition) && super.isPointerAllowed(event);
}

class _MovableDialogBox extends SingleChildRenderObjectWidget {
  final RenderObject? dialog;
  final Offset? dialogPosition;
  final void Function(Rect? box, Size area) onBoxChanged;

  const _MovableDialogBox({
    required this.dialog,
    required this.dialogPosition,
    required this.onBoxChanged,
    required super.child,
  });

  @override
  _RenderMovableDialogBox createRenderObject(BuildContext context) =>
      _RenderMovableDialogBox(
        dialog: dialog,
        dialogPosition: dialogPosition,
        onBoxChanged: onBoxChanged,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderMovableDialogBox renderObject,
  ) {
    renderObject
      ..dialog = dialog
      ..dialogPosition = dialogPosition
      ..onBoxChanged = onBoxChanged;
  }
}

/// Paints the dialog box at [dialogPosition] by translating its content, so
/// the dialog keeps its own layout and moves without the animation of
/// [Dialog.insetPadding].
class _RenderMovableDialogBox extends RenderProxyBox {
  RenderObject? _dialog;
  Offset? _dialogPosition;
  void Function(Rect? box, Size area) onBoxChanged;
  Offset _translation = Offset.zero;
  Rect? _reportedBox;
  Size? _reportedArea;

  _RenderMovableDialogBox({
    RenderObject? dialog,
    Offset? dialogPosition,
    required this.onBoxChanged,
  }) {
    this.dialog = dialog;
    this.dialogPosition = dialogPosition;
  }

  set dialog(RenderObject? value) {
    if (_dialog == value) return;
    _dialog = value;
    markNeedsPaint();
  }

  set dialogPosition(Offset? value) {
    if (_dialogPosition == value) return;
    _dialogPosition = value;
    markNeedsPaint();
  }

  // Dialog > Semantics > AnimatedPadding > Align, whose child is the box.
  RenderBox? _findBox() {
    RenderObject? object = _dialog;
    if (object == null || !object.attached) return null;
    for (var depth = 0; depth < 4 && object != null; depth++) {
      if (object is RenderPositionedBox) return object.child;
      RenderObject? next;
      object.visitChildren((child) => next ??= child);
      object = next;
    }
    return null;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child == null) return;
    final box = _findBox();
    Rect? rect;
    _translation = Offset.zero;
    if (box != null && box.hasSize) {
      final natural = box.localToGlobal(Offset.zero, ancestor: child);
      final position = _dialogPosition;
      if (position != null) {
        final maxLeft = math.max(0.0, size.width - box.size.width);
        final maxTop = math.max(0.0, size.height - box.size.height);
        _translation =
            Offset(
              position.dx.clamp(0, maxLeft),
              position.dy.clamp(0, maxTop),
            ) -
            natural;
      }
      rect = (natural + _translation) & box.size;
    }
    context.paintChild(child, offset + _translation);
    if (rect != _reportedBox || size != _reportedArea) {
      _reportedBox = rect;
      _reportedArea = size;
      final area = size;
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => onBoxChanged(rect, area),
      );
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final child = this.child;
    if (child == null) return false;
    return result.addWithPaintOffset(
      offset: _translation,
      position: position,
      hitTest: (result, transformed) =>
          child.hitTest(result, position: transformed),
    );
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.translateByDouble(_translation.dx, _translation.dy, 0, 1);
  }
}
