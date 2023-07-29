import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

typedef ContextMenuBuilder = Widget Function(BuildContext context);

class ContextMenu extends StatefulWidget {
  final Offset position;
  final ContextMenuBuilder builder;
  final double maxWidth, maxHeight;

  const ContextMenu(
      {super.key,
      this.position = Offset.zero,
      required this.builder,
      this.maxHeight = 300,
      this.maxWidth = 300});

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
      duration: const Duration(milliseconds: 200),
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

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: DesktopTextSelectionToolbarLayoutDelegate(
        anchor: widget.position,
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -.5),
          end: Offset.zero,
        ).animate(_animation),
        transformHitTests: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.maxWidth,
            maxHeight: widget.maxHeight,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            child: widget.builder(context),
          ),
        ),
      ),
    );
  }
}

Future<T?> showContextMenu<T>(
    {required BuildContext context,
    Offset position = Offset.zero,
    required ContextMenuBuilder builder,
    double maxHeight = 400,
    double maxWidth = 300}) async {
  final RenderBox box = context.findRenderObject() as RenderBox;
  final Offset globalPos = box.localToGlobal(position);
  AdaptiveTextSelectionToolbar;
  return showModal<T>(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return ContextMenu(
          position: globalPos,
          builder: builder,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        );
      });
}
