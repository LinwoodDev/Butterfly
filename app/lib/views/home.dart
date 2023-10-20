import 'dart:typed_data';

import 'package:butterfly/actions/settings.dart';
import 'package:butterfly/api/file_system/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/widgets/window.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../api/open_release_notes.dart';
import '../main.dart';
import 'files.dart';

PhosphorIconData _getIconOfBannerVisibility(BannerVisibility visibility) =>
    switch (visibility) {
      BannerVisibility.always => PhosphorIconsLight.caretDown,
      BannerVisibility.never => PhosphorIconsLight.caretUp,
      BannerVisibility.onlyOnUpdates => PhosphorIconsLight.caretRight,
    };

String _getLocalizedNameOfBannerVisibility(
        BuildContext context, BannerVisibility visibility) =>
    switch (visibility) {
      BannerVisibility.always => AppLocalizations.of(context).always,
      BannerVisibility.never => AppLocalizations.of(context).never,
      BannerVisibility.onlyOnUpdates =>
        AppLocalizations.of(context).onlyOnUpdates,
    };

Widget _getBannerVisibilityWidget(
    BuildContext context, ButterflySettings settings) {
  return MenuAnchor(
    builder: (context, controller, child) => IconButton(
      tooltip: AppLocalizations.of(context).visibility,
      icon: PhosphorIcon(_getIconOfBannerVisibility(settings.bannerVisibility)),
      onPressed: () =>
          controller.isOpen ? controller.close() : controller.open(),
    ),
    menuChildren: BannerVisibility.values
        .map(
          (e) => MenuItemButton(
            leadingIcon: Icon(
              _getIconOfBannerVisibility(e),
            ),
            onPressed: () {
              context.read<SettingsCubit>().changeBannerVisibility(e);
            },
            child: Text(_getLocalizedNameOfBannerVisibility(context, e)),
          ),
        )
        .toList(),
  );
}

class HomePage extends StatefulWidget {
  final AssetLocation? selectedAsset;

  const HomePage({super.key, this.selectedAsset});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RemoteStorage? _remote;

  @override
  void initState() {
    super.initState();
    _remote = context.read<SettingsCubit>().state.getDefaultRemote();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DocumentFileSystem>.value(
            value: DocumentFileSystem.fromPlatform(remote: _remote)),
        RepositoryProvider<TemplateFileSystem>.value(
            value: TemplateFileSystem.fromPlatform(remote: _remote)),
        RepositoryProvider<PackFileSystem>.value(
            value: PackFileSystem.fromPlatform(remote: _remote)),
        RepositoryProvider<ImportService>(
            create: (context) => ImportService(context)),
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
              final quickStart = _QuickstartHomeView(
                remote: _remote,
                onReload: () => setState(() {}),
              );
              return Scaffold(
                appBar: WindowTitleBar(
                  title: const Text(shortApplicationName),
                  onlyShowOnDesktop: showBanner,
                  actions: [
                    if (!showBanner) ...[
                      _getBannerVisibilityWidget(context, settings),
                      IconButton(
                        icon: const PhosphorIcon(PhosphorIconsLight.gear),
                        tooltip: AppLocalizations.of(context).settings,
                        onPressed: () => openSettings(context),
                      ),
                    ],
                  ],
                ),
                body: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 64),
                          LayoutBuilder(builder: (context, constraints) {
                            final isDesktop = constraints.maxWidth > 1000;
                            return _HeaderHomeView(
                              hasNewerVersion: hasNewerVersion,
                              isDesktop: isDesktop,
                              showBanner: showBanner,
                            );
                          }),
                          const SizedBox(height: 64),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth > 1000) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: FilesView(
                                      selectedAsset: widget.selectedAsset,
                                      remote: _remote,
                                      isMobile: false,
                                      onRemoteChanged: (value) =>
                                          setState(() => _remote = value),
                                    )),
                                    const SizedBox(width: 32),
                                    SizedBox(
                                      width: 500,
                                      child: quickStart,
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    quickStart,
                                    const SizedBox(height: 32),
                                    FilesView(
                                      selectedAsset: widget.selectedAsset,
                                      remote: _remote,
                                      isMobile: true,
                                      onRemoteChanged: (value) =>
                                          setState(() => _remote = value),
                                    ),
                                  ],
                                );
                              }
                            },
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

class _HeaderHomeView extends StatefulWidget {
  final bool hasNewerVersion, isDesktop, showBanner;
  const _HeaderHomeView({
    this.hasNewerVersion = false,
    required this.isDesktop,
    required this.showBanner,
  });

  @override
  State<_HeaderHomeView> createState() => _HeaderHomeViewState();
}

