part of 'page.dart';

PhosphorIconData _getIconOfBannerVisibility(BannerVisibility visibility) =>
    switch (visibility) {
      .always => PhosphorIconsLight.caretDown,
      .never => PhosphorIconsLight.caretUp,
      .onlyOnUpdates => PhosphorIconsLight.caretRight,
    };

String _getLocalizedNameOfBannerVisibility(
  BuildContext context,
  BannerVisibility visibility,
) => switch (visibility) {
  .always => AppLocalizations.of(context).always,
  .never => AppLocalizations.of(context).never,
  .onlyOnUpdates => AppLocalizations.of(context).onlyOnUpdates,
};

Widget _getBannerVisibilityWidget(
  BuildContext context,
  ButterflySettings settings,
) {
  return MenuAnchor(
    builder: defaultMenuButton(
      tooltip: AppLocalizations.of(context).visibility,
      icon: PhosphorIcon(_getIconOfBannerVisibility(settings.bannerVisibility)),
    ),
    menuChildren: BannerVisibility.values
        .map(
          (e) => MenuItemButton(
            leadingIcon: Icon(_getIconOfBannerVisibility(e)),
            onPressed: () {
              context.read<SettingsCubit>().changeBannerVisibility(e);
            },
            child: Text(_getLocalizedNameOfBannerVisibility(context, e)),
          ),
        )
        .toList(),
  );
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
  late final AnimationController _expandController;
  late final Animation<double> _animation;
  late final SettingsCubit _settingsCubit;

  @override
  void initState() {
    super.initState();
    _settingsCubit = context.read<SettingsCubit>();
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: widget.showBanner ? 1 : 0,
    );
    _animation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void didUpdateWidget(_HeaderHomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showBanner) {
      _expandController.forward(
        from: oldWidget.isDesktop != widget.isDesktop ? 0 : null,
      );
    } else {
      _expandController.reverse();
    }
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final l10n = AppLocalizations.of(context);
    void openNew() {
      openReleaseNotes();
      _settingsCubit.updateLastVersion();
    }

    // One calm row: who we are on the left, the few things you might want to
    // do on the right. No gradient banner competing with your files.
    final whatsNew = Badge(
      isLabelVisible: widget.hasNewerVersion,
      smallSize: 10,
      backgroundColor: colorScheme.primary,
      child: FilledButton.tonalIcon(
        onPressed: openNew,
        icon: const PhosphorIcon(PhosphorIconsLight.shootingStar),
        label: Text(l10n.whatsNew),
      ),
    );
    final actions = Row(
      mainAxisSize: .min,
      spacing: 4,
      children: [
        whatsNew,
        const SizedBox(width: 4),
        IconButton(
          onPressed: () => openHelp(['intro']),
          icon: const PhosphorIcon(PhosphorIconsLight.bookOpen),
          tooltip: l10n.documentation,
        ),
        IconButton(
          onPressed: () => openSettings(context),
          icon: const PhosphorIcon(PhosphorIconsLight.gear),
          tooltip: l10n.settings,
        ),
        _getBannerVisibilityWidget(
          context,
          context.read<SettingsCubit>().state,
        ),
      ],
    );
    final greeting = Row(
      mainAxisSize: .min,
      spacing: 16,
      children: [
        Image.asset(logoAsset, width: 48),
        Flexible(
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Text(
                l10n.welcome(applicationVersionName),
                style: TextTheme.of(context).headlineSmall
                    ?.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.welcomeContent,
                style: TextTheme.of(context).bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
    final child = LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < LeapBreakpoints.medium) {
          return Column(
            crossAxisAlignment: .start,
            spacing: 16,
            children: [greeting, actions],
          );
        }
        return Row(
          children: [
            Expanded(
              child: Align(alignment: Alignment.centerLeft, child: greeting),
            ),
            const SizedBox(width: 16),
            actions,
          ],
        );
      },
    );
    return SizeTransition(
      sizeFactor: _animation,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 24),
        child: child,
      ),
    );
  }
}
