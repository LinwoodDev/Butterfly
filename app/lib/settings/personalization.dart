import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/main.dart';
import 'package:butterfly/visualizer/string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/manager.dart';

class PersonalizationSettingsPage extends StatelessWidget {
  final bool inView;
  const PersonalizationSettingsPage({super.key, this.inView = false});

  String _getThemeName(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return AppLocalizations.of(context)!.systemTheme;
      case ThemeMode.light:
        return AppLocalizations.of(context)!.lightTheme;
      case ThemeMode.dark:
        return AppLocalizations.of(context)!.darkTheme;
      default:
        return AppLocalizations.of(context)!.systemTheme;
    }
  }

  String _getLocaleName(BuildContext context, String? locale) {
    switch (locale) {
      case 'fr':
        return AppLocalizations.of(context)!.french;
      case 'de':
        return AppLocalizations.of(context)!.german;
      case 'en':
        return AppLocalizations.of(context)!.english;
      case 'es':
        return AppLocalizations.of(context)!.spanish;
      case 'it':
        return AppLocalizations.of(context)!.italian;
      default:
        return AppLocalizations.of(context)!.defaultLocale;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: inView ? Colors.transparent : null,
        appBar: AppBar(
          automaticallyImplyLeading: !inView,
          backgroundColor: inView ? Colors.transparent : null,
          title: Text(AppLocalizations.of(context)!.personalization),
          actions: [
            if (!inView && !kIsWeb && isWindow()) ...[
              const VerticalDivider(),
              const WindowButtons()
            ]
          ],
        ),
        body: BlocBuilder<SettingsCubit, ButterflySettings>(
          builder: (context, state) => ListView(children: [
            Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                          leading: const Icon(PhosphorIcons.eyeLight),
                          title: Text(AppLocalizations.of(context)!.theme),
                          subtitle: Text(_getThemeName(context, state.theme)),
                          onTap: () => _openThemeModal(context)),
                      ListTile(
                        leading: const Icon(PhosphorIcons.paletteLight),
                        title: Text(AppLocalizations.of(context)!.design),
                        subtitle:
                            Text(getCurrentDesign(context).toDisplayString()),
                        trailing: _ThemeBox(
                            theme: ThemeManager.getThemeByName(state.design)),
                        onTap: () => _openDesignModal(context),
                      ),
                      ListTile(
                          leading: const Icon(PhosphorIcons.translateLight),
                          title: Text(AppLocalizations.of(context)!.locale),
                          subtitle:
                              Text(_getLocaleName(context, state.localeTag)),
                          onTap: () => _openLocaleModal(context)),
                    ]),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CheckboxListTile(
                        secondary: const Icon(PhosphorIcons.squaresFourLight),
                        title: Text(AppLocalizations.of(context)!.start),
                        value: state.startEnabled,
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeStartEnabled(value ?? true),
                      ),
                      CheckboxListTile(
                        secondary: const Icon(PhosphorIcons.paletteLight),
                        title: Text(AppLocalizations.of(context)!.color),
                        value: state.colorEnabled,
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeColorEnabled(value ?? true),
                      ),
                    ]),
              ),
            ),
          ]),
        ));
  }

  String getCurrentDesign(BuildContext context) {
    var design = context.read<SettingsCubit>().state.design;
    if (design.isEmpty) return 'classic';
    return design;
  }

  void _openDesignModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final currentDesign = getCurrentDesign(context);

    showModalBottomSheet(
        context: context,
        builder: (context) {
          void changeDesign(String design) {
            cubit.changeDesign(design);
            Navigator.of(context).pop();
          }

          return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Text(
                      AppLocalizations.of(context)!.theme,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ...ThemeManager.getThemes().map(
                    (e) {
                      final theme = ThemeManager.getThemeByName(e);
                      return ListTile(
                          title: Text(e.toDisplayString()),
                          selected: e == currentDesign,
                          onTap: () => changeDesign(e),
                          leading: _ThemeBox(
                            theme: theme,
                          ));
                    },
                  ),
                ],
              ));
        });
  }

  void _openThemeModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final currentTheme = cubit.state.theme;

    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          void changeTheme(ThemeMode themeMode) {
            cubit.changeTheme(themeMode);
            Navigator.of(context).pop();
          }

          return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    AppLocalizations.of(context)!.theme,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                    title: Text(AppLocalizations.of(context)!.systemTheme),
                    selected: currentTheme == ThemeMode.system,
                    leading: const Icon(PhosphorIcons.powerLight),
                    onTap: () => changeTheme(ThemeMode.system)),
                ListTile(
                    title: Text(AppLocalizations.of(context)!.lightTheme),
                    selected: currentTheme == ThemeMode.light,
                    leading: const Icon(PhosphorIcons.sunLight),
                    onTap: () => changeTheme(ThemeMode.light)),
                ListTile(
                    title: Text(AppLocalizations.of(context)!.darkTheme),
                    selected: currentTheme == ThemeMode.dark,
                    leading: const Icon(PhosphorIcons.moonLight),
                    onTap: () => changeTheme(ThemeMode.dark)),
                const SizedBox(height: 32),
              ]));
        });
  }

  void _openLocaleModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentLocale = cubit.state.localeTag;
    var locales = AppLocalizations.supportedLocales;
    showModalBottomSheet<String>(
        context: context,
        builder: (context) {
          void changeLocale(Locale? locale) {
            cubit.changeLocale(locale);
            Navigator.of(context).pop();
          }

          return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    AppLocalizations.of(context)!.locale,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                    title: Text(AppLocalizations.of(context)!.defaultLocale),
                    selected: currentLocale.isEmpty,
                    onTap: () => changeLocale(null)),
                ...locales
                    .map((e) => ListTile(
                        title: Text(_getLocaleName(context, e.languageCode)),
                        selected: currentLocale == e.languageCode,
                        onTap: () => changeLocale(e)))
                    .toList(),
                const SizedBox(height: 32),
              ]));
        });
  }
}

class _ThemeBox extends StatelessWidget {
  final ThemeData theme;
  static const double size = 12;
  const _ThemeBox({required this.theme});

  @override
  Widget build(BuildContext context) {
    // 2x2 grid of colors
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(size),
              ),
            ),
          ),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(size),
              ),
            ),
          ),
        ]),
        Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(size),
              ),
            ),
          ),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: theme.colorScheme.tertiary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(size),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
