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
            previous.nativeWindowTitleBar != current.nativeWindowTitleBar,
        builder: (context, settings) {
          final isDesktop = isWindow && !kIsWeb;
          if (onlyShowOnDesktop && !isDesktop) return const SizedBox.shrink();
          final appBar = AppBar(
            title: title,
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: !inView,
            leading: leading,
            bottom: bottom,
            leadingWidth: leadingWidth,
            toolbarHeight: height,
            actions: [
              ...actions,
              if (isDesktop && !inView)
                WindowButtons(
                  divider: actions.isNotEmpty,
                ),
            ],
          );
          if (isDesktop && !settings.nativeWindowTitleBar) {
            return GestureDetector(
              child: DragToMoveArea(
                child: appBar,
              ),
              onSecondaryTap: () => windowManager.popUpWindowMenu(),
              onLongPress: () => windowManager.popUpWindowMenu(),
            );
          }
          return appBar;
        });
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class WindowButtons extends StatefulWidget {
  final bool divider;

  const WindowButtons({super.key, this.divider = true});

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> with WindowListener {
  bool maximized = false, alwaysOnTop = false, fullScreen = false;

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
    final nextFullScreen = await windowManager.isFullScreen();
    if (mounted) {
      setState(() {
        maximized = nextMaximized;
        alwaysOnTop = nextAlwaysOnTop;
        fullScreen = nextFullScreen;
      });
    }
  }

  @override
  void onWindowUnmaximize() {
    setState(() => maximized = false);
  }

  @override
  void onWindowMaximize() {
    setState(() => maximized = true);
  }

  @override
  void onWindowEnterFullScreen() {
    setState(() => fullScreen = true);
  }

  @override
  void onWindowLeaveFullScreen() {
    setState(() => fullScreen = false);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.nativeWindowTitleBar != current.nativeWindowTitleBar,
        builder: (context, settings) {
          if (!kIsWeb && isWindow && !settings.nativeWindowTitleBar) {
            return LayoutBuilder(
              builder: (context, constraints) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 42),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.divider) const VerticalDivider(),
                        Builder(builder: (context) {
                          return Row(
                            children: [
                              if (!fullScreen) ...[
                                IconButton(
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.minus),
                                  tooltip:
                                      AppLocalizations.of(context).minimize,
                                  splashRadius: 20,
                                  onPressed: () => windowManager.minimize(),
                                ),
                                MenuAnchor(
                                  builder: (context, controller, child) =>
                                      TextButton(
                                    child: Tooltip(
                                      message: maximized
                                          ? AppLocalizations.of(context).restore
                                          : AppLocalizations.of(context)
                                              .maximize,
                                      child: PhosphorIcon(
                                        PhosphorIconsLight.square,
                                        size: maximized ? 14 : 20,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                    ),
                                    onPressed: () async =>
                                        await windowManager.isMaximized()
                                            ? windowManager.unmaximize()
                                            : windowManager.maximize(),
                                    onLongPress: () async {
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
                                      leadingIcon: PhosphorIcon(fullScreen
                                          ? PhosphorIconsLight.arrowsIn
                                          : PhosphorIconsLight.arrowsOut),
                                      child: Text(fullScreen
                                          ? AppLocalizations.of(context)
                                              .exitFullScreen
                                          : AppLocalizations.of(context)
                                              .enterFullScreen),
                                      onPressed: () async {
                                        setState(
                                            () => fullScreen = !fullScreen);
                                        await windowManager
                                            .setFullScreen(fullScreen);
                                      },
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon:
                                      const PhosphorIcon(PhosphorIconsLight.x),
                                  tooltip: AppLocalizations.of(context).close,
                                  color: Colors.red,
                                  splashRadius: 20,
                                  onPressed: () => windowManager.close(),
                                )
                              ]
                            ]
                                .map((e) =>
                                    AspectRatio(aspectRatio: 1, child: e))
                                .toList(),
                          );
                        })
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
