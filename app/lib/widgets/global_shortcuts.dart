import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Registers the current route's shortcuts with the app's [ShortcutRegistry].
/// Focused controls keep priority, and shortcuts also work outside the subtree.
class GlobalShortcuts extends StatefulWidget {
  const GlobalShortcuts({
    super.key,
    required this.shortcuts,
    required this.child,
  });

  final Map<ShortcutActivator, Intent> shortcuts;
  final Widget child;

  @override
  State<GlobalShortcuts> createState() => _GlobalShortcutsState();
}

class _GlobalShortcutsState extends State<GlobalShortcuts> {
  ShortcutRegistry? _registry;
  ShortcutRegistryEntry? _entry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final registry = ShortcutRegistry.of(context);
    if (identical(registry, _registry)) return;
    _entry?.dispose();
    _entry = null;
    _registry = registry;
    _registerShortcuts();
  }

  @override
  void didUpdateWidget(GlobalShortcuts oldWidget) {
    super.didUpdateWidget(oldWidget);
    _registerShortcuts();
  }

  void _registerShortcuts() {
    if (widget.shortcuts.isEmpty) {
      _entry?.dispose();
      _entry = null;
      return;
    }
    final shortcuts = <ShortcutActivator, Intent>{
      for (final entry in widget.shortcuts.entries)
        _RouteShortcutActivator(entry.key, () => _isEnabled(entry.value)):
            VoidCallbackIntent(() => _invoke(entry.value)),
    };
    if (_entry == null) {
      _entry = _registry!.addAll(shortcuts);
    } else {
      _entry!.replaceAll(shortcuts);
    }
  }

  @override
  void dispose() {
    _entry?.dispose();
    super.dispose();
  }

  bool _isEnabled(Intent intent) {
    // Dialogs and other routes own their shortcuts while covering this route.
    if (!mounted || ModalRoute.of(context)?.isCurrent == false) {
      return false;
    }
    return _findAction(intent)?.$2.isEnabled(intent) ?? false;
  }

  (BuildContext, Action<Intent>)? _findAction(Intent intent) {
    // Preserve actions supplied by the focused tool, using the route's
    // actions when focus is outside the editor.
    final focusContext = FocusManager.instance.primaryFocus?.context;
    if (focusContext != null) {
      final action = Actions.maybeFind<Intent>(focusContext, intent: intent);
      if (action != null) return (focusContext, action);
    }
    final action = Actions.maybeFind<Intent>(context, intent: intent);
    return action == null ? null : (context, action);
  }

  void _invoke(Intent intent) {
    final target = _findAction(intent);
    if (target == null) return;
    final (actionContext, action) = target;
    Actions.of(actionContext)
        .invokeActionIfEnabled(action, intent, actionContext);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _RouteShortcutActivator extends ShortcutActivator {
  const _RouteShortcutActivator(this.activator, this.isEnabled);

  final ShortcutActivator activator;
  final bool Function() isEnabled;

  @override
  Iterable<LogicalKeyboardKey>? get triggers => activator.triggers;

  @override
  bool accepts(KeyEvent event, HardwareKeyboard state) =>
      activator.accepts(event, state) && isEnabled();

  @override
  String debugDescribeKeys() => activator.debugDescribeKeys();
}
