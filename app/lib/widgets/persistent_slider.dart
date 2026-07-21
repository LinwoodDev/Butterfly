import 'package:flutter/material.dart';

/// A Material [Slider] whose render tree is owned by the root overlay instead
/// of the route containing its layout target.
///
/// Flutter's slider keeps an [OverlayPortal] mounted for its value indicator.
/// Keeping one slider instance alive for the lifetime of the root overlay
/// prevents a disposed portal from retaining the route that used the slider.
class PersistentSlider extends StatefulWidget {
  const PersistentSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.onChangeEnd,
    this.min = 0,
    this.max = 1,
    this.opacity,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;
  final Animation<double>? opacity;

  @override
  State<PersistentSlider> createState() => _PersistentSliderState();
}

class _PersistentSliderState extends State<PersistentSlider>
    with WidgetsBindingObserver {
  final _owner = Object();
  _PersistentSliderHost? _host;
  bool _measureScheduled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.opacity?.addListener(_updateOpacity);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final overlay = Overlay.of(context, rootOverlay: true);
    final host = _PersistentSliderHost.forOverlay(overlay);
    if (!identical(host, _host)) {
      _host?.detach(_owner);
      _host = host;
      _attach();
    }
    _scheduleMeasure();
  }

  @override
  void didUpdateWidget(covariant PersistentSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.opacity, widget.opacity)) {
      oldWidget.opacity?.removeListener(_updateOpacity);
      widget.opacity?.addListener(_updateOpacity);
    }
    _update();
    _scheduleMeasure();
  }

  @override
  void didChangeMetrics() => _scheduleMeasure();

  void _attach() {
    _host?.attach(
      _owner,
      value: widget.value,
      min: widget.min,
      max: widget.max,
      opacity: widget.opacity?.value ?? 1,
      onChanged: widget.onChanged,
      onChangeEnd: widget.onChangeEnd,
    );
  }

  void _update() {
    _host?.update(
      _owner,
      value: widget.value,
      min: widget.min,
      max: widget.max,
      opacity: widget.opacity?.value ?? 1,
      onChanged: widget.onChanged,
      onChangeEnd: widget.onChangeEnd,
    );
  }

  void _updateOpacity() {
    _host?.updateOpacity(_owner, widget.opacity?.value ?? 1);
  }

  void _scheduleMeasure() {
    if (_measureScheduled) return;
    _measureScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureScheduled = false;
      if (!mounted) return;
      final targetBox = context.findRenderObject();
      final overlayBox = _host?.overlay.context.findRenderObject();
      if (targetBox is! RenderBox ||
          overlayBox is! RenderBox ||
          !targetBox.hasSize ||
          !overlayBox.hasSize) {
        return;
      }
      final targetOrigin = targetBox.localToGlobal(Offset.zero);
      final overlayOrigin = overlayBox.localToGlobal(Offset.zero);
      _host?.updateRect(
        _owner,
        (targetOrigin - overlayOrigin) & targetBox.size,
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.opacity?.removeListener(_updateOpacity);
    _host?.detach(_owner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scheduleMeasure();
    final step = (widget.max - widget.min) / 20;
    void adjust(double delta) {
      final value = (widget.value + delta).clamp(widget.min, widget.max);
      widget.onChanged?.call(value);
      widget.onChangeEnd?.call(value);
    }

    final normalized = (widget.value - widget.min) / (widget.max - widget.min);
    final increased = (widget.value + step).clamp(widget.min, widget.max);
    final decreased = (widget.value - step).clamp(widget.min, widget.max);
    return Semantics(
      slider: true,
      value: '${(normalized * 100).round()}%',
      increasedValue:
          '${(((increased - widget.min) / (widget.max - widget.min)) * 100).round()}%',
      decreasedValue:
          '${(((decreased - widget.min) / (widget.max - widget.min)) * 100).round()}%',
      onIncrease: widget.onChanged == null ? null : () => adjust(step),
      onDecrease: widget.onChanged == null ? null : () => adjust(-step),
      child: const SizedBox(width: double.infinity, height: 48),
    );
  }
}

class _PersistentSliderHost {
  _PersistentSliderHost._(this.overlay) {
    _entry = OverlayEntry(builder: _build);
    _ensureInserted();
  }

  static final _hosts = Expando<_PersistentSliderHost>();

  static _PersistentSliderHost forOverlay(OverlayState overlay) {
    return _hosts[overlay] ??= _PersistentSliderHost._(overlay);
  }

  final OverlayState overlay;
  late final OverlayEntry _entry;
  bool _insertScheduled = false;
  bool _buildScheduled = false;
  Object? _owner;
  Rect? _rect;
  double _value = 0;
  double _min = 0;
  double _max = 1;
  double _opacity = 0;
  ValueChanged<double>? _onChanged;
  ValueChanged<double>? _onChangeEnd;

  bool get _active => _owner != null && _rect != null;

  void _ensureInserted() {
    if (_entry.mounted || _insertScheduled) return;
    _insertScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _insertScheduled = false;
      if (!_entry.mounted && overlay.mounted) {
        overlay.insert(_entry);
      }
    });
  }

  void attach(
    Object owner, {
    required double value,
    required double min,
    required double max,
    required double opacity,
    required ValueChanged<double>? onChanged,
    required ValueChanged<double>? onChangeEnd,
  }) {
    _owner = owner;
    _rect = null;
    update(
      owner,
      value: value,
      min: min,
      max: max,
      opacity: opacity,
      onChanged: onChanged,
      onChangeEnd: onChangeEnd,
    );
  }

  void update(
    Object owner, {
    required double value,
    required double min,
    required double max,
    required double opacity,
    required ValueChanged<double>? onChanged,
    required ValueChanged<double>? onChangeEnd,
  }) {
    if (!identical(owner, _owner)) return;
    _value = value;
    _min = min;
    _max = max;
    _opacity = opacity;
    _onChanged = onChanged;
    _onChangeEnd = onChangeEnd;
    _markNeedsBuild();
  }

  void updateRect(Object owner, Rect rect) {
    if (!identical(owner, _owner) || rect == _rect) return;
    _rect = rect;
    _markNeedsBuild();
  }

  void updateOpacity(Object owner, double opacity) {
    if (!identical(owner, _owner) || opacity == _opacity) return;
    _opacity = opacity;
    _markNeedsBuild();
  }

  void detach(Object owner) {
    if (!identical(owner, _owner)) return;
    _owner = null;
    _rect = null;
    _opacity = 0;
    _onChanged = null;
    _onChangeEnd = null;
    _markNeedsBuild();
  }

  void _markNeedsBuild() {
    if (!_entry.mounted || _buildScheduled) return;
    _buildScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _buildScheduled = false;
      if (_entry.mounted) _entry.markNeedsBuild();
    });
  }

  void _handleChanged(double value) => _onChanged?.call(value);

  void _handleChangeEnd(double value) => _onChangeEnd?.call(value);

  Widget _build(BuildContext context) {
    final active = _active;
    final rect = _rect ?? const Rect.fromLTWH(-1000, -1000, 1, 1);
    return Positioned.fromRect(
      rect: rect,
      child: TickerMode(
        enabled: active,
        child: Offstage(
          offstage: !active,
          child: Opacity(
            opacity: _opacity.clamp(0, 1),
            child: ExcludeSemantics(
              child: Material(
                type: MaterialType.transparency,
                child: Slider(
                  key: const ValueKey('persistent-material-slider'),
                  value: _value.clamp(_min, _max),
                  min: _min,
                  max: _max,
                  onChanged: active ? _handleChanged : null,
                  onChangeEnd: active ? _handleChangeEnd : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
