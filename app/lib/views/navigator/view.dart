import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/navigator/areas.dart';
import 'package:butterfly/views/navigator/components.dart';
import 'package:butterfly/views/files/view.dart';
import 'package:butterfly/views/navigator/waypoints.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  (List<String>, String?) _getHelp() => switch (this) {
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
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.navigatorEnabled != current.navigatorEnabled ||
            previous.navigatorPage != current.navigatorPage,
        builder: (context, settings) {
          final selected = NavigatorPage.values.indexOf(settings.navigatorPage);
          if (settings.navigatorEnabled) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
          return Row(
            textDirection: TextDirection.rtl,
            children: [
              SizeTransition(
                sizeFactor: _animation,
                axis: Axis.horizontal,
                axisAlignment: 1,
                child: const SizedBox(
                  width: drawerWidth,
                  child: Card(child: DocumentNavigator(asDrawer: false)),
                ),
              ),
              NavigationRail(
                minWidth: 110,
                destinations: NavigatorPage.values
                    .map(
                      (e) => NavigationRailDestination(
                        icon: PhosphorIcon(e.icon(PhosphorIconsStyle.light)),
                        label: Text(
                          e.getLocalizedName(context),
                        ),
                      ),
                    )
                    .toList(),
                labelType: NavigationRailLabelType.all,
                selectedIndex: settings.navigatorEnabled ? selected : null,
                onDestinationSelected: (index) {
                  final cubit = context.read<SettingsCubit>();
                  if (selected == index) {
                    cubit.changeNavigatorEnabled(!settings.navigatorEnabled);
                    return;
                  }
                  cubit.setNavigatorPage(NavigatorPage.values[index]);
                  cubit.changeNavigatorEnabled(true);
                },
              ),
            ],
          );
        });
  }
}

class DocumentNavigator extends StatefulWidget {
  final bool asDrawer;
  const DocumentNavigator({
    super.key,
    this.asDrawer = false,
  });

  @override
  State<DocumentNavigator> createState() => _DocumentNavigatorState();
}

class _DocumentNavigatorState extends State<DocumentNavigator>
    with SingleTickerProviderStateMixin {
  ExternalStorage? _remote;

  @override
  void initState() {
    super.initState();
    _remote = context.read<SettingsCubit>().getRemote();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      buildWhen: (previous, current) =>
          previous.navigatorPage != current.navigatorPage,
      builder: (context, settings) {
        final page = settings.navigatorPage;
        return BlocBuilder<DocumentBloc, DocumentState>(
          buildWhen: (previous, current) =>
              (previous is DocumentLoadSuccess &&
                  current is! DocumentLoadSuccess) ||
              (previous is! DocumentLoadSuccess &&
                  current is DocumentLoadSuccess) ||
              (current is DocumentLoaded &&
                  previous is DocumentLoaded &&
                  current.location != previous.location),
          builder: (context, state) {
            AssetLocation? location;
            if (state is DocumentLoaded) {
              location = state.location;
            }
            final body = switch (page) {
              NavigatorPage.waypoints => const WaypointsView(),
              NavigatorPage.areas => const AreasView(),
              NavigatorPage.layers => const LayersView(),
              NavigatorPage.pages => const PagesView(),
              NavigatorPage.files => SingleChildScrollView(
                  child: FilesView(
                    remote: _remote,
                    selectedAsset: location,
                    onRemoteChanged: (remote) {
                      setState(() {
                        _remote = remote;
                      });
                    },
                    collapsed: true,
                  ),
                ),
              NavigatorPage.components => const ComponentsView(),
            };
            final content = Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Header(
                    leading: widget.asDrawer
                        ? IconButton(
                            icon:
                                const PhosphorIcon(PhosphorIconsLight.xCircle),
                            onPressed: () => Navigator.of(context).pop(),
                            tooltip: AppLocalizations.of(context).close,
                          )
                        : null,
                    title: Text(page.getLocalizedName(context)),
                    actions: [
                      IconButton(
                        icon:
                            const PhosphorIcon(PhosphorIconsLight.sealQuestion),
                        onPressed: () {
                          final help = page._getHelp();
                          openHelp(help.$1, help.$2);
                        },
                        tooltip: AppLocalizations.of(context).help,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(child: body),
                ],
              ),
            );
            if (widget.asDrawer) {
              return Drawer(
                width: 400,
                child: content,
              );
            } else {
              return content;
            }
          },
        );
      },
    );
  }
}
