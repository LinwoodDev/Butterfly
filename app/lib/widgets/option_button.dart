import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OptionButton extends StatefulWidget {
  final Widget icon;
  final Widget? selectedIcon, bottomIcon, leadingIcon;
  final VoidCallback? onPressed, onSecondaryPressed, onLongPressed, onDoubleTap;
  final bool selected, highlighted, focussed, showBottom;
  final String tooltip;

  const OptionButton({
    super.key,
    this.tooltip = '',
    required this.icon,
    this.selectedIcon,
    this.bottomIcon,
    this.leadingIcon,
    this.onPressed,
    this.onSecondaryPressed,
    this.onLongPressed,
    this.onDoubleTap,
    this.selected = false,
    this.highlighted = false,
    this.focussed = false,
    this.showBottom = false,
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

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  double get _nextValue => widget.showBottom ? 1 : 0;

  @override
  void didUpdateWidget(covariant OptionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected ||
        widget.highlighted != oldWidget.highlighted ||
        widget.showBottom != oldWidget.showBottom) {
      setState(() {});
      _animationController.animateTo(_nextValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedBottom = IconTheme(
      data: Theme.of(context).iconTheme.copyWith(
        size: 14,
        color: widget.selected ? ColorScheme.of(context).primary : null,
      ),
      child: Align(
        child:
            widget.bottomIcon ??
            const PhosphorIcon(PhosphorIconsLight.caretDown),
      ),
    );
    return Tooltip(
      triggerMode: TooltipTriggerMode.manual,
      message: widget.tooltip,
      key: _tooltipKey,
      child: AspectRatio(
        aspectRatio: 1,
        child: InkWell(
          radius: 12,
          borderRadius: BorderRadius.circular(12),
          onTap: widget.onPressed,
          onDoubleTap: widget.onDoubleTap,
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
                          color: ColorScheme.of(context).primary,
                          width: 2 * _animation.value,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      )
                    : (widget.focussed
                          ? BoxDecoration(
                              // Border
                              border: Border.all(
                                color: ColorScheme.of(context).outlineVariant,
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
                      ? ColorScheme.of(context).primary
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        if (widget.leadingIcon != null)
                          Align(
                            alignment: Alignment.topLeft,
                            child: widget.leadingIcon!,
                          ),
                        widget.selected
                            ? (widget.selectedIcon ?? widget.icon)
                            : widget.icon,
                      ],
                    ),
                    SizeTransition(
                      axisAlignment: -1,
                      axis: Axis.vertical,
                      sizeFactor: _animation,
                      child: Column(
                        children: [const SizedBox(height: 4), selectedBottom],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
