import 'dart:async';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

typedef ContextMenuBuilder =
    List<ContextMenuEntry> Function(BuildContext context);

sealed class ContextMenuEntry {
  final String label;
  final Widget icon;
  final MenuSerializableShortcut? shortcut;

  ContextMenuEntry({required this.label, required this.icon, this.shortcut});
}

class ContextMenuItem extends ContextMenuEntry {
  final VoidCallback? onPressed;

  ContextMenuItem({
    required super.label,
    required super.icon,
    this.onPressed,
    super.shortcut,
  });
}

class ContextMenuGroup extends ContextMenuEntry {
  final List<Widget> children;

  ContextMenuGroup({
    required super.label,
    required super.icon,
    required this.children,
    super.shortcut,
  });
}

class ContextMenu extends StatefulWidget {
  final Offset position;
  final ContextMenuBuilder builder;
  final double maxWidth, maxHeight;

  const ContextMenu({
    super.key,
    this.position = Offset.zero,
    required this.builder,
    this.maxHeight = 300,
    this.maxWidth = 300,
  });

  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _controller.forward();
  }

  late Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.read<SettingsCubit>().state.platformTheme.isMobile(
      context,
    );
    final entries = widget.builder(context);
    return CustomSingleChildLayout(
      delegate: DesktopTextSelectionToolbarLayoutDelegate(
        anchor: widget.position,
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -.5),
          end: Offset.zero,
        ).animate(_animation),
        transformHitTests: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: max(widget.maxWidth, isMobile ? double.infinity : 60),
            maxHeight: min(widget.maxHeight, isMobile ? 60 : double.infinity),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            child: ListView(
              scrollDirection: isMobile ? Axis.horizontal : Axis.vertical,
              shrinkWrap: true,
              children: entries
                  .map((entry) => buildMenuItem(context, entry, isMobile, true))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildMenuItem(
  BuildContext context,
  ContextMenuEntry entry,
  bool isIcon,
  bool showCaret,
) {
  Widget buildItemWidget(VoidCallback? onPressed) => AspectRatio(
    aspectRatio: 1,
    child: IconButton(
      icon: entry.icon,
      tooltip: entry.label,
      onPressed: onPressed,
      iconSize: 30,
    ),
  );
  return switch (entry) {
    ContextMenuItem() =>
      isIcon
          ? buildItemWidget(entry.onPressed)
          : MenuItemButton(
              leadingIcon: entry.icon,
              onPressed: entry.onPressed,
              child: Text(entry.label),
            ),
    ContextMenuGroup() =>
      isIcon
          ? MenuAnchor(
              menuChildren: entry.children,
              builder: (context, controller, child) =>
                  buildItemWidget(controller.toggle),
            )
          : SubmenuButton(
              menuChildren: entry.children,
              leadingIcon: entry.icon,
              trailingIcon: showCaret
                  ? const PhosphorIcon(PhosphorIconsLight.caretRight)
                  : null,
              menuStyle: const MenuStyle(alignment: Alignment.bottomRight),
              child: Text(entry.label),
            ),
  };
}

Future<T?> showContextMenu<T>({
  required BuildContext context,
  Offset position = Offset.zero,
  required ContextMenuBuilder builder,
  double maxHeight = 400,
  double maxWidth = 300,
}) async {
  final RenderBox box = context.findRenderObject() as RenderBox;
  final Offset globalPos = box.localToGlobal(position);
  AdaptiveTextSelectionToolbar;
  return showModal<T>(
    context: context,
    useRootNavigator: true,
    builder: (context) {
      return ContextMenu(
        position: globalPos,
        builder: builder,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      );
    },
  );
}
