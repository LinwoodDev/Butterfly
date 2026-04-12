import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ReorderableListItem extends StatelessWidget {
  const ReorderableListItem({
    required this.child,
    required this.index,
    this.enabled = true,
    super.key,
  });

  final Widget child;
  final int index;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.directional(
          textDirection: Directionality.of(context),
          top: 0,
          bottom: 0,
          end: 2,
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: ReorderableDragStartListener(
              index: index,
              enabled: enabled,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: PhosphorIcon(PhosphorIconsLight.dotsSix),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
