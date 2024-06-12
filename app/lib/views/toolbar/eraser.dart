import 'package:butterfly/views/toolbar/view.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum ColorPickerToolbarAction { delete, pin, eyeDropper }

class EraserToolbarView extends StatelessWidget implements PreferredSizeWidget {
  final bool eraseElements;
  final VoidCallback onToggleEraseElements;

  const EraserToolbarView({
    super.key,
    required this.eraseElements,
    required this.onToggleEraseElements,
  });

  @override
  Size get preferredSize => kToolbarSmall;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.image),
          selectedIcon: const PhosphorIcon(PhosphorIconsFill.image),
          isSelected: eraseElements,
          onPressed: onToggleEraseElements,
        ),
      ],
    );
  }
}
