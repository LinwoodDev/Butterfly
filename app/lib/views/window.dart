import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubits/settings.dart';

bool isWindow() =>
    !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);

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
    if (!kIsWeb && isWindow()) {
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
          if (!kIsWeb && isWindow() && !settings.nativeWindowTitleBar) {
            return LayoutBuilder(
              builder: (context, constraints) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 42),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.divider) const VerticalDivider(),
                      ...[
                        if (!fullScreen)
                          IconButton(
                            icon: Icon(alwaysOnTop
                                ? PhosphorIcons.pushPinFill
                                : PhosphorIcons.pushPinLight),
                            tooltip: alwaysOnTop
                                ? AppLocalizations.of(context)!.exitAlwaysOnTop
                                : AppLocalizations.of(context)!.alwaysOnTop,
                            onPressed: () async {
                              await windowManager.setAlwaysOnTop(!alwaysOnTop);
                              setState(() => alwaysOnTop = !alwaysOnTop);
                            },
                          ),
                        IconButton(
                          icon: Icon(fullScreen
                              ? PhosphorIcons.arrowsInLight
                              : PhosphorIcons.arrowsOutLight),
                          tooltip: fullScreen
                              ? AppLocalizations.of(context)!.exitFullScreen
                              : AppLocalizations.of(context)!.enterFullScreen,
                          onPressed: () async {
                            setState(() => fullScreen = !fullScreen);
                            await windowManager.setFullScreen(fullScreen);
                          },
                        ),
                        if (!fullScreen) ...[
                          const VerticalDivider(),
                          IconButton(
                            icon: const Icon(PhosphorIcons.minusLight),
                            tooltip: AppLocalizations.of(context)!.minimize,
                            splashRadius: 20,
                            onPressed: () => windowManager.minimize(),
                          ),
                          IconButton(
                            icon: Icon(PhosphorIcons.squareLight,
                                size: maximized ? 14 : 20),
                            tooltip: maximized
                                ? AppLocalizations.of(context)!.restore
                                : AppLocalizations.of(context)!.maximize,
                            splashRadius: 20,
                            onPressed: () async =>
                                await windowManager.isMaximized()
                                    ? windowManager.unmaximize()
                                    : windowManager.maximize(),
                          ),
                          IconButton(
                            icon: const Icon(PhosphorIcons.xLight),
                            tooltip: AppLocalizations.of(context)!.close,
                            hoverColor: Colors.red,
                            splashRadius: 20,
                            onPressed: () => windowManager.close(),
                          )
                        ]
                      ].map((e) => AspectRatio(aspectRatio: 1, child: e))
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
