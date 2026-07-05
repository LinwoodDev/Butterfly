part of '../home.dart';

final _personalizationSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).personalization,
  icon: PhosphorIconsLight.monitor,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'content': SettingsLeapSection(
      settings: [
        SettingsLeapEnumSetting(
          displayName: (context) => AppLocalizations.of(context).theme,
          icon: PhosphorIconsLight.eye,
          values: ThemeMode.values,
          read: (state) => state.theme,
          write: (context, value) =>
              context.read<SettingsCubit>().changeTheme(value, context),
          valueLabel: (context, value) => switch (value) {
            ThemeMode.system => AppLocalizations.of(context).systemTheme,
            ThemeMode.light => AppLocalizations.of(context).lightTheme,
            ThemeMode.dark => AppLocalizations.of(context).darkTheme,
          },
        ),
        SettingsLeapListSetting<ButterflySettings, String>(
          id: 'design',
          displayName: (context) => AppLocalizations.of(context).design,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).designDescription,
          icon: PhosphorIconsLight.palette,
          options: [
            SettingsLeapOption(
              id: 'system',
              value: '',
              displayName: (context) =>
                  AppLocalizations.of(context).systemTheme,
            ),
            for (final theme in getThemes())
              SettingsLeapOption(
                id: theme,
                value: theme,
                displayName: (context) => theme,
              ),
          ],
          read: (state) => state.design,
          write: (context, value) =>
              context.read<SettingsCubit>().changeDesign(value),
        ),
        SettingsLeapListSetting<ButterflySettings, String>(
          id: 'locale',
          displayName: (context) => AppLocalizations.of(context).locale,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).localeDescription,
          icon: PhosphorIconsLight.translate,
          options: [
            SettingsLeapOption(
              id: 'system',
              value: '',
              displayName: (context) =>
                  AppLocalizations.of(context).systemLocale,
            ),
            for (final locale in getLocales())
              SettingsLeapOption(
                id: locale.toLanguageTag(),
                value: locale.toLanguageTag(),
                displayName: (context) =>
                    _localeName(context, locale.toLanguageTag()),
              ),
          ],
          read: (state) => state.localeTag,
          write: (context, value) {
            final locale = value.isEmpty
                ? null
                : getLocales()
                      .where((e) => e.toLanguageTag() == value)
                      .firstOrNull;
            context.read<SettingsCubit>().changeLocale(locale);
          },
        ),
        SettingsLeapEnumSetting(
          displayName: (context) => AppLocalizations.of(context).platformTheme,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).platformThemeDescription,
          icon: PhosphorIconsLight.cursor,
          values: PlatformTheme.values,
          read: (state) => state.platformTheme,
          write: (context, value) =>
              context.read<SettingsCubit>().changePlatformTheme(value),
          valueLabel: (context, value) => switch (value) {
            PlatformTheme.system => AppLocalizations.of(context).systemTheme,
            PlatformTheme.desktop => AppLocalizations.of(context).desktop,
            PlatformTheme.mobile => AppLocalizations.of(context).mobile,
          },
        ),
        SettingsLeapEnumSetting(
          displayName: (context) => AppLocalizations.of(context).density,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).densityDescription,
          icon: PhosphorIconsLight.gridNine,
          values: ThemeDensity.values,
          read: (state) => state.density,
          write: (context, value) =>
              context.read<SettingsCubit>().changeDensity(value),
          valueLabel: (context, value) => switch (value) {
            ThemeDensity.system => AppLocalizations.of(context).systemTheme,
            ThemeDensity.maximize => AppLocalizations.of(
              context,
            ).densityMaximize,
            ThemeDensity.desktop => AppLocalizations.of(context).desktop,
            ThemeDensity.compact => AppLocalizations.of(context).compact,
            ThemeDensity.standard => AppLocalizations.of(context).standard,
            ThemeDensity.comfortable => AppLocalizations.of(
              context,
            ).comfortable,
          },
        ),
        SettingsLeapBoolSetting(
          displayName: (context) => AppLocalizations.of(context).highContrast,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).highContrastDescription,
          icon: PhosphorIconsLight.circleHalf,
          read: (state) => state.highContrast,
          write: (context, value) =>
              context.read<SettingsCubit>().changeHighContrast(value),
        ),
        SettingsLeapBoolSetting(
          displayName: (context) => AppLocalizations.of(context).nativeTitleBar,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).nativeTitleBarDescription,
          icon: PhosphorIconsLight.appWindow,
          enabled: (context, state) => !kIsWeb && isWindow,
          read: (state) => state.nativeTitleBar,
          write: (context, value) =>
              context.read<SettingsCubit>().changeNativeTitleBar(value),
        ),
      ],
    ),
  },
);

String _localeName(BuildContext context, String locale) => locale.isNotEmpty
    ? LocaleNames.of(context)?.nameOf(locale.replaceAll('-', '_')) ?? locale
    : AppLocalizations.of(context).systemLocale;
