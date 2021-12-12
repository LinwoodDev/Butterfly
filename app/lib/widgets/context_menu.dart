import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

typedef ContextMenuBuilder = Widget Function(
    BuildContext context, VoidCallback onClose);

class ContextMenu extends StatefulWidget {
  final Offset position;
  final ContextMenuBuilder builder;
  final VoidCallback onClose;
  final double maxWidth, maxHeight;

  const ContextMenu(
      {Key? key,
      this.position = Offset.zero,
      required this.onClose,
      required this.builder,
      this.maxHeight = 500,
      this.maxWidth = 300})
      : super(key: key);

  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _controller.forward();
  }

  late Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    if (!mounted) return;
    _controller.reverse().then<void>((_) {
      if (!mounted) return;
      widget.onClose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      final x = widget.position.dx;
      final y = widget.position.dy;
      // Responsive context menu
      final maxWidth = min(width, widget.maxWidth);
      final maxHeight = min(height, widget.maxHeight);
      final xOffset = x + maxWidth > width ? width - maxWidth : x;
      final yOffset = y + maxHeight > height ? height - maxHeight : y;
      var current = widget.builder(context, _close);
      return Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              child: Container(
                color: Colors.transparent,
              ),
              onTap: _close,
            ),
          ),
          Positioned(
            left: xOffset,
            top: yOffset,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
              ),
              child: ClipRect(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(_animation),
                        transformHitTests: false,
                        child: Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: current),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

Future<void> showContextMenu(
    {required BuildContext context,
    Offset position = Offset.zero,
    required ContextMenuBuilder builder,
    double maxHeight = 500,
    double maxWidth = 300}) async {
  var completer = Completer<void>();
  final overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
      builder: (context) => ContextMenu(
          position: position,
          onClose: () {
            overlayEntry.remove();
            completer.complete();
          },
          builder: builder));
  overlayState?.insert(overlayEntry);
  if (overlayState != null) {
    return completer.future;
  }
}
