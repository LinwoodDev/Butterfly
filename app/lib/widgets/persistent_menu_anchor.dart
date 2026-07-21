import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A Material [MenuAnchor] whose portal is owned by the root overlay instead
/// of the route containing its layout target.
///
/// Flutter's semantics traversal cache retains an [OverlayPortal] after it has
/// been opened. Keeping the portal mounted above route-owned state prevents a
/// closed menu from retaining the route that opened it.
class PersistentMenuAnchor extends StatefulWidget {
  const PersistentMenuAnchor({
    super.key,
    required this.menuChildren,
    required this.builder,
    this.controller,
    this.style,
    this.semanticsLabel,
  });

  final List<Widget> menuChildren;
  final MenuAnchorChildBuilder builder;
  final PersistentMenuAnchorController? controller;
  final MenuStyle? style;
  final String? semanticsLabel;

  @override
  State<PersistentMenuAnchor> createState() => _PersistentMenuAnchorState();
}

class _PersistentMenuAnchorState extends State<PersistentMenuAnchor>
    with WidgetsBindingObserver {
  final _owner = Object();
  _PersistentMenuAnchorHost? _host;
  bool _measureScheduled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final overlay = Overlay.of(context, rootOverlay: true);
    final host = _PersistentMenuAnchorHost.forOverlay(overlay);
    if (!identical(host, _host)) {
      _host?.detach(_owner);
      widget.controller?._detach(_owner);
      _host = host;
      widget.controller?._attach(host, _owner);
      _attach();
    }
    _scheduleMeasure();
  }

  @override
  void didUpdateWidget(covariant PersistentMenuAnchor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.controller, widget.controller)) {
      oldWidget.controller?._detach(_owner);
      final host = _host;
      if (host != null) widget.controller?._attach(host, _owner);
    }
    _update();
    _scheduleMeasure();
  }

  @override
  void didChangeMetrics() => _scheduleMeasure();

  void _attach() {
    _host?.attach(
      _owner,
      menuChildren: widget.menuChildren,
      builder: widget.builder,
      style: widget.style,
    );
  }

  void _update() {
    _host?.update(
      _owner,
      menuChildren: widget.menuChildren,
      builder: widget.builder,
      style: widget.style,
    );
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
    widget.controller?._detach(_owner);
    _host?.detach(_owner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scheduleMeasure();
    return Semantics(
      button: true,
      label: widget.semanticsLabel,
      onTap: () => _host?.open(_owner),
      child: const SizedBox.expand(),
    );
  }
}

class PersistentMenuAnchorController {
  _PersistentMenuAnchorHost? _host;
  Object? _owner;

  void _attach(_PersistentMenuAnchorHost host, Object owner) {
    _host = host;
    _owner = owner;
  }

  void _detach(Object owner) {
    if (!identical(owner, _owner)) return;
    _host = null;
    _owner = null;
  }

  /// Removes route-owned menu widgets and flushes their semantics before the
  /// route is disposed.
  Future<void> prepareForRouteDisposal() async {
    final host = _host;
    final owner = _owner;
    if (host == null || owner == null) return;
    await host.prepareForRouteDisposal(owner);
  }
}

class _PersistentMenuAnchorHost {
  _PersistentMenuAnchorHost._(this.overlay) {
    _entry = OverlayEntry(builder: _build);
    _ensureInserted();
  }

  static final _hosts = Expando<_PersistentMenuAnchorHost>();

  static _PersistentMenuAnchorHost forOverlay(OverlayState overlay) {
    return _hosts[overlay] ??= _PersistentMenuAnchorHost._(overlay);
  }

  final OverlayState overlay;
  final MenuController _controller = MenuController();
  late final OverlayEntry _entry;
  bool _insertScheduled = false;
  bool _buildScheduled = false;
  Object? _owner;
  Rect? _rect;
  List<Widget> _menuChildren = const [];
  MenuAnchorChildBuilder? _builder;
  MenuStyle? _style;

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
    required List<Widget> menuChildren,
    required MenuAnchorChildBuilder builder,
    required MenuStyle? style,
  }) {
    _owner = owner;
    _rect = null;
    update(owner, menuChildren: menuChildren, builder: builder, style: style);
  }

  void update(
    Object owner, {
    required List<Widget> menuChildren,
    required MenuAnchorChildBuilder builder,
    required MenuStyle? style,
  }) {
    if (!identical(owner, _owner)) return;
    _menuChildren = menuChildren;
    _builder = builder;
    _style = style;
    _markNeedsBuild();
  }

  void updateRect(Object owner, Rect rect) {
    if (!identical(owner, _owner) || rect == _rect) return;
    _rect = rect;
    _markNeedsBuild();
  }

  void open(Object owner) {
    if (identical(owner, _owner) && _active) _controller.open();
  }

  Future<void> prepareForRouteDisposal(Object owner) async {
    if (!identical(owner, _owner)) return;
    _menuChildren = const [];
    _builder = null;
    _style = null;
    _markNeedsBuild();
    // MenuItemButton invokes its callback during a post-frame phase. Explicit
    // new frames are needed to rebuild without route-owned widgets, close the
    // overlay, and flush the resulting semantics update before navigation.
    await _nextFrame();
    if (!identical(owner, _owner)) return;
    _controller.close();
    await _nextFrame();
    await _nextFrame();
  }

  void detach(Object owner) {
    if (!identical(owner, _owner)) return;
    _controller.close();
    _owner = null;
    _rect = null;
    _menuChildren = const [];
    _builder = null;
    _style = null;
    _markNeedsBuild();
  }

  void _markNeedsBuild() {
    if (!_entry.mounted || _buildScheduled) return;
    if (WidgetsBinding.instance.schedulerPhase !=
        SchedulerPhase.persistentCallbacks) {
      _entry.markNeedsBuild();
      return;
    }
    _buildScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _buildScheduled = false;
      if (_entry.mounted) _entry.markNeedsBuild();
    });
  }

  Future<void> _nextFrame() {
    final completer = Completer<void>();
    WidgetsBinding.instance.addPostFrameCallback((_) => completer.complete());
    WidgetsBinding.instance.scheduleFrame();
    return completer.future;
  }

  Widget _build(BuildContext context) {
    final active = _active;
    final rect = _rect ?? const Rect.fromLTWH(-1000, -1000, 1, 1);
    return Positioned.fromRect(
      rect: rect,
      child: TickerMode(
        enabled: active,
        child: Offstage(
          offstage: !active,
          child: MenuAnchor(
            key: const ValueKey('persistent-material-menu-anchor'),
            controller: _controller,
            menuChildren: active ? _menuChildren : const [],
            style: active ? _style : null,
            builder: active
                ? _builder
                : (context, controller, child) => const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}
