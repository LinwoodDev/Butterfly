import 'dart:convert';

import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/main.dart';
import 'package:butterfly/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

@immutable
class Meta {
  final String stableVersion, nightlyVersion, developVersion, mainVersion;

  const Meta({
    required this.stableVersion,
    required this.nightlyVersion,
    required this.developVersion,
    required this.mainVersion,
  });
  Meta.fromJson(Map<String, dynamic> json)
    : stableVersion = json['version']?['stable'] ?? '?',
      nightlyVersion = json['version']?['nightly'] ?? '?',
      developVersion = json['version']?['develop'] ?? '?',
      mainVersion = json['version']?['main'] ?? '?';
}

class GeneralSettingsPage extends StatefulWidget {
  final bool inView;
  const GeneralSettingsPage({super.key, this.inView = false});

  @override
  State<GeneralSettingsPage> createState() => _GeneralSettingsPageState();
}

class _GeneralSettingsPageState extends State<GeneralSettingsPage> {
  Future<Meta>? _metaFuture;
  final Future<String> _currentVersion = getCurrentVersion();

  void loadMeta() => setState(() {
    _metaFuture = _fetchMeta();
  });

  Future<Meta> _fetchMeta() async {
    final response = await http.get(
      Uri.parse('https://butterfly.linwood.dev/meta.json'),
    );
    return Meta.fromJson({...json.decode(response.body)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).general),
        backgroundColor: widget.inView ? Colors.transparent : null,
        inView: widget.inView,
      ),
      body: FutureBuilder(
        future: _currentVersion,
        builder: (context, snapshot) {
          final currentVersion = snapshot.data ?? '?';
          final currentVersionName = '$applicationVersionName $currentVersion';
          return ListView(
            children: [
              Card(
                margin: settingsCardMargin,
                child: Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: settingsCardTitlePadding,
                        child: Text(
                          AppLocalizations.of(context).update,
                          style: TextTheme.of(context).headlineSmall,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).currentVersion,
                        ),
                        subtitle: Text(currentVersionName),
                        onTap: () => saveToClipboard(context, currentVersion),
                      ),
                      if (!kIsWeb)
                        FutureBuilder<Meta>(
                          future: _metaFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!snapshot.hasData) {
                              return ListTile(
                                title: Text(
                                  AppLocalizations.of(context).checkForUpdates,
                                ),
                                subtitle: Text(
                                  AppLocalizations.of(
                                    context,
                                  ).checkForUpdatesWarning,
                                ),
                                onTap: loadMeta,
                              );
                            }
                            final meta = snapshot.data!;
                            final stableVersion = meta.stableVersion;
                            final nightlyVersion = meta.nightlyVersion;
                            final developVersion = meta.developVersion;
                            final mainVersion = meta.mainVersion;
                            final isStable = currentVersion == stableVersion;
                            final isNightly = currentVersion == nightlyVersion;
                            final isDevelop = currentVersion == developVersion;
                            final isMain = currentVersion == mainVersion;
                            final isError =
                                meta.nightlyVersion == '?' ||
                                meta.stableVersion == '?';
                            final isUpdateAvailable =
                                !isError &&
                                !isStable &&
                                !isNightly &&
                                !isDevelop &&
                                !isMain;
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    AppLocalizations.of(context).stable,
                                  ),
                                  subtitle: Text(stableVersion),
                                  onTap: () =>
                                      saveToClipboard(context, stableVersion),
                                ),
                                ListTile(
                                  title: Text(
                                    AppLocalizations.of(context).nightly,
                                  ),
                                  subtitle: Text(nightlyVersion),
                                  onTap: () =>
                                      saveToClipboard(context, nightlyVersion),
                                ),
                                const Divider(),
                                if (isStable) ...[
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(
                                        context,
                                      ).usingLatestStable,
                                    ),
                                  ),
                                ] else if (isNightly ||
                                    isDevelop ||
                                    isMain) ...[
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(
                                        context,
                                      ).usingLatestNightly,
                                    ),
                                  ),
                                ] else if (isError) ...[
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(context).error,
                                    ),
                                  ),
                                ] else if (isUpdateAvailable)
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(
                                        context,
                                      ).updateAvailable,
                                    ),
                                    subtitle: Text(
                                      AppLocalizations.of(context).updateNow,
                                    ),
                                    leading: const PhosphorIcon(
                                      PhosphorIconsLight.arrowRight,
                                    ),
                                    onTap: () async {
                                      await launchUrl(
                                        Uri.parse(
                                          'https://butterfly.linwood.dev/downloads',
                                        ),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                  ),
                              ],
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: settingsCardMargin,
                child: Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.article),
                        title: Text(AppLocalizations.of(context).documentation),
                        onTap: () => launchUrl(
                          Uri.https('butterfly.linwood.dev', ''),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.flag),
                        title: Text(AppLocalizations.of(context).releaseNotes),
                        onTap: () => openReleaseNotes(),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.users),
                        title: const Text('Matrix'),
                        onTap: () => launchUrl(
                          Uri.https('go.linwood.dev', 'matrix'),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.users),
                        title: const Text('Discord'),
                        onTap: () => launchUrl(
                          Uri.https('go.linwood.dev', 'discord'),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.translate,
                        ),
                        title: Text(AppLocalizations.of(context).translate),
                        onTap: () => launchUrl(
                          Uri.https('go.linwood.dev', 'butterfly/translate'),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.code),
                        title: Text(AppLocalizations.of(context).sourceCode),
                        onTap: () => launchUrl(
                          Uri.https('go.linwood.dev', 'butterfly/source'),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.arrowCounterClockwise,
                        ),
                        title: Text(AppLocalizations.of(context).changelog),
                        onTap: () => launchUrl(
                          Uri.https('butterfly.linwood.dev', 'changelog'),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: settingsCardMargin,
                child: Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.stack),
                        title: Text(AppLocalizations.of(context).license),
                        onTap: () => launchUrl(
                          Uri.https('go.linwood.dev', 'butterfly/license'),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.identificationCard,
                        ),
                        title: Text(AppLocalizations.of(context).imprint),
                        onTap: () => launchUrl(
                          Uri.https('go.linwood.dev', 'imprint'),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.shield),
                        title: Text(AppLocalizations.of(context).privacypolicy),
                        onTap: () => launchUrl(
                          Uri.https('butterfly.linwood.dev', 'privacypolicy'),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).thirdPartyLicenses,
                        ),
                        leading: const PhosphorIcon(PhosphorIconsLight.file),
                        onTap: () => showLicensePage(context: context),
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
}
