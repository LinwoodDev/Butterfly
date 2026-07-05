part of '../home.dart';

final _personalizationSettingsPage = SettingsLeapPage<ButterflySettings>(
  id: 'personalization',
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
          valueLabel: _themeName,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).design,
          builder: _designSetting,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).locale,
          builder: _localeSetting,
        ),
        SettingsLeapEnumSetting(
          displayName: (context) => AppLocalizations.of(context).platformTheme,
          icon: PhosphorIconsLight.cursor,
          values: PlatformTheme.values,
          read: (state) => state.platformTheme,
          write: (context, value) =>
              context.read<SettingsCubit>().changePlatformTheme(value),
          valueLabel: _platformThemeName,
        ),
        SettingsLeapEnumSetting(
          displayName: (context) => AppLocalizations.of(context).density,
          icon: PhosphorIconsLight.gridNine,
          values: ThemeDensity.values,
          read: (state) => state.density,
          write: (context, value) =>
              context.read<SettingsCubit>().changeDensity(value),
          valueLabel: _densityName,
        ),
        SettingsLeapBoolSetting(
          displayName: (context) => AppLocalizations.of(context).highContrast,
          icon: PhosphorIconsLight.circleHalf,
          read: (state) => state.highContrast,
          write: (context, value) =>
              context.read<SettingsCubit>().changeHighContrast(value),
        ),
        SettingsLeapBoolSetting(
          displayName: (context) => AppLocalizations.of(context).nativeTitleBar,
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

String _themeName(BuildContext context, ThemeMode mode) => switch (mode) {
  ThemeMode.system => AppLocalizations.of(context).systemTheme,
  ThemeMode.light => AppLocalizations.of(context).lightTheme,
  ThemeMode.dark => AppLocalizations.of(context).darkTheme,
};

String _platformThemeName(BuildContext context, PlatformTheme theme) =>
    switch (theme) {
      PlatformTheme.system => AppLocalizations.of(context).systemTheme,
      PlatformTheme.desktop => AppLocalizations.of(context).desktop,
      PlatformTheme.mobile => AppLocalizations.of(context).mobile,
    };

String _localeName(BuildContext context, String locale) => locale.isNotEmpty
    ? LocaleNames.of(context)?.nameOf(locale.replaceAll('-', '_')) ?? locale
    : AppLocalizations.of(context).systemLocale;

String _densityName(BuildContext context, ThemeDensity density) =>
    switch (density) {
      ThemeDensity.system => AppLocalizations.of(context).systemTheme,
      ThemeDensity.maximize => AppLocalizations.of(context).densityMaximize,
      ThemeDensity.desktop => AppLocalizations.of(context).desktop,
      ThemeDensity.compact => AppLocalizations.of(context).compact,
      ThemeDensity.standard => AppLocalizations.of(context).standard,
      ThemeDensity.comfortable => AppLocalizations.of(context).comfortable,
    };

Widget _designSetting(BuildContext context, ButterflySettings state) {
  final design = state.design;
  return ListTile(
    leading: const PhosphorIcon(PhosphorIconsLight.palette),
    title: Text(AppLocalizations.of(context).design),
    subtitle: Text(
      design.isEmpty ? AppLocalizations.of(context).systemTheme : design,
    ),
    trailing: ThemeBox(theme: getThemeData(state.design, false)),
    onTap: () => _openDesignModal(context),
  );
}

Widget _localeSetting(BuildContext context, ButterflySettings state) {
  return ListTile(
    leading: const PhosphorIcon(PhosphorIconsLight.translate),
    title: Text(AppLocalizations.of(context).locale),
    subtitle: Text(_localeName(context, state.localeTag)),
    onTap: () => _openLocaleModal(context),
  );
}

void _openDesignModal(BuildContext context) {
  final cubit = context.read<SettingsCubit>();
  final design = cubit.state.design;
  showLeapBottomSheet(
    context: context,
    titleBuilder: (context) => Text(AppLocalizations.of(context).design),
    childrenBuilder: (context) {
      void changeDesign(String design) {
        cubit.changeDesign(design);
        Navigator.of(context).pop();
      }

      return [
        ListTile(
          title: Text(AppLocalizations.of(context).systemTheme),
          selected: design.isEmpty,
          onTap: () => changeDesign(''),
          leading: ThemeBox(theme: getThemeData('', false)),
        ),
        ...getThemes().map((e) {
          final theme = getThemeData(e, false);
          return ListTile(
            title: Text(e),
            selected: e == design,
            onTap: () => changeDesign(e),
            leading: ThemeBox(theme: theme),
          );
        }),
      ];
    },
  );
}

void _openLocaleModal(BuildContext context) {
  final cubit = context.read<SettingsCubit>();
  final currentLocale = cubit.state.localeTag;
  final locales = getLocales();
  showLeapBottomSheet(
    context: context,
    titleBuilder: (context) => Text(AppLocalizations.of(context).locale),
    childrenBuilder: (context) {
      void changeLocale(Locale? locale) {
        cubit.changeLocale(locale);
        Navigator.of(context).pop();
      }

      return [
        ListTile(
          title: Text(AppLocalizations.of(context).systemLocale),
          selected: currentLocale.isEmpty,
          onTap: () => changeLocale(null),
        ),
        ...locales.map(
          (e) => ListTile(
            title: Text(_localeName(context, e.toLanguageTag())),
            selected: currentLocale == e.toLanguageTag(),
            onTap: () => changeLocale(e),
          ),
        ),
      ];
    },
  );
}
