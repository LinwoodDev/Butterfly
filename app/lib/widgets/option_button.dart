import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OptionButton extends StatelessWidget {
  final Icon icon, selectedIcon;
  final VoidCallback onPressed, onLongPressed;
  final bool isSelected;
  final String tooltip;

  const OptionButton(
      {Key? key,
      this.tooltip = '',
      required this.icon,
      required this.selectedIcon,
      required this.onPressed,
      required this.onLongPressed,
      this.isSelected = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        radius: 12,
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        onLongPress: onLongPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
          child: IconTheme(
              data: Theme.of(context).iconTheme.copyWith(
                  size: 32,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : null),
              child: Column(
                children: [
                  isSelected ? selectedIcon : icon,
                  if (isSelected)
                    const Icon(
                      PhosphorIcons.caretDown,
                      size: 12,
                    )
                ],
              )),
        ),
      ),
    );
  }
}
