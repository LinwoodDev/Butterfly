import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OptionButton extends StatelessWidget {
  final Widget icon;
  final Widget? selectedIcon;
  final VoidCallback? onPressed, onLongPressed;
  final bool selected, highlighted, focussed;
  final String tooltip;
  final GlobalKey<TooltipState> _tooltipKey = GlobalKey();

  OptionButton({
    super.key,
    this.tooltip = '',
    required this.icon,
    this.selectedIcon,
    this.onPressed,
    this.onLongPressed,
    this.selected = false,
    this.highlighted = false,
    this.focussed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.manual,
      message: tooltip,
      key: _tooltipKey,
      child: InkWell(
        radius: 12,
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        onLongPress: () {
          _tooltipKey.currentState?.ensureTooltipVisible();
          onLongPressed?.call();
        },
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
              : (focussed
                  ? BoxDecoration(
                      // Border
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    )
                  : null),
          margin: (highlighted || focussed) ? null : const EdgeInsets.all(2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
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
