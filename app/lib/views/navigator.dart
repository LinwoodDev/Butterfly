import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/components.dart';
import 'package:butterfly/views/files.dart';
import 'package:butterfly/views/waypoints.dart';
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
  layers,
  pages,
  files,
  components;

  String getLocalizedName(BuildContext context) => switch (this) {
        NavigatorPage.waypoints => AppLocalizations.of(context).waypoints,
        NavigatorPage.layers => AppLocalizations.of(context).layers,
        NavigatorPage.pages => AppLocalizations.of(context).pages,
        NavigatorPage.files => AppLocalizations.of(context).files,
        NavigatorPage.components => AppLocalizations.of(context).components,
      };

  IconGetter get icon => switch (this) {
        NavigatorPage.waypoints => PhosphorIcons.mapPin,
        NavigatorPage.layers => PhosphorIcons.stack,
        NavigatorPage.pages => PhosphorIcons.book,
        NavigatorPage.files => PhosphorIcons.file,
        NavigatorPage.components => PhosphorIcons.cube,
      };
}

class NavigatorView extends StatelessWidget {
  const NavigatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.navigatorEnabled != current.navigatorEnabled ||
            previous.navigatorPage != current.navigatorPage,
        builder: (context, settings) {
          final selected = NavigatorPage.values.indexOf(settings.navigatorPage);
          return Row(
            children: [
              Column(
                children: [
                  Expanded(
                    child: NavigationRail(
                      minWidth: 110,
                      destinations: NavigatorPage.values
                          .map(
                            (e) => NavigationRailDestination(
                              icon: PhosphorIcon(
                                  e.icon(PhosphorIconsStyle.light)),
                              label: Text(
                                e.getLocalizedName(context),
                              ),
                            ),
                          )
                          .toList(),
                      labelType: NavigationRailLabelType.all,
                      selectedIndex:
                          settings.navigatorEnabled ? selected : null,
                      onDestinationSelected: (index) {
                        final cubit = context.read<SettingsCubit>();
                        if (selected == index) {
                          cubit.changeNavigatorEnabled(
                              !settings.navigatorEnabled);
                          return;
                        }
                        cubit.setNavigatorPage(NavigatorPage.values[index]);
                        cubit.changeNavigatorEnabled(true);
                      },
                    ),
                  ),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                width: settings.navigatorEnabled ? drawerWidth : 0,
                child: const ClipRect(
                  child: OverflowBox(
                    minWidth: drawerWidth,
                    maxWidth: drawerWidth,
                    child: Card(child: DocumentNavigator(asDrawer: false)),
                  ),
                ),
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
  RemoteStorage? _remote;

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
                    actions: [
                      if (widget.asDrawer)
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.x),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                    ],
                    title: Text(page.getLocalizedName(context)),
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
