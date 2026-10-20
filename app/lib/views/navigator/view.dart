import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/theme.dart';
import 'package:butterfly/views/navigator/areas.dart';
import 'package:butterfly/views/navigator/components.dart';
import 'package:butterfly/views/navigator/files.dart';
import 'package:butterfly/views/navigator/waypoints.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'constants.dart';
import 'layers.dart';
import 'pages.dart';

enum NavigatorPage {
  waypoints,
  areas,
  layers,
  pages,
  components,
  files;

  String getLocalizedName(BuildContext context) => switch (this) {
    .waypoints => AppLocalizations.of(context).waypoints,
    .areas => AppLocalizations.of(context).areas,
    .layers => AppLocalizations.of(context).layers,
    .pages => AppLocalizations.of(context).pages,
    .files => AppLocalizations.of(context).files,
    .components => AppLocalizations.of(context).components,
  };

  (List<String>, String?) getHelp() => switch (this) {
    .waypoints => (['waypoints'], null),
    .areas => (['areas'], null),
    .layers => (['layers'], null),
    .pages => (['pages'], null),
    .files => (['storage'], null),
    .components => (['pack'], 'components'),
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    .waypoints => filled ? PhosphorIconsFill.mapPin : PhosphorIconsLight.mapPin,
    .areas => filled ? PhosphorIconsFill.monitor : PhosphorIconsLight.monitor,
    .layers => filled ? PhosphorIconsFill.stack : PhosphorIconsLight.stack,
    .pages => filled ? PhosphorIconsFill.book : PhosphorIconsLight.book,
    .files => filled ? PhosphorIconsFill.file : PhosphorIconsLight.file,
    .components => filled ? PhosphorIconsFill.cube : PhosphorIconsLight.cube,
  };
}

class NavigatorView extends StatefulWidget {
  final bool floating;

  const NavigatorView({super.key, this.floating = false});

  @override
  State<NavigatorView> createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Files are switched from the title in the top bar, not from the rail.
    final pages = NavigatorPage.values.where((page) => page != .files).toList();
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      buildWhen: (previous, current) =>
          previous.navigatorPosition != current.navigatorPosition,
      builder: (context, settings) =>
          BlocBuilder<EditorViewCubit, EditorViewState>(
            buildWhen: (previous, current) =>
                previous.navigatorEnabled != current.navigatorEnabled ||
                previous.navigatorPage != current.navigatorPage,
            builder: (context, viewState) {
              final selected = pages.indexOf(
                viewState.navigatorPage == .files
                    ? NavigatorPage.waypoints
                    : viewState.navigatorPage,
              );
              if (viewState.navigatorEnabled) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              return Row(
                textDirection: settings.navigatorPosition == .left
                    ? TextDirection.rtl
                    : .ltr,
                mainAxisAlignment: settings.navigatorPosition == .left
                    ? MainAxisAlignment.start
                    : .end,
                children: [
                  SizeTransition(
                    sizeFactor: _animation,
                    axis: .horizontal,
                    alignment: Alignment.centerLeft,
                    child: AnimatedBuilder(
                      animation: _animation,
                      child: SizedBox(
                        width: kNavigatorDrawerWidth,
                        child: Island(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.zero,
                          child: DocumentNavigator(asDialog: false),
                        ),
                      ),
                      builder: (context, child) {
                        if (_animation.value == 0) {
                          return const SizedBox();
                        }
                        return child!;
                      },
                    ),
                  ),
                  // The rail floats as a slim island but keeps the
                  // reserved width of kNavigationRailWidth.
                  SizedBox(
                    width: kNavigationRailWidth,
                    child: Center(
                      child: Island(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(4),
                        radius: kRadiusPill,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 4,
                            children: [
                              for (final (index, page) in pages.indexed)
                                _NavigatorRailButton(
                                  page: page,
                                  selected:
                                      viewState.navigatorEnabled &&
                                      index == selected,
                                  onPressed: () {
                                    final cubit = context
                                        .read<EditorViewCubit>();
                                    if (selected == index) {
                                      cubit.setNavigator(
                                        enabled: !viewState.navigatorEnabled,
                                      );
                                      return;
                                    }
                                    cubit.setNavigator(
                                      page: page,
                                      enabled: true,
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }
}

class _NavigatorRailButton extends StatelessWidget {
  final NavigatorPage page;
  final bool selected;
  final VoidCallback onPressed;

  const _NavigatorRailButton({
    required this.page,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return IconButton(
      tooltip: page.getLocalizedName(context),
      isSelected: selected,
      onPressed: onPressed,
      icon: PhosphorIcon(page.icon()),
      selectedIcon: PhosphorIcon(page.icon(filled: true)),
      style: IconButton.styleFrom(
        fixedSize: const Size.square(44),
        foregroundColor: selected
            ? colorScheme.onSecondaryContainer
            : colorScheme.onSurfaceVariant,
        backgroundColor: selected ? colorScheme.secondaryContainer : null,
      ),
    );
  }
}

class DocumentNavigator extends StatefulWidget {
  final bool asDialog;

  const DocumentNavigator({super.key, this.asDialog = false});

  @override
  State<DocumentNavigator> createState() => _DocumentNavigatorState();
}

class _DocumentNavigatorState extends State<DocumentNavigator>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorViewCubit, EditorViewState>(
      buildWhen: (previous, current) =>
          previous.navigatorPage != current.navigatorPage,
      builder: (context, viewState) {
        // Files live in the title's file switcher, fall back for old states.
        final page = viewState.navigatorPage == .files
            ? NavigatorPage.waypoints
            : viewState.navigatorPage;
        final body = switch (page) {
          .waypoints => const WaypointsView(),
          .areas => const AreasView(),
          .layers => const LayersView(),
          .pages => const PagesView(),
          .files => const FilesNavigatorPage(),
          .components => const ComponentsView(),
        };
        final content = Scaffold(
          key: ValueKey(('navigator', page)),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            leading: widget.asDialog
                ? IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.x),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: MaterialLocalizations.of(context)
                        .closeButtonTooltip,
                  )
                : null,
            automaticallyImplyLeading: false,
            title: Text(page.getLocalizedName(context)),
            actions: [
              IconButton(
                icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
                onPressed: () {
                  final help = page.getHelp();
                  openHelp(help.$1, help.$2);
                },
                tooltip: AppLocalizations.of(context).help,
              ),
            ],
          ),
          body: SafeArea(
            child: Align(alignment: Alignment.topCenter, child: body),
          ),
        );
        if (widget.asDialog) {
          return Dialog.fullscreen(child: content);
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: content,
        );
      },
    );
  }
}
