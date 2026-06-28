import 'package:flutter/material.dart';

/// Controller for managing multiple selection state.
class MultiSelectController<T> extends ChangeNotifier {
  final Set<T> _selectedIds = {};
  bool _isSelectionMode = false;

  /// Returns an unmodifiable set of the currently selected ideas.
  Set<T> get selectedIds => Set.unmodifiable(_selectedIds);

  /// Returns true if selection mode is currently active.
  bool get selectionMode => _isSelectionMode || _selectedIds.isNotEmpty;

  /// Manually enables selection mode without selecting an item.
  void enableSelectionMode() {
    if (!_isSelectionMode) {
      _isSelectionMode = true;
      notifyListeners();
    }
  }

  /// Toggles the selection state of the given [id].
  void toggle(T id) {
    if (_selectedIds.contains(id)) {
      _selectedIds.remove(id);
    } else {
      _selectedIds.add(id);
    }
    if (_selectedIds.isEmpty) {
      _isSelectionMode = false;
    }
    notifyListeners();
  }

  /// Selects the given [id].
  void select(T id) {
    if (_selectedIds.add(id)) {
      notifyListeners();
    }
  }

  /// Deselects the given [id].
  void deselect(T id) {
    if (_selectedIds.remove(id)) {
      if (_selectedIds.isEmpty) {
        _isSelectionMode = false;
      }
      notifyListeners();
    }
  }

  /// Clears all selections and disables selection mode.
  void clear() {
    _selectedIds.clear();
    _isSelectionMode = false;
    notifyListeners();
  }

  /// Selects all given [ids].
  void selectAll(Iterable<T> ids) {
    _selectedIds.addAll(ids);
    notifyListeners();
  }
}

/// An [InheritedWidget] that provides the [MultiSelectController] to its descendants.
class MultiSelectProvider<T>
    extends InheritedNotifier<MultiSelectController<T>> {
  const MultiSelectProvider({
    super.key,
    required MultiSelectController<T> controller,
    required super.child,
  }) : super(notifier: controller);

  static MultiSelectController<T> of<T>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<MultiSelectProvider<T>>();
    assert(provider != null, 'No MultiSelectProvider found in context');
    return provider!.notifier!;
  }
}

/// A region that manages a [MultiSelectController] and provides it to its subtree.
class MultiSelectRegion<T> extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    MultiSelectController<T> controller,
    Widget? child,
  )
  builder;
  final Widget Function(
    BuildContext context,
    MultiSelectController<T> controller,
  )?
  toolbarBuilder;
  final Widget? child;
  final MultiSelectController<T>? controller;

  const MultiSelectRegion({
    super.key,
    required this.builder,
    this.toolbarBuilder,
    this.child,
    this.controller,
  });

  @override
  State<MultiSelectRegion<T>> createState() => _MultiSelectRegionState<T>();
}

class _MultiSelectRegionState<T> extends State<MultiSelectRegion<T>> {
  late MultiSelectController<T> _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? MultiSelectController<T>();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiSelectProvider<T>(
      controller: _controller,
      child: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.toolbarBuilder != null && _controller.selectionMode)
                widget.toolbarBuilder!(context, _controller),
              Expanded(
                child: widget.builder(context, _controller, widget.child),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// A convenience tile that interacts with the [MultiSelectController] provided by [MultiSelectRegion].
class MultiSelectListTile<T> extends StatelessWidget {
  final T id;
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const MultiSelectListTile({
    super.key,
    required this.id,
    required this.title,
    this.subtitle,
    this.leading,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final controller = MultiSelectProvider.of<T>(context);
    final isSelected = controller.selectedIds.contains(id);
    final selectionMode = controller.selectionMode;

    return ListTile(
      title: title,
      subtitle: subtitle,
      leading: selectionMode
          ? Checkbox(value: isSelected, onChanged: (_) => controller.toggle(id))
          : leading,
      selected: isSelected,
      onTap: () {
        if (selectionMode) {
          controller.toggle(id);
        } else if (onTap != null) {
          onTap!();
        }
      },
      onLongPress: () {
        if (!selectionMode) {
          controller.enableSelectionMode();
          controller.toggle(id);
        } else if (onLongPress != null) {
          onLongPress!();
        }
      },
    );
  }
}
