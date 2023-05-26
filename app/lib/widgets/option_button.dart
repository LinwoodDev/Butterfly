import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OptionButton extends StatelessWidget {
  final Widget icon;
  final Widget? selectedIcon;
  final VoidCallback? onPressed, onLongPressed;
  final bool selected, highlighted;
  final String tooltip;

  const OptionButton(
      {super.key,
      this.tooltip = '',
      required this.icon,
      this.selectedIcon,
      this.onPressed,
      this.onLongPressed,
      this.selected = false,
      this.highlighted = false});
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        radius: 12,
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        onLongPress: onLongPressed,
        child: Container(
          decoration: highlighted
              ? BoxDecoration(
                  // Border
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
          margin: highlighted ? null : const EdgeInsets.all(2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
            child: IconTheme(
                data: Theme.of(context).iconTheme.copyWith(
                    size: 28,
                    color: selected
                        ? Theme.of(context).colorScheme.primary
                        : null),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    selected ? (selectedIcon ?? icon) : icon,
                    if (selected)
                      const PhosphorIcon(
                        PhosphorIconsLight.caretDown,
                        size: 12,
                      ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
