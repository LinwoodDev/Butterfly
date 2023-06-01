import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
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

class DocumentNavigator extends StatefulWidget {
  final bool asDrawer;
  const DocumentNavigator({super.key, this.asDrawer = false});

  @override
  State<DocumentNavigator> createState() => _DocumentNavigatorState();
}

class _DocumentNavigatorState extends State<DocumentNavigator>
    with SingleTickerProviderStateMixin {
  RemoteStorage? _remote;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
    value: 0,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    super.initState();
    _remote = context.read<SettingsCubit>().getRemote();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      buildWhen: (previous, current) =>
          previous.navigatorEnabled != current.navigatorEnabled,
      builder: (context, settings) {
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
            Widget content;
            if (!settings.navigatorEnabled && !widget.asDrawer ||
                state is! DocumentLoadSuccess) {
              content = const SizedBox.shrink();
              _controller.reverse(from: 1);
            } else {
              _controller.forward(from: 0);
              content = DefaultTabController(
                length: 4,
                initialIndex: context.read<SettingsCubit>().state.navigatorTab,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Header(
                        actions: [
                          IconButton(
                            icon: const PhosphorIcon(PhosphorIconsLight.x),
                            onPressed: () {
                              if (widget.asDrawer) {
                                Navigator.of(context).pop();
                                return;
                              }
                              context
                                  .read<SettingsCubit>()
                                  .changeNavigatorEnabled(false);
                            },
                          ),
                        ],
                        title: Text(AppLocalizations.of(context).navigator),
                      ),
                      TabBar(
                        isScrollable: true,
                        onTap: context.read<SettingsCubit>().setNavigatorTab,
                        tabs: [
                          (
                            PhosphorIconsLight.mapPin,
                            AppLocalizations.of(context).waypoints
                          ),
                          (
                            PhosphorIconsLight.stack,
                            AppLocalizations.of(context).layers
                          ),
                          (
                            PhosphorIconsLight.book,
                            AppLocalizations.of(context).pages
                          ),
                          (
                            PhosphorIconsLight.file,
                            AppLocalizations.of(context).files
                          ),
                        ]
                            .map((e) => Tab(
                                    child: Row(
                                  children: [
                                    PhosphorIcon(e.$1),
                                    const SizedBox(width: 8),
                                    Text(e.$2),
                                  ],
                                )))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: TabBarView(children: [
                          const WaypointsView(),
                          const LayersView(),
                          const PagesView(),
                          SingleChildScrollView(
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
                        ]),
                      )
                    ],
                  ),
                ),
              );
            }
            if (widget.asDrawer) {
              return Drawer(
                width: 400,
                child: content,
              );
            } else {
              return AnimatedBuilder(
                animation: _animation,
                child: content,
                builder: (context, child) {
                  if (_animation.value == 0) return const SizedBox.shrink();
                  return SizedBox(
                    width: 400,
                    child: ClipRect(
                      child: Transform.translate(
                        offset: Offset(-400 * (1 - _animation.value), 0),
                        child: OverflowBox(
                            maxWidth: double.infinity,
                            child: SizedBox(width: 400, child: child)),
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
