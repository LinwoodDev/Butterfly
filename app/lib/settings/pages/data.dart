part of '../home.dart';

final _dataSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).data,
  icon: PhosphorIconsLight.database,
  appBarBuilder: _butterflyAppBar,
  onReset: (context, state) => _resetSettingsPage(
    context,
    (current, defaults) => current.copyWith(
      syncMode: defaults.syncMode,
      documentPath: defaults.documentPath,
      defaultFileName: defaults.defaultFileName,
    ),
  ),
  sections: {
    'storage': SettingsLeapSection(
      settings: [
        SettingsLeapEnumSetting(
          displayName: (context) => AppLocalizations.of(context).syncMode,
          icon: PhosphorIconsLight.cloudArrowDown,
          enabled: (context, state) => !kIsWeb,
          values: SyncMode.values,
          read: (state) => state.syncMode,
          write: (context, value) =>
              context.read<SettingsCubit>().changeSyncMode(value),
          valueLabel: (context, value) => value.getLocalizedName(context),
          valueDescription: (context, value) => switch (value) {
            SyncMode.always => AppLocalizations.of(
              context,
            ).syncModeAlwaysDescription,
            SyncMode.noMobile => AppLocalizations.of(
              context,
            ).syncModeNoMobileDescription,
            SyncMode.manual => AppLocalizations.of(
              context,
            ).syncModeManualDescription,
          },
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).dataDirectory,
          enabled: (context, state) => !kIsWeb,
          builder: buildDataDirectorySetting,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) =>
              AppLocalizations.of(context).defaultFileName,
          builder: buildDefaultFileNameSetting,
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).templates,
          icon: PhosphorIconsLight.file,
          onTap: openTemplatesDialog,
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).packs,
          icon: PhosphorIconsLight.package,
          onTap: openPacksDialog,
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).exportAllFiles,
          icon: PhosphorIconsLight.export,
          onTap: exportData,
        ),
      ],
    ),
    'settings': SettingsLeapSection(
      settings: [
        SettingsLeapActionSetting(
          displayName: (context) =>
              AppLocalizations.of(context).restoreSettingsFromFile,
          icon: PhosphorIconsLight.arrowSquareIn,
          onTap: importSettings,
        ),
        SettingsLeapActionSetting(
          displayName: (context) =>
              AppLocalizations.of(context).exportSettingsToFile,
          icon: PhosphorIconsLight.arrowSquareOut,
          onTap: exportSettings,
        ),
        SettingsLeapActionSetting(
          displayName: (context) =>
              AppLocalizations.of(context).resetAllSettings,
          icon: PhosphorIconsLight.clockCounterClockwise,
          onTap: _resetAllSettings,
        ),
      ],
    ),
  },
);

Future<void> _resetAllSettings(BuildContext context) async {
  final localizations = AppLocalizations.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(localizations.resetAllSettings),
      content: Text(localizations.reallyReset),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(LeapLocalizations.of(context).reset),
        ),
      ],
    ),
  );
  if (confirmed == true && context.mounted) {
    await Future.wait([
      context.read<SettingsCubit>().resetAllSettings(),
      keybinder.resetToDefaults(),
    ]);
  }
}