class _HeaderHomeViewState extends State<_HeaderHomeView>
    with TickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;
  late final SettingsCubit _settingsCubit;

  @override
  void initState() {
    super.initState();
    _settingsCubit = context.read<SettingsCubit>();
    prepareAnimations();
  }

  void prepareAnimations() {
    final expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: widget.showBanner ? 1 : 0,
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void didUpdateWidget(_HeaderHomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showBanner) {
      expandController.forward(
          from: oldWidget.isDesktop != widget.isDesktop ? 0 : null);
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final actions = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton.icon(
          onPressed: () => openHelp(['intro']),
          icon: const PhosphorIcon(PhosphorIconsLight.bookOpen),
          label: Text(AppLocalizations.of(context).documentation),
        ),
        IconButton(
          onPressed: () => openSettings(context),
          icon: const PhosphorIcon(PhosphorIconsLight.gear),
          tooltip: AppLocalizations.of(context).settings,
        ),
        _getBannerVisibilityWidget(
            context, context.read<SettingsCubit>().state),
      ],
    );
    final style = FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 20,
      ),
      textStyle: const TextStyle(fontSize: 20),
    );
    void openNew() {
      openReleaseNotes();
      _settingsCubit.updateLastVersion();
    }

    final whatsNew = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.hasNewerVersion
            ? FilledButton(
                onPressed: openNew,
                style: style,
                child: Text(AppLocalizations.of(context).whatsNew),
              )
            : ElevatedButton(
                onPressed: openNew,
                style: style,
                child: Text(AppLocalizations.of(context).whatsNew),
              ),
        if (widget.hasNewerVersion)
          const SizedBox(
            height: 0,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: PhosphorIcon(PhosphorIconsLight.caretUp),
                ),
              ],
            ),
          ),
      ],
    );
    final logo = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'images/logo.png',
          width: 64,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).welcome,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colorScheme.onInverseSurface,
                    ),
                overflow: TextOverflow.clip,
              ),
              Text(
                AppLocalizations.of(context).welcomeContent,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onInverseSurface,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
    final innerCard = widget.isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: logo),
              const SizedBox(width: 32),
              whatsNew,
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              logo,
              const SizedBox(height: 32),
              whatsNew,
            ],
          );
    final card = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.alphaBlend(colorScheme.inverseSurface.withOpacity(0.3),
                  colorScheme.surface),
              colorScheme.primary,
            ],
            stops: const [0, 0.8],
          ),
        ),
        child: innerCard,
      ),
    );
    final child = widget.isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: card),
              const SizedBox(width: 32),
              actions,
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              card,
              const SizedBox(height: 32),
              actions,
            ],
          );
    return SizeTransition(
      sizeFactor: animation,
      child: child,
    );
  }
}

class _QuickstartHomeView extends StatefulWidget {
  final RemoteStorage? remote;
  final VoidCallback onReload;

  const _QuickstartHomeView({
    this.remote,
    required this.onReload,
  });

  @override
  State<_QuickstartHomeView> createState() => _QuickstartHomeViewState();
}

class _QuickstartHomeViewState extends State<_QuickstartHomeView> {
  late final TemplateFileSystem _templateFileSystem;
  Future<List<NoteData>>? _templatesFuture;

  @override
  void initState() {
    _templateFileSystem =
        TemplateFileSystem.fromPlatform(remote: widget.remote);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _templatesFuture = _fetchTemplates();
        }));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _QuickstartHomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remote != widget.remote) {
      setState(() {
        _templatesFuture = _fetchTemplates();
      });
    }
  }

  Future<List<NoteData>> _fetchTemplates() => _templateFileSystem
      .createDefault(context)
      .then((value) => _templateFileSystem.getTemplates());

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            AppLocalizations.of(context).quickstart,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<NoteData>>(
              future: _templatesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return ElevatedButton(
                    child: Text(AppLocalizations.of(context).view),
                    onPressed: () => setState(() {
                      _templatesFuture = _fetchTemplates();
                    }),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
                final templates = snapshot.data ?? [];
                if (templates.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).noTemplates,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () async {
                          await _templateFileSystem.createDefault(context,
                              force: true);
                          setState(() {
                            _templatesFuture = _fetchTemplates();
                          });
                          widget.onReload();
                        },
                        child: Text(
                          AppLocalizations.of(context).reset,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  );
                }
                return Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 16,
                  spacing: 16,
                  children: templates.map(
                    (e) {
                      final thumbnail = e.getThumbnail();
                      final metadata = e.getMetadata()!;
                      return AssetCard(
                        metadata: metadata,
                        thumbnail: thumbnail,
                        onTap: () async {
                          GoRouter.of(context).pushReplacementNamed('new',
                              queryParameters: {'path': metadata.directory},
                              extra: e.createDocument().save());
                        },
                      );
                    },
                  ).toList(),
                );
              }),
        ]),
      ),
    );
  }
}

class AssetCard extends StatelessWidget {
  const AssetCard({
    super.key,
    required this.metadata,
    required this.thumbnail,
    required this.onTap,
  });

  final FileMetadata metadata;
  final Uint8List? thumbnail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Card(
            elevation: 5,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: onTap,
              child: Stack(
                children: [
                  if (thumbnail?.isNotEmpty ?? false)
                    Align(
                      child: Image.memory(
                        thumbnail!,
                        fit: BoxFit.cover,
                        width: 640,
                        alignment: Alignment.center,
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colorScheme.primaryContainer.withAlpha(200),
                      ),
                      child: Text(
                        metadata.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
