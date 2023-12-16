import 'package:butterfly/main.dart';
import 'package:flutter/material.dart';

class ResponsiveDialog extends StatelessWidget {
  final Widget child;

  const ResponsiveDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < kMobileWidth) {
        return Dialog.fullscreen(
          child: child,
        );
      } else {
        return Dialog(
          child: child,
        );
      }
    });
  }
}
