part of 'page.dart';

PhosphorIconData _getIconOfBannerVisibility(BannerVisibility visibility) =>
    switch (visibility) {
      BannerVisibility.always => PhosphorIconsLight.caretDown,
      BannerVisibility.never => PhosphorIconsLight.caretUp,
      BannerVisibility.onlyOnUpdates => PhosphorIconsLight.caretRight,
    };

String _getLocalizedNameOfBannerVisibility(
  BuildContext context,
  BannerVisibility visibility,
) => switch (visibility) {
  BannerVisibility.always => AppLocalizations.of(context).always,
  BannerVisibility.never => AppLocalizations.of(context).never,
  BannerVisibility.onlyOnUpdates => AppLocalizations.of(context).onlyOnUpdates,
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
    final actions = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
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
          context,
          context.read<SettingsCubit>().state,
        ),
      ],
    );
    final style = FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
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
          SizedBox(
            height: 0,
            child: PhosphorIcon(
              PhosphorIconsLight.caretUp,
              color: ColorScheme.of(context).onPrimary,
            ),
          ),
      ],
    );
    final logo = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        Image.asset(logoAsset, width: 64),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context).welcome(applicationVersionName),
                style: TextTheme.of(
                  context,
                ).titleLarge?.copyWith(color: colorScheme.onSecondary),
                overflow: TextOverflow.clip,
              ),
              Text(
                AppLocalizations.of(context).welcomeContent,
                style: TextTheme.of(
                  context,
                ).bodySmall?.copyWith(color: colorScheme.onSecondary),
              ),
            ],
          ),
        ),
      ],
    );
    final innerCard = LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < LeapBreakpoints.compact;
        if (isMobile) {
          return Column(children: [logo, const SizedBox(height: 16), whatsNew]);
        }
        return Row(
          children: [
            Expanded(child: logo),
            whatsNew,
          ],
        );
      },
    );
    final card = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colorScheme.secondary, colorScheme.primary],
            stops: const [0.2, 0.8],
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [card, const SizedBox(height: 32), actions],
          );
    return SizeTransition(
      sizeFactor: _animation,
      child: Column(
        children: [
          const SizedBox(height: 64),
          child,
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
