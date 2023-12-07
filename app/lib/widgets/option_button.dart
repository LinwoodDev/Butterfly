import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OptionButton extends StatefulWidget {
  final Widget icon;
  final Widget? selectedIcon;
  final VoidCallback? onPressed, onSecondaryPressed, onLongPressed;
  final bool selected, highlighted, focussed;
  final String tooltip;

  const OptionButton({
    super.key,
    this.tooltip = '',
    required this.icon,
    this.selectedIcon,
    this.onPressed,
    this.onSecondaryPressed,
    this.onLongPressed,
    this.selected = false,
    this.highlighted = false,
    this.focussed = false,
  });

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton>
    with TickerProviderStateMixin {
  final GlobalKey<TooltipState> _tooltipKey = GlobalKey();
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
      value: _nextValue,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  double get _nextValue => widget.selected || widget.highlighted ? 1 : 0;

  @override
  void didUpdateWidget(covariant OptionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected ||
        widget.highlighted != oldWidget.highlighted) {
      setState(() {});
      _animationController.animateTo(_nextValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    const selectedBottom = Align(
      child: PhosphorIcon(
        PhosphorIconsLight.caretDown,
        size: 12,
      ),
    );
    return Tooltip(
      triggerMode: TooltipTriggerMode.manual,
      message: widget.tooltip,
      key: _tooltipKey,
      child: InkWell(
        radius: 12,
        borderRadius: BorderRadius.circular(12),
        onTap: widget.onPressed,
        onSecondaryTap: widget.onSecondaryPressed,
        onLongPress: widget.onLongPressed == null
            ? null
            : () {
                _tooltipKey.currentState?.ensureTooltipVisible();
                widget.onLongPressed?.call();
              },
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              decoration: widget.highlighted
                  ? BoxDecoration(
                      // Border
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2 * _animation.value,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    )
                  : (widget.focussed
                      ? BoxDecoration(
                          // Border
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            width: 2 * _animation.value,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        )
                      : null),
              margin: (widget.highlighted || widget.focussed)
                  ? null
                  : const EdgeInsets.all(2),
              child: child,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: IconTheme(
                data: Theme.of(context).iconTheme.copyWith(
                    size: 28,
                    color: widget.selected
                        ? Theme.of(context).colorScheme.primary
                        : null),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.selected
                        ? (widget.selectedIcon ?? widget.icon)
                        : widget.icon,
                    SizeTransition(
                      axisAlignment: -1,
                      axis: Axis.vertical,
                      sizeFactor: _animation,
                      child: selectedBottom,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
