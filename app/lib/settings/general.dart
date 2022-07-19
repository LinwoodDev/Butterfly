import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../api/open_release_notes.dart';
import '../views/main.dart';

@immutable
class Meta {
  final String stableVersion, nightlyVersion, currentVersion;

  const Meta(
      {required this.stableVersion,
      required this.nightlyVersion,
      required this.currentVersion});
  Meta.fromJson(Map<String, dynamic> json)
      : stableVersion = json['version']['stable'] ?? '?',
        nightlyVersion = json['version']['nightly'] ?? '?',
        currentVersion = json['currentVersion'];
}

class GeneralSettingsPage extends StatelessWidget {
  final bool inView;
  const GeneralSettingsPage({super.key, this.inView = false});

  Future<Meta> _fetchMeta() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    String responseBody = '{}';
    try {
      final response = await http
          .get(Uri.parse('https://docs.butterfly.linwood.dev/meta.json'));
      responseBody = response.body;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Meta.fromJson(
        {...json.decode(responseBody), 'currentVersion': currentVersion});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: inView ? Colors.transparent : null,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.general),
          backgroundColor: inView ? Colors.transparent : null,
          automaticallyImplyLeading: !inView,
          actions: [
            if (!inView && !kIsWeb && isWindow()) ...[
              const VerticalDivider(),
              const WindowButtons()
            ]
          ],
        ),
        body: ListView(children: [
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.update,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder<Meta>(
                        future: _fetchMeta(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final meta = snapshot.data!;
                          final currentVersion = meta.currentVersion;
                          final stableVersion = meta.stableVersion;
                          final nightlyVersion = meta.nightlyVersion;
                          final isStable = currentVersion == stableVersion;
                          final isNightly = currentVersion == nightlyVersion;
                          final isUpdateAvailable = !isStable && !isNightly;
                          return Column(children: [
                            ListTile(
                              title: Text(AppLocalizations.of(context)!.stable),
                              subtitle: Text(stableVersion),
                            ),
                            ListTile(
                              title:
                                  Text(AppLocalizations.of(context)!.nightly),
                              subtitle: Text(nightlyVersion),
                            ),
                            ListTile(
                              title: Text(
                                  AppLocalizations.of(context)!.currentVersion),
                              subtitle: Text(currentVersion),
                            ),
                            const Divider(),
                            if (isStable)
                              ListTile(
                                title: Text(AppLocalizations.of(context)!
                                    .usingLatestStable),
                              ),
                            if (isNightly)
                              ListTile(
                                title: Text(AppLocalizations.of(context)!
                                    .usingLatestNightly),
                              ),
                            if (isUpdateAvailable)
                              ListTile(
                                title: Text(AppLocalizations.of(context)!
                                    .updateAvailable),
                                subtitle: Text(
                                    AppLocalizations.of(context)!.updateNow),
                                leading:
                                    const Icon(PhosphorIcons.arrowRightLight),
                                onTap: () async {
                                  await launchUrl(Uri.parse(
                                      'https://docs.butterfly.linwood.dev/downloads'));
                                },
                              ),
                          ]);
                        }),
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
                    ListTile(
                        leading: const Icon(PhosphorIcons.articleLight),
                        title:
                            Text(AppLocalizations.of(context)!.documentation),
                        onTap: () => launchUrl(
                            Uri.https('docs.butterfly.linwood.dev', ''))),
                    ListTile(
                        leading: const Icon(PhosphorIcons.flagLight),
                        title: Text(AppLocalizations.of(context)!.releaseNotes),
                        onTap: () => openReleaseNotes()),
                    ListTile(
                        leading: const Icon(PhosphorIcons.usersLight),
                        title: const Text('Matrix'),
                        onTap: () =>
                            launchUrl(Uri.https('go.linwood.dev', 'matrix'))),
                    ListTile(
                        leading: const Icon(PhosphorIcons.usersLight),
                        title: const Text('Discord'),
                        onTap: () =>
                            launchUrl(Uri.https('go.linwood.dev', 'discord'))),
                    ListTile(
                        leading: const Icon(PhosphorIcons.translateLight),
                        title: const Text('Crowdin'),
                        onTap: () => launchUrl(
                            Uri.https('go.linwood.dev', 'butterfly/crowdin'))),
                    ListTile(
                        leading: const Icon(PhosphorIcons.codeLight),
                        title: Text(AppLocalizations.of(context)!.source),
                        onTap: () => launchUrl(
                            Uri.https('go.linwood.dev', 'butterfly/source'))),
                    ListTile(
                        leading: const Icon(
                            PhosphorIcons.arrowCounterClockwiseLight),
                        title: Text(AppLocalizations.of(context)!.changelog),
                        onTap: () => launchUrl(Uri.https(
                            'docs.butterfly.linwood.dev', 'changelog'))),
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
                    ListTile(
                        leading: const Icon(PhosphorIcons.stackLight),
                        title: Text(AppLocalizations.of(context)!.license),
                        onTap: () => launchUrl(
                            Uri.https('go.linwood.dev', 'butterfly/license'))),
                    ListTile(
                        leading:
                            const Icon(PhosphorIcons.identificationCardLight),
                        title: Text(AppLocalizations.of(context)!.imprint),
                        onTap: () =>
                            launchUrl(Uri.https('go.linwood.dev', 'impress'))),
                    ListTile(
                        leading: const Icon(PhosphorIcons.shieldLight),
                        title:
                            Text(AppLocalizations.of(context)!.privacypolicy),
                        onTap: () => launchUrl(Uri.https(
                            'docs.butterfly.linwood.dev', 'privacypolicy'))),
                    ListTile(
                      title: Text(
                          AppLocalizations.of(context)!.thirdPartyLicenses),
                      leading: const Icon(PhosphorIcons.fileLight),
                      onTap: () => showLicensePage(context: context),
                    )
                  ]),
            ),
          ),
        ]));
  }
}
