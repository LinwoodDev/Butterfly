import 'package:butterfly/actions/new.dart';
import 'package:butterfly/actions/settings.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/template.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/settings/home.dart';
import 'package:butterfly/views/files/card.dart';
import 'package:butterfly/views/files/recently.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../main.dart';
import '../files/view.dart';

part 'start.dart';
part 'header.dart';

class HomePage extends StatefulWidget {
  final AssetLocation? selectedAsset;

  const HomePage({super.key, this.selectedAsset});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum _MobileTab { home, files, settings }

class _HomePageState extends State<HomePage> {
  final GlobalKey<FilesViewState> _filesViewKey = GlobalKey();
  ExternalStorage? _remote;
  _MobileTab _tab = _MobileTab.home;
  late ImportService _importService;

  @override
  void initState() {
    super.initState();
    _remote = context.read<SettingsCubit>().state.getDefaultRemote();
    _importService = ImportService(context);
  }

  void updateRemote(ExternalStorage? remote) {
    setState(() {
      _remote = remote;
      _importService = ImportService(
        context,
        storage: _remote,
        useDefaultStorage: false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = size.width > LeapBreakpoints.expanded;
    final isMobile = size.width < LeapBreakpoints.compact;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ImportService>.value(value: _importService),
      ],
      child: BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.bannerVisibility != current.bannerVisibility,
        builder: (context, settings) {
          return FutureBuilder<bool>(
            future: context.read<SettingsCubit>().hasNewerVersion(),
            builder: (context, snapshot) {
              final hasNewerVersion = snapshot.data ?? false;
              final showBanner =
                  settings.bannerVisibility == BannerVisibility.always ||
                  (settings.bannerVisibility ==
                          BannerVisibility.onlyOnUpdates &&
                      hasNewerVersion);
              final appBar = WindowTitleBar<SettingsCubit, ButterflySettings>(
                title: isMobile || !showBanner
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(shortApplicationName),
                          Text(
                            applicationVersionName,
                            style: TextTheme.of(context).labelMedium,
                          ),
                        ],
                      )
                    : Text(applicationName),
                onlyShowOnDesktop: showBanner && isDesktop,
                actions: [
                  if (isMobile || !showBanner) ...[
                    if (isMobile)
                      IconButton(
                        icon: const PhosphorIcon(
                          PhosphorIconsLight.shootingStar,
                        ),
                        selectedIcon: const PhosphorIcon(
                          PhosphorIconsFill.shootingStar,
                        ),
                        tooltip: AppLocalizations.of(context).whatsNew,
                        isSelected: hasNewerVersion,
                        onPressed: () {
                          openReleaseNotes();
                          context.read<SettingsCubit>().updateLastVersion();
                        },
                      ),
                    IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.bookOpen),
                      tooltip: AppLocalizations.of(context).documentation,
                      onPressed: () => openHelp(['intro']),
                    ),
                    if (!isMobile)
                      IconButton(
                        icon: const PhosphorIcon(PhosphorIconsLight.gear),
                        tooltip: AppLocalizations.of(context).settings,
                        onPressed: () => openSettings(context),
                      ),
                    if (!isMobile)
                      _getBannerVisibilityWidget(context, settings),
                  ],
                ],
              );
              return Scaffold(
                appBar: isMobile ? null : appBar,
                bottomNavigationBar: isMobile
                    ? NavigationBar(
                        destinations: [
                          NavigationDestination(
                            icon: const Icon(PhosphorIconsLight.house),
                            selectedIcon: const Icon(PhosphorIconsFill.house),
                            label: AppLocalizations.of(context).home,
                          ),
                          NavigationDestination(
                            icon: const Icon(PhosphorIconsLight.folder),
                            selectedIcon: const Icon(PhosphorIconsFill.folder),
                            label: AppLocalizations.of(context).files,
                          ),
                          NavigationDestination(
                            icon: const Icon(PhosphorIconsLight.gear),
                            selectedIcon: const Icon(PhosphorIconsFill.gear),
                            label: AppLocalizations.of(context).settings,
                          ),
                        ],
                        onDestinationSelected: (index) {
                          setState(() {
                            _tab = _MobileTab.values[index];
                          });
                        },
                        selectedIndex: _tab.index,
                      )
                    : null,
                body: isMobile
                    ? DefaultTabController(
                        length: 1,
                        child: switch (_tab) {
                          _MobileTab.home => Scaffold(
                            appBar: appBar,
                            body: ListView(
                              children: [
                                _QuickstartHomeView(
                                  remote: _remote,
                                  isMobile: true,
                                  onReload: () => setState(
                                    () => _filesViewKey.currentState
                                        ?.reloadFileSystem(),
                                  ),
                                ),
                                RecentFilesView(replace: false, asGrid: true),
                              ],
                            ),
                          ),
                          _MobileTab.files => FilesView(
                            activeAsset: widget.selectedAsset,
                            remote: _remote,
                            isMobile: true,
                            isPage: true,
                            key: _filesViewKey,
                            onRemoteChanged: (value) => updateRemote(value),
                          ),
                          _MobileTab.settings => SettingsPage(),
                        },
                      )
                    : SingleChildScrollView(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            constraints: const BoxConstraints(maxWidth: 1400),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _HeaderHomeView(
                                  hasNewerVersion: hasNewerVersion,
                                  isDesktop: isDesktop,
                                  showBanner: showBanner,
                                ),
                                const SizedBox(height: 16),
                                if (isDesktop)
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: FilesView(
                                          activeAsset: widget.selectedAsset,
                                          remote: _remote,
                                          isMobile: false,
                                          key: _filesViewKey,
                                          onRemoteChanged: (value) =>
                                              updateRemote(value),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      SizedBox(
                                        width: 350,
                                        child: _QuickstartHomeView(
                                          remote: _remote,
                                          isMobile: false,
                                          onReload: () => setState(
                                            () => _filesViewKey.currentState
                                                ?.reloadFileSystem(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Column(
                                    children: [
                                      _QuickstartHomeView(
                                        remote: _remote,
                                        isMobile: true,
                                        onReload: () => setState(
                                          () => _filesViewKey.currentState
                                              ?.reloadFileSystem(),
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      FilesView(
                                        activeAsset: widget.selectedAsset,
                                        remote: _remote,
                                        isMobile: true,
                                        key: _filesViewKey,
                                        onRemoteChanged: (value) =>
                                            updateRemote(value),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
