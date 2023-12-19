import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubits/settings.dart';

final isWindow =
    !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);

class WindowTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final Widget? title;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final bool onlyShowOnDesktop;
  final bool inView;
  final Color? backgroundColor;
  final double height;
  final double? leadingWidth;

  const WindowTitleBar({
    super.key,
    this.title,
    this.leading,
    this.bottom,
    this.leadingWidth,
    this.backgroundColor,
    this.actions = const [],
    this.onlyShowOnDesktop = false,
    this.inView = false,
    this.height = 70,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.nativeTitleBar != current.nativeTitleBar,
        builder: (context, settings) {
          final isDesktop = isWindow && !kIsWeb;
          if (onlyShowOnDesktop && (!isDesktop || settings.nativeTitleBar)) {
            return const SizedBox.shrink();
          }
          return AppBar(
            title: title,
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: !inView,
            leading: leading,
            bottom: bottom,
            leadingWidth: leadingWidth,
            toolbarHeight: height,
            flexibleSpace: const WindowFreeSpace(),
            actions: [
              ...actions,
              if (isDesktop && !inView)
                WindowButtons(
                  divider: actions.isNotEmpty,
                ),
            ],
          );
        });
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));
}

class WindowFreeSpace extends StatelessWidget {
  const WindowFreeSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.nativeTitleBar != current.nativeTitleBar,
        builder: (context, settings) {
          if (!isWindow || kIsWeb || settings.nativeTitleBar) {
            return const SizedBox.shrink();
          }
          return GestureDetector(
            child: DragToMoveArea(
              child: Container(
                color: Colors.transparent,
              ),
            ),
            onSecondaryTap: () => windowManager.popUpWindowMenu(),
            onLongPress: () => windowManager.popUpWindowMenu(),
          );
        });
  }
}

class WindowButtons extends StatefulWidget {
  final bool divider;

  const WindowButtons({super.key, this.divider = true});

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> with WindowListener {
  bool maximized = false, alwaysOnTop = false;

  @override
  void initState() {
    if (!kIsWeb && isWindow) {
      windowManager.addListener(this);
    }
    super.initState();
    updateStates();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  Future<void> updateStates() async {
    final nextMaximized = await windowManager.isMaximized();
    final nextAlwaysOnTop = await windowManager.isAlwaysOnTop();
    if (mounted) {
      setState(() {
        maximized = nextMaximized;
        alwaysOnTop = nextAlwaysOnTop;
      });
    }
  }

  @override
  void onWindowUnmaximize() => setState(() => maximized = false);

  @override
  void onWindowMaximize() => setState(() => maximized = true);

  @override
  void onWindowEnterFullScreen() =>
      context.read<SettingsCubit>().setFullScreen(true, false);

  @override
  void onWindowLeaveFullScreen() =>
      context.read<SettingsCubit>().setFullScreen(false, false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.nativeTitleBar != current.nativeTitleBar ||
            previous.fullScreen != current.fullScreen,
        builder: (context, settings) {
          if (!kIsWeb && isWindow && !settings.nativeTitleBar) {
            return LayoutBuilder(
              builder: (context, constraints) => Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 42),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.divider) const VerticalDivider(),
                        Row(
                          children: [
                            if (!settings.fullScreen) ...[
                              IconButton(
                                icon: const PhosphorIcon(
                                    PhosphorIconsLight.minus),
                                tooltip: AppLocalizations.of(context).minimize,
                                splashRadius: 20,
                                onPressed: () => windowManager.minimize(),
                              ),
                              const SizedBox(width: 8),
                              MenuAnchor(
                                builder: (context, controller, child) =>
                                    GestureDetector(
                                  child: IconButton(
                                    tooltip: maximized
                                        ? AppLocalizations.of(context).restore
                                        : AppLocalizations.of(context).maximize,
                                    icon: PhosphorIcon(
                                      PhosphorIconsLight.square,
                                      size: maximized ? 14 : 20,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    onPressed: () async =>
                                        await windowManager.isMaximized()
                                            ? windowManager.unmaximize()
                                            : windowManager.maximize(),
                                  ),
                                  onLongPress: () async {
                                    if (controller.isOpen) {
                                      controller.close();
                                    } else {
                                      controller.open();
                                    }
                                  },
                                  onSecondaryTap: () async {
                                    if (controller.isOpen) {
                                      controller.close();
                                    } else {
                                      controller.open();
                                    }
                                  },
                                ),
                                menuChildren: [
                                  MenuItemButton(
                                    leadingIcon: PhosphorIcon(alwaysOnTop
                                        ? PhosphorIconsFill.pushPin
                                        : PhosphorIconsLight.pushPin),
                                    child: Text(alwaysOnTop
                                        ? AppLocalizations.of(context)
                                            .exitAlwaysOnTop
                                        : AppLocalizations.of(context)
                                            .alwaysOnTop),
                                    onPressed: () async {
                                      await windowManager
                                          .setAlwaysOnTop(!alwaysOnTop);
                                      setState(
                                          () => alwaysOnTop = !alwaysOnTop);
                                    },
                                  ),
                                  MenuItemButton(
                                    leadingIcon: PhosphorIcon(
                                        settings.fullScreen
                                            ? PhosphorIconsLight.arrowsIn
                                            : PhosphorIconsLight.arrowsOut),
                                    child: Text(settings.fullScreen
                                        ? AppLocalizations.of(context)
                                            .exitFullScreen
                                        : AppLocalizations.of(context)
                                            .enterFullScreen),
                                    onPressed: () async {
                                      context
                                          .read<SettingsCubit>()
                                          .toggleFullScreen();
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme:
                                      Theme.of(context).colorScheme.copyWith(
                                            secondaryContainer:
                                                Colors.red.withOpacity(0.2),
                                          ),
                                ),
                                child: IconButton.filledTonal(
                                  icon:
                                      const PhosphorIcon(PhosphorIconsLight.x),
                                  tooltip: AppLocalizations.of(context).close,
                                  color: Colors.red,
                                  splashRadius: 20,
                                  onPressed: () => windowManager.close(),
                                ),
                              )
                            ]
                          ]
                              .map((e) => e is SizedBox
                                  ? e
                                  : AspectRatio(aspectRatio: 1, child: e))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
