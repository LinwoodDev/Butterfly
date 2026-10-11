import 'dart:async';

import 'package:material_ui/material_ui.dart';

enum _FadePhase { visible, fadingOut, hidden }

/// Fades out an idle child, keeping it visible while it is being used.
class FadingView extends StatefulWidget {
  final bool autoHide;

  /// Changing this value reveals the child and restarts the inactivity delay.
  final Object? activityKey;
  final Duration hideDelay;
  final Duration duration;
  final Widget child;

  const FadingView({
    super.key,
    this.autoHide = true,
    this.activityKey,
    this.hideDelay = const Duration(seconds: 5),
    this.duration = const Duration(milliseconds: 500),
    required this.child,
  });

  @override
  State<FadingView> createState() => _FadingViewState();
}

class _FadingViewState extends State<FadingView> {
  Timer? _hideTimer;
  _FadePhase _phase = _FadePhase.visible;
  bool _focused = false;
  bool _hovered = false;
  final _pointers = <int>{};

  @override
  void initState() {
    super.initState();
    _scheduleHide();
  }

  @override
  void didUpdateWidget(covariant FadingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.autoHide != widget.autoHide ||
        oldWidget.activityKey != widget.activityKey ||
        oldWidget.hideDelay != widget.hideDelay) {
      _phase = _FadePhase.visible;
      _scheduleHide();
    }
  }

  void _scheduleHide() {
    _hideTimer?.cancel();
    if (!widget.autoHide ||
        _phase != _FadePhase.visible ||
        _focused ||
        _hovered ||
        _pointers.isNotEmpty) {
      return;
    }
    _hideTimer = Timer(widget.hideDelay, () {
      if (mounted) setState(() => _phase = _FadePhase.fadingOut);
    });
  }

  void _releasePointer(int pointer) {
    _pointers.remove(pointer);
    _scheduleHide();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hidden = _phase != _FadePhase.visible;
    return IgnorePointer(
      ignoring: hidden,
      child: ExcludeFocus(
        excluding: hidden,
        child: AnimatedOpacity(
          opacity: hidden ? 0 : 1,
          duration: widget.duration,
          curve: Curves.easeInOut,
          onEnd: () {
            if (_phase == _FadePhase.fadingOut) {
              setState(() => _phase = _FadePhase.hidden);
            }
          },
          child: Visibility(
            // Keep the child mounted, and reclaim its space only after fading.
            visible: _phase != _FadePhase.hidden,
            maintainState: true,
            child: Focus(
              onFocusChange: (focused) {
                _focused = focused;
                _scheduleHide();
              },
              child: MouseRegion(
                onEnter: (_) {
                  _hovered = true;
                  _scheduleHide();
                },
                onExit: (_) {
                  _hovered = false;
                  _scheduleHide();
                },
                child: Listener(
                  onPointerDown: (event) {
                    _pointers.add(event.pointer);
                    _scheduleHide();
                  },
                  onPointerUp: (event) => _releasePointer(event.pointer),
                  onPointerCancel: (event) => _releasePointer(event.pointer),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
