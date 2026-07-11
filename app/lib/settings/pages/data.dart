part of '../home.dart';

final _dataSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).data,
  icon: PhosphorIconsLight.database,
  appBarBuilder: _butterflyAppBar,
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
      ],
    ),
  },
);
