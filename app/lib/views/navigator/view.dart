import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/navigator/areas.dart';
import 'package:butterfly/views/navigator/components.dart';
import 'package:butterfly/views/navigator/files.dart';
import 'package:butterfly/views/navigator/waypoints.dart';
import 'package:flutter/material.dart';
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
  const NavigatorView({super.key});

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
    final embedded = context.select<DocumentSaveCubit, bool>(
      (cubit) => cubit.state.embedding != null,
    );
    final pages = NavigatorPage.values
        .where((page) => !embedded || page != .files)
        .toList();
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      buildWhen: (previous, current) =>
          previous.navigatorPosition != current.navigatorPosition,
      builder: (context, settings) =>
          BlocBuilder<EditorViewCubit, EditorViewState>(
            buildWhen: (previous, current) =>
                previous.navigatorEnabled != current.navigatorEnabled ||
                previous.navigatorPage != current.navigatorPage,
            builder: (context, viewState) {
              final selected = pages.indexOf(viewState.navigatorPage);
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
                        child: Card(child: DocumentNavigator(asDialog: false)),
                      ),
                      builder: (context, child) {
                        if (_animation.value == 0) {
                          return const SizedBox();
                        }
                        return child!;
                      },
                    ),
                  ),
                  NavigationRail(
                    scrollable: true,
                    minWidth: kNavigationRailWidth,
                    destinations: pages
                        .map(
                          (e) => NavigationRailDestination(
                            icon: PhosphorIcon(e.icon()),
                            label: Text(e.getLocalizedName(context)),
                          ),
                        )
                        .toList(),
                    selectedIndex: viewState.navigatorEnabled
                        ? selected < 0
                              ? 0
                              : selected
                        : null,
                    groupAlignment: 0,
                    onDestinationSelected: (index) {
                      final cubit = context.read<EditorViewCubit>();
                      if (selected == index) {
                        cubit.setNavigator(
                          enabled: !viewState.navigatorEnabled,
                        );
                        return;
                      }
                      cubit.setNavigator(page: pages[index], enabled: true);
                    },
                  ),
                ],
              );
            },
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
    final embedded = context.select<DocumentSaveCubit, bool>(
      (cubit) => cubit.state.embedding != null,
    );
    return BlocBuilder<EditorViewCubit, EditorViewState>(
      buildWhen: (previous, current) =>
          previous.navigatorPage != current.navigatorPage,
      builder: (context, viewState) {
        final page = embedded && viewState.navigatorPage == .files
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
                ? IconButton.outlined(
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
