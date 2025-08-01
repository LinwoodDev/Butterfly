import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/navigator/areas.dart';
import 'package:butterfly/views/navigator/components.dart';
import 'package:butterfly/views/navigator/files.dart';
import 'package:butterfly/views/navigator/waypoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'layers.dart';
import 'pages.dart';

const drawerWidth = 350.0;

enum NavigatorPage {
  waypoints,
  areas,
  layers,
  pages,
  components,
  files;

  String getLocalizedName(BuildContext context) => switch (this) {
    NavigatorPage.waypoints => AppLocalizations.of(context).waypoints,
    NavigatorPage.areas => AppLocalizations.of(context).areas,
    NavigatorPage.layers => AppLocalizations.of(context).layers,
    NavigatorPage.pages => AppLocalizations.of(context).pages,
    NavigatorPage.files => AppLocalizations.of(context).files,
    NavigatorPage.components => AppLocalizations.of(context).components,
  };

  (List<String>, String?) getHelp() => switch (this) {
    NavigatorPage.waypoints => (['waypoints'], null),
    NavigatorPage.areas => (['areas'], null),
    NavigatorPage.layers => (['layers'], null),
    NavigatorPage.pages => (['pages'], null),
    NavigatorPage.files => (['storage'], null),
    NavigatorPage.components => (['pack'], 'components'),
  };

  IconGetter get icon => switch (this) {
    NavigatorPage.waypoints => PhosphorIcons.mapPin,
    NavigatorPage.areas => PhosphorIcons.monitor,
    NavigatorPage.layers => PhosphorIcons.stack,
    NavigatorPage.pages => PhosphorIcons.book,
    NavigatorPage.files => PhosphorIcons.file,
    NavigatorPage.components => PhosphorIcons.cube,
  };
}

class NavigatorView extends StatefulWidget {
  const NavigatorView({super.key});

  @override
  State<NavigatorView> createState() => _NavigatorViewState();
}

const kNavigationRailWidth = 110.0;

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
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      buildWhen: (previous, current) =>
          previous.navigatorPosition != current.navigatorPosition,
      builder: (context, settings) =>
          BlocBuilder<CurrentIndexCubit, CurrentIndex>(
            buildWhen: (previous, current) =>
                previous.navigatorEnabled != current.navigatorEnabled ||
                previous.navigatorPage != current.navigatorPage,
            builder: (context, currentIndex) {
              final selected = NavigatorPage.values.indexOf(
                currentIndex.navigatorPage,
              );
              if (currentIndex.navigatorEnabled) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              return Row(
                textDirection:
                    settings.navigatorPosition == NavigatorPosition.left
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                mainAxisAlignment:
                    settings.navigatorPosition == NavigatorPosition.left
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  SizeTransition(
                    sizeFactor: _animation,
                    axis: Axis.horizontal,
                    axisAlignment: 1,
                    child: AnimatedBuilder(
                      animation: _animation,
                      child: SizedBox(
                        width: drawerWidth,
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
                  LayoutBuilder(
                    builder: (context, constraint) => SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraint.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: NavigationRail(
                            minWidth: kNavigationRailWidth,
                            destinations: NavigatorPage.values
                                .map(
                                  (e) => NavigationRailDestination(
                                    icon: PhosphorIcon(
                                      e.icon(PhosphorIconsStyle.light),
                                    ),
                                    label: Text(e.getLocalizedName(context)),
                                  ),
                                )
                                .toList(),
                            selectedIndex: currentIndex.navigatorEnabled
                                ? selected
                                : null,
                            groupAlignment: 0,
                            onDestinationSelected: (index) {
                              final cubit = context.read<CurrentIndexCubit>();
                              if (selected == index) {
                                cubit.setNavigatorEnabled(
                                  !currentIndex.navigatorEnabled,
                                );
                                return;
                              }
                              cubit.setNavigatorPage(
                                NavigatorPage.values[index],
                              );
                              cubit.setNavigatorEnabled(true);
                            },
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
    return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
      buildWhen: (previous, current) =>
          previous.navigatorPage != current.navigatorPage,
      builder: (context, currentIndex) {
        final page = currentIndex.navigatorPage;
        final body = switch (page) {
          NavigatorPage.waypoints => const WaypointsView(),
          NavigatorPage.areas => const AreasView(),
          NavigatorPage.layers => const LayersView(),
          NavigatorPage.pages => const PagesView(),
          NavigatorPage.files => const FilesNavigatorPage(),
          NavigatorPage.components => const ComponentsView(),
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
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).closeButtonTooltip,
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
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
