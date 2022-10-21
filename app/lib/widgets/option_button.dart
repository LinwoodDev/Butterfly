import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OptionButton extends StatelessWidget {
  final Icon icon, selectedIcon;
  final VoidCallback onPressed, onLongPressed;
  final bool selected, highlighted;
  final String tooltip;

  const OptionButton(
      {super.key,
      this.tooltip = '',
      required this.icon,
      required this.selectedIcon,
      required this.onPressed,
      required this.onLongPressed,
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
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: highlighted
                ? BoxDecoration(
                    // Border
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  )
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
              child: IconTheme(
                  data: Theme.of(context).iconTheme.copyWith(
                      size: 28,
                      color: selected
                          ? Theme.of(context).colorScheme.primary
                          : null),
                  child: Column(
                    children: [
                      selected ? selectedIcon : icon,
                      if (selected)
                        const Icon(
                          PhosphorIcons.caretDown,
                          size: 12,
                        ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
