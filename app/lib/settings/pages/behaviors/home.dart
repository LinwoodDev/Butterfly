part of '../../home.dart';

final _behaviorsSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).behaviors,
  icon: PhosphorIconsLight.faders,
  appBarBuilder: _butterflyAppBar,
  children: {'persistence': _persistenceSettingsPage},
  sections: {
    'behavior': SettingsLeapSection(
      settings: [
        SettingsLeapListSetting<ButterflySettings, _AutosaveMode>(
          id: 'autosave',
          displayName: (context) => AppLocalizations.of(context).autosave,
          icon: PhosphorIconsLight.floppyDisk,
          keywordsBuilder: (context) => [AppLocalizations.of(context).save],
          options: [
            SettingsLeapOption(
              id: 'enabled',
              value: _AutosaveMode.enabled,
              displayName: (context) => AppLocalizations.of(context).yes,
              descriptionBuilder: (context) =>
                  AppLocalizations.of(context).autosaveEnabledDescription,
            ),
            SettingsLeapOption(
              id: 'delayed',
              value: _AutosaveMode.delayed,
              displayName: (context) => AppLocalizations.of(context).delay,
              descriptionBuilder: (context) =>
                  AppLocalizations.of(context).autosaveDelayedDescription,
            ),
            SettingsLeapOption(
              id: 'showSaveButton',
              value: _AutosaveMode.showSaveButton,
              displayName: (context) =>
                  AppLocalizations.of(context).yesButShowButtons,
              descriptionBuilder: (context) =>
                  AppLocalizations.of(context).autosaveShowButtonDescription,
            ),
            SettingsLeapOption(
              id: 'disabled',
              value: _AutosaveMode.disabled,
              displayName: (context) => AppLocalizations.of(context).no,
              descriptionBuilder: (context) =>
                  AppLocalizations.of(context).autosaveDisabledDescription,
            ),
          ],
          read: _readAutosaveMode,
          write: (context, value) => switch (value) {
            _AutosaveMode.enabled =>
              context.read<SettingsCubit>().changeAutosave(true),
            _AutosaveMode.delayed =>
              context.read<SettingsCubit>().changeAutosave(null, delayed: true),
            _AutosaveMode.showSaveButton =>
              context.read<SettingsCubit>().changeAutosave(null),
            _AutosaveMode.disabled =>
              context.read<SettingsCubit>().changeAutosave(false),
          },
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
          valueDescription: (context, value) => switch (value) {
            StartupBehavior.openHomeScreen => AppLocalizations.of(
              context,
            ).onStartupHomeScreenDescription,
            StartupBehavior.openLastNote => AppLocalizations.of(
              context,
            ).onStartupLastNoteDescription,
            StartupBehavior.openNewNote => AppLocalizations.of(
              context,
            ).onStartupNewNoteDescription,
          },
        ),
        SettingsLeapActionSetting(
          displayName: (context) =>
              AppLocalizations.of(context).persistenceDocumentStates,
          hintBuilder: (context) =>
              AppLocalizations.of(context).persistenceDocumentStatesDescription,
          icon: PhosphorIconsLight.database,
          onTap: _openPersistenceSettings,
        ),
        SettingsLeapBoolSetting(
          displayName: (context) =>
              AppLocalizations.of(context).startInFullScreen,
          hintBuilder: (context) =>
              AppLocalizations.of(context).startInFullScreenDescription,
          icon: PhosphorIconsLight.arrowsOut,
          read: (state) => state.startInFullScreen,
          write: (context, value) =>
              context.read<SettingsCubit>().changeStartInFullScreen(value),
        ),
        SettingsLeapListSetting<ButterflySettings, double?>(
          id: 'contentViewport',
          displayName: (context) =>
              AppLocalizations.of(context).contentViewport,
          hintBuilder: (context) =>
              AppLocalizations.of(context).contentViewportDescription,
          icon: PhosphorIconsLight.appWindow,
          options: [
            SettingsLeapOption(
              id: 'off',
              value: null,
              displayName: (context) => AppLocalizations.of(context).off,
            ),
            SettingsLeapOption(
              id: '1x',
              value: 1,
              displayName: (context) => '1x',
            ),
            SettingsLeapOption(
              id: '1.5x',
              value: 1.5,
              displayName: (context) => '1.5x',
            ),
            SettingsLeapOption(
              id: '2x',
              value: 2,
              displayName: (context) => '2x',
            ),
            SettingsLeapOption(
              id: '3x',
              value: 3,
              displayName: (context) => '3x',
            ),
          ],
          read: (state) => state.limitViewportMultiplier,
          write: (context, value) => context
              .read<SettingsCubit>()
              .changeLimitViewportMultiplier(value),
        ),
        SettingsLeapBoolSetting(
          displayName: (context) =>
              AppLocalizations.of(context).limitViewportToPositiveCoordinates,
          hintBuilder: (context) =>
              AppLocalizations.of(context).limitViewportPositiveDescription,
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
          valueDescription: (context, value) => switch (value) {
            RenderResolution.performance => AppLocalizations.of(
              context,
            ).performanceDescription,
            RenderResolution.normal => AppLocalizations.of(
              context,
            ).normalDescription,
            RenderResolution.high => AppLocalizations.of(
              context,
            ).highDescription,
          },
        ),
        SettingsLeapBoolSetting(
          displayName: (context) =>
              AppLocalizations.of(context).bringMovedElementsToFront,
          hintBuilder: (context) =>
              AppLocalizations.of(context).bringMovedElementsToFrontDescription,
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
          hintBuilder: (context) =>
              AppLocalizations.of(context).spreadPagesDescription,
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

enum _AutosaveMode { enabled, delayed, showSaveButton, disabled }

_AutosaveMode _readAutosaveMode(ButterflySettings state) {
  if (!state.autosave) return _AutosaveMode.disabled;
  if (state.delayedAutosave) return _AutosaveMode.delayed;
  if (state.showSaveButton) return _AutosaveMode.showSaveButton;
  return _AutosaveMode.enabled;
}

String _renderResolutionName(BuildContext context, RenderResolution value) =>
    switch (value) {
      RenderResolution.performance => AppLocalizations.of(context).performance,
      RenderResolution.normal => AppLocalizations.of(context).normal,
      RenderResolution.high => AppLocalizations.of(context).high,
    };

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
