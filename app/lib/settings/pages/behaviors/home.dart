part of '../../home.dart';

final _behaviorsSettingsPage = SettingsLeapPage<ButterflySettings>(
  id: 'behaviors',
  displayName: (context) => AppLocalizations.of(context).behaviors,
  icon: PhosphorIconsLight.faders,
  appBarBuilder: _butterflyAppBar,
  children: {'persistence': _persistenceSettingsPage},
  sections: {
    'behavior': SettingsLeapSection(
      settings: [
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).autosave,
          keywordsBuilder: (context) => [AppLocalizations.of(context).save],
          builder: _autosaveSetting,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).autosaveDelay,
          enabled: (context, state) => state.autosave && state.delayedAutosave,
          builder: _autosaveDelaySetting,
        ),
        SettingsLeapEnumSetting(
          displayName: (context) => AppLocalizations.of(context).onStartup,
          icon: PhosphorIconsLight.arrowFatLineUp,
          values: StartupBehavior.values,
          read: (state) => state.onStartup,
          write: (context, value) =>
              context.read<SettingsCubit>().changeStartupBehavior(value),
          valueLabel: _startupBehaviorName,
        ),
        SettingsLeapActionSetting(
          displayName: (context) =>
              AppLocalizations.of(context).persistenceDocumentStates,
          icon: PhosphorIconsLight.database,
          onTap: _openPersistenceSettings,
        ),
        SettingsLeapBoolSetting(
          displayName: (context) =>
              AppLocalizations.of(context).startInFullScreen,
          icon: PhosphorIconsLight.arrowsOut,
          read: (state) => state.startInFullScreen,
          write: (context, value) =>
              context.read<SettingsCubit>().changeStartInFullScreen(value),
        ),
        SettingsLeapCustomSetting(
          displayName: (context) =>
              AppLocalizations.of(context).contentViewport,
          builder: _contentViewportSetting,
        ),
        SettingsLeapBoolSetting(
          displayName: (context) =>
              AppLocalizations.of(context).limitViewportToPositiveCoordinates,
          icon: PhosphorIconsLight.plusSquare,
          read: (state) => state.limitViewportPositive,
          write: (context, value) =>
              context.read<SettingsCubit>().changeLimitViewportPositive(value),
        ),
        SettingsLeapEnumSetting(
          displayName: (context) =>
              AppLocalizations.of(context).renderResolution,
          icon: PhosphorIconsLight.sparkle,
          values: RenderResolution.values,
          read: (state) => state.renderResolution,
          write: (context, value) =>
              context.read<SettingsCubit>().changeRenderResolution(value),
          valueLabel: _renderResolutionName,
        ),
        SettingsLeapBoolSetting(
          displayName: (context) =>
              AppLocalizations.of(context).bringMovedElementsToFront,
          icon: PhosphorIconsLight.stack,
          read: (state) => state.bringMovedElementsToFront,
          write: (context, value) => context
              .read<SettingsCubit>()
              .changeBringMovedElementsToFront(value),
        ),
      ],
    ),
    'import': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).import,
      settings: [
        SettingsLeapBoolSetting(
          displayName: (context) => AppLocalizations.of(context).spreadToPages,
          icon: PhosphorIconsLight.arrowsOutSimple,
          read: (state) => state.spreadPages,
          write: (context, value) =>
              context.read<SettingsCubit>().changeSpreadPages(value),
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).imageScale,
          builder: _imageScaleSetting,
        ),
      ],
    ),
  },
);

String _renderResolutionName(BuildContext context, RenderResolution value) =>
    switch (value) {
      RenderResolution.performance => AppLocalizations.of(context).performance,
      RenderResolution.normal => AppLocalizations.of(context).normal,
      RenderResolution.high => AppLocalizations.of(context).high,
    };

Widget _autosaveSetting(BuildContext context, ButterflySettings state) {
  return ListTile(
    title: Text(AppLocalizations.of(context).autosave),
    leading: const PhosphorIcon(PhosphorIconsLight.floppyDisk),
    subtitle: Text(
      state.autosave
          ? state.delayedAutosave
                ? AppLocalizations.of(context).delay
                : state.showSaveButton
                ? AppLocalizations.of(context).yesButShowButtons
                : AppLocalizations.of(context).yes
          : AppLocalizations.of(context).no,
    ),
    onTap: () => _openAutosaveModal(context),
  );
}

Widget _autosaveDelaySetting(BuildContext context, ButterflySettings state) {
  return ExactSlider(
    leading: const PhosphorIcon(PhosphorIconsLight.clock),
    header: Text(AppLocalizations.of(context).autosaveDelay),
    value: state.autosaveDelaySeconds.toDouble(),
    min: 1,
    max: 10,
    defaultValue: 3,
    fractionDigits: 0,
    onChangeEnd: (value) =>
        context.read<SettingsCubit>().changeAutosaveDelaySeconds(value.toInt()),
  );
}
