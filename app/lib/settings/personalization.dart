import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/main.dart';
import 'package:butterfly/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PersonalizationSettingsPage extends StatelessWidget {
  final bool inView;
  const PersonalizationSettingsPage({super.key, this.inView = false});

  String _getThemeName(BuildContext context, ThemeMode mode) => switch (mode) {
    ThemeMode.system => AppLocalizations.of(context).systemTheme,
    ThemeMode.light => AppLocalizations.of(context).lightTheme,
    ThemeMode.dark => AppLocalizations.of(context).darkTheme,
  };

  String _getPlatformThemeName(BuildContext context, PlatformTheme theme) =>
      switch (theme) {
        PlatformTheme.system => AppLocalizations.of(context).systemTheme,
        PlatformTheme.desktop => AppLocalizations.of(context).desktop,
        PlatformTheme.mobile => AppLocalizations.of(context).mobile,
      };

  String _getLocaleName(BuildContext context, String locale) =>
      locale.isNotEmpty
      ? LocaleNames.of(context)?.nameOf(locale.replaceAll('-', '_')) ?? locale
      : AppLocalizations.of(context).systemLocale;

  String _getDensityName(BuildContext context, ThemeDensity density) =>
      switch (density) {
        ThemeDensity.system => AppLocalizations.of(context).systemTheme,
        ThemeDensity.maximize => LeapLocalizations.of(context).maximize,
        ThemeDensity.desktop => AppLocalizations.of(context).desktop,
        ThemeDensity.compact => AppLocalizations.of(context).compact,
        ThemeDensity.standard => AppLocalizations.of(context).standard,
        ThemeDensity.comfortable => AppLocalizations.of(context).comfortable,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        inView: inView,
        backgroundColor: inView ? Colors.transparent : null,
        title: Text(AppLocalizations.of(context).personalization),
      ),
      body: BlocBuilder<SettingsCubit, ButterflySettings>(
        builder: (context, state) {
          final design = state.design;
          return ListView(
            children: [
              Card(
                margin: settingsCardMargin,
                child: Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.eye),
                        title: Text(AppLocalizations.of(context).theme),
                        subtitle: Text(_getThemeName(context, state.theme)),
                        onTap: () => _openThemeModal(context),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.palette),
                        title: Text(AppLocalizations.of(context).design),
                        subtitle: Text(
                          design.isEmpty
                              ? AppLocalizations.of(context).systemTheme
                              : design.toDisplayString(),
                        ),
                        trailing: ThemeBox(
                          theme: getThemeData(state.design, false),
                        ),
                        onTap: () => _openDesignModal(context),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.translate,
                        ),
                        title: Text(AppLocalizations.of(context).locale),
                        subtitle: Text(
                          _getLocaleName(context, state.localeTag),
                        ),
                        onTap: () => _openLocaleModal(context),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.cursor),
                        title: Text(AppLocalizations.of(context).platformTheme),
                        subtitle: Text(
                          _getPlatformThemeName(context, state.platformTheme),
                        ),
                        onTap: () => _openPlatformThemeModal(context),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.gridNine,
                        ),
                        title: Text(AppLocalizations.of(context).density),
                        subtitle: Text(_getDensityName(context, state.density)),
                        onTap: () => _openDensityModal(context),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.toolbox),
                        title: Text(AppLocalizations.of(context).toolbarSize),
                        subtitle: Text(
                          state.toolbarSize.getLocalizedName(context),
                        ),
                        onTap: () => _openToolbarSizeModal(context),
                      ),
                      SwitchListTile(
                        secondary: const PhosphorIcon(
                          PhosphorIconsLight.circleHalf,
                        ),
                        title: Text(AppLocalizations.of(context).highContrast),
                        value: state.highContrast,
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeHighContrast(value),
                      ),
                      if (!kIsWeb && isWindow)
                        SwitchListTile(
                          value: state.nativeTitleBar,
                          title: Text(
                            AppLocalizations.of(context).nativeTitleBar,
                          ),
                          secondary: const PhosphorIcon(
                            PhosphorIconsLight.appWindow,
                          ),
                          onChanged: (value) => context
                              .read<SettingsCubit>()
                              .changeNativeTitleBar(value),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openDensityModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final density = cubit.state.density;

    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).density),
      childrenBuilder: (context) {
        void changeDensity(ThemeDensity density) {
          cubit.changeDensity(density);
          Navigator.of(context).pop();
        }

        return ThemeDensity.values
            .map(
              (e) => ListTile(
                title: Text(_getDensityName(context, e)),
                selected: e == density,
                onTap: () => changeDensity(e),
              ),
            )
            .toList();
      },
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
              title: Text(e.toDisplayString()),
              selected: e == design,
              onTap: () => changeDesign(e),
              leading: ThemeBox(theme: theme),
            );
          }),
        ];
      },
    );
  }

  void _openThemeModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final currentTheme = cubit.state.theme;

    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).theme),
      childrenBuilder: (context) {
        void changeTheme(ThemeMode themeMode) {
          cubit.changeTheme(themeMode, MediaQuery.of(context));
          Navigator.of(context).pop();
        }

        return [
          ListTile(
            title: Text(AppLocalizations.of(context).systemTheme),
            selected: currentTheme == ThemeMode.system,
            leading: const PhosphorIcon(PhosphorIconsLight.power),
            onTap: () => changeTheme(ThemeMode.system),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).lightTheme),
            selected: currentTheme == ThemeMode.light,
            leading: const PhosphorIcon(PhosphorIconsLight.sun),
            onTap: () => changeTheme(ThemeMode.light),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).darkTheme),
            selected: currentTheme == ThemeMode.dark,
            leading: const PhosphorIcon(PhosphorIconsLight.moon),
            onTap: () => changeTheme(ThemeMode.dark),
          ),
        ];
      },
    );
  }

  void _openLocaleModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentLocale = cubit.state.localeTag;
    var locales = getLocales();
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
              title: Text(_getLocaleName(context, e.toLanguageTag())),
              selected: currentLocale == e.toLanguageTag(),
              onTap: () => changeLocale(e),
            ),
          ),
        ];
      },
    );
  }

  void _openPlatformThemeModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentTheme = cubit.state.platformTheme;
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) =>
          Text(AppLocalizations.of(context).platformTheme),
      childrenBuilder: (context) => PlatformTheme.values
          .map(
            (e) => ListTile(
              title: Text(_getPlatformThemeName(context, e)),
              leading: PhosphorIcon(switch (e) {
                PlatformTheme.system => PhosphorIconsLight.power,
                PlatformTheme.desktop => PhosphorIconsLight.desktop,
                PlatformTheme.mobile => PhosphorIconsLight.phone,
              }),
              selected: currentTheme == e,
              onTap: () {
                cubit.changePlatformTheme(e);
                Navigator.of(context).pop();
              },
            ),
          )
          .toList(),
    );
  }

  void _openToolbarSizeModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentSize = cubit.state.toolbarSize;
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).toolbarSize),
      childrenBuilder: (context) => ToolbarSize.values
          .map(
            (e) => ListTile(
              title: Text(e.getLocalizedName(context)),
              selected: currentSize == e,
              onTap: () {
                cubit.changeToolbarSize(e);
                Navigator.of(context).pop();
              },
            ),
          )
          .toList(),
    );
  }
}
