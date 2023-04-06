import 'dart:io';

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/main.dart';
import 'package:butterfly/theme.dart';
import 'package:butterfly/visualizer/string.dart';
import 'package:butterfly/widgets/window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PersonalizationSettingsPage extends StatelessWidget {
  final bool inView;
  const PersonalizationSettingsPage({super.key, this.inView = false});

  String _getThemeName(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return AppLocalizations.of(context).systemTheme;
      case ThemeMode.light:
        return AppLocalizations.of(context).lightTheme;
      case ThemeMode.dark:
        return AppLocalizations.of(context).darkTheme;
      default:
        return AppLocalizations.of(context).systemTheme;
    }
  }

  String _getLocaleName(BuildContext context, String locale) {
    return LocaleNames.of(context)?.nameOf(locale) ??
        AppLocalizations.of(context).defaultLocale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: inView ? Colors.transparent : null,
        appBar: WindowTitleBar(
          inView: inView,
          backgroundColor: inView ? Colors.transparent : null,
          title: Text(AppLocalizations.of(context).personalization),
        ),
        body: BlocBuilder<SettingsCubit, ButterflySettings>(
          builder: (context, state) {
            final design = state.design;
            return ListView(children: [
              Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                            leading: const PhosphorIcon(PhosphorIconsLight.eye),
                            title: Text(AppLocalizations.of(context).theme),
                            subtitle: Text(_getThemeName(context, state.theme)),
                            onTap: () => _openThemeModal(context)),
                        ListTile(
                          leading: const PhosphorIcon(PhosphorIconsLight.palette),
                          title: Text(AppLocalizations.of(context).design),
                          subtitle: Text(
                            design.isEmpty
                                ? AppLocalizations.of(context).systemTheme
                                : design.toDisplayString(),
                          ),
                          trailing: _ThemeBox(
                            theme: getThemeData(state.design, false),
                          ),
                          onTap: () => _openDesignModal(context),
                        ),
                        ListTile(
                            leading: const PhosphorIcon(PhosphorIconsLight.translate),
                            title: Text(AppLocalizations.of(context).locale),
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
                        if (!kIsWeb && (Platform.isWindows || Platform.isLinux))
                          SwitchListTile(
                            value: state.nativeWindowTitleBar,
                            title: Text(AppLocalizations.of(context)
                                .nativeWindowTitleBar),
                            secondary:
                                const PhosphorIcon(PhosphorIconsLight.appWindow),
                            onChanged: (value) => context
                                .read<SettingsCubit>()
                                .changeNativeWindowTitleBar(value),
                          ),
                        SwitchListTile(
                          secondary:
                              const PhosphorIcon(PhosphorIconsLight.squaresFour),
                          title: Text(AppLocalizations.of(context).start),
                          value: state.startEnabled,
                          onChanged: (value) => context
                              .read<SettingsCubit>()
                              .changeStartEnabled(value),
                        ),
                        SwitchListTile(
                          value: state.startInFullScreen,
                          onChanged: (value) => context
                              .read<SettingsCubit>()
                              .changeStartInFullScreen(value),
                          title: Text(
                              AppLocalizations.of(context).startInFullScreen),
                          secondary: const PhosphorIcon(PhosphorIconsLight.arrowsOut),
                        ),
                      ]),
                ),
              ),
            ]);
          },
        ));
  }

  void _openDesignModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final design = cubit.state.design;

    showModalBottomSheet(
        constraints: const BoxConstraints(maxWidth: 640),
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
                      AppLocalizations.of(context).theme,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context).systemTheme),
                    selected: design.isEmpty,
                    onTap: () => changeDesign(''),
                    leading: _ThemeBox(
                      theme: getThemeData('', false),
                    ),
                  ),
                  ...getThemes().map(
                    (e) {
                      final theme = getThemeData(e, false);
                      return ListTile(
                          title: Text(e.toDisplayString()),
                          selected: e == design,
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
        constraints: const BoxConstraints(maxWidth: 640),
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
                    AppLocalizations.of(context).theme,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                    title: Text(AppLocalizations.of(context).systemTheme),
                    selected: currentTheme == ThemeMode.system,
                    leading: const PhosphorIcon(PhosphorIconsLight.power),
                    onTap: () => changeTheme(ThemeMode.system)),
                ListTile(
                    title: Text(AppLocalizations.of(context).lightTheme),
                    selected: currentTheme == ThemeMode.light,
                    leading: const PhosphorIcon(PhosphorIconsLight.sun),
                    onTap: () => changeTheme(ThemeMode.light)),
                ListTile(
                    title: Text(AppLocalizations.of(context).darkTheme),
                    selected: currentTheme == ThemeMode.dark,
                    leading: const PhosphorIcon(PhosphorIconsLight.moon),
                    onTap: () => changeTheme(ThemeMode.dark)),
                const SizedBox(height: 32),
              ]));
        });
  }

  void _openLocaleModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentLocale = cubit.state.localeTag;
    var locales = getLocales();
    showModalBottomSheet<String>(
        constraints: const BoxConstraints(maxWidth: 640),
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
                    AppLocalizations.of(context).locale,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                    title: Text(AppLocalizations.of(context).defaultLocale),
                    selected: currentLocale.isEmpty,
                    onTap: () => changeLocale(null)),
                ...locales
                    .map((e) => ListTile(
                        title: Text(_getLocaleName(context, e.toLanguageTag())),
                        selected: currentLocale == e.toLanguageTag(),
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
