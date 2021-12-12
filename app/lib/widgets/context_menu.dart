import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ContextMenu extends StatelessWidget {
  final Offset position;
  final WidgetBuilder builder;
  final VoidCallback onClose;

  const ContextMenu(
      {Key? key,
      this.position = Offset.zero,
      required this.onClose,
      required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // Responsive context menu
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            final x = position.dx;
            final y = position.dy;
            var left = x - width / 2;
            var top = y - height / 2;
            double maxLeft = 0;
            double maxTop = 0;
            final maxRight = MediaQuery.of(context).size.width;
            final maxBottom = MediaQuery.of(context).size.height;
            left = min(max(maxLeft, left), maxRight - width);
            top = min(max(maxTop, top), maxBottom - height);
            return Positioned(
              left: left,
              top: top,
              width: width,
              height: height,
              child: Material(
                child: Builder(builder: builder),
              ),
            );
          },
        ),
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose,
          ),
        ),
      ],
    );
  }
}

Future<void> showContextMenu(
    {required BuildContext context,
    Offset position = Offset.zero,
    required WidgetBuilder builder}) async {
  var completer = Completer<void>();
  final overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
      builder: (context) => ContextMenu(
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
