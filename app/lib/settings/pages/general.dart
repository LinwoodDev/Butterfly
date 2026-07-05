part of '../home.dart';

final _generalSettingsPage = SettingsLeapPage<ButterflySettings>(
  id: 'general',
  displayName: (context) => AppLocalizations.of(context).general,
  icon: PhosphorIconsLight.gear,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'update': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).update,
      settings: [
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).currentVersion,
          builder: _currentVersionSetting,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) =>
              AppLocalizations.of(context).checkForUpdates,
          enabled: (context, state) => !kIsWeb,
          builder: _updateCheckSetting,
        ),
      ],
    ),
    'community': SettingsLeapSection(
      settings: [
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).documentation,
          icon: PhosphorIconsLight.article,
          onTap: _openDocumentation,
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).releaseNotes,
          icon: PhosphorIconsLight.flag,
          onTap: (context) => openReleaseNotes(),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => 'Matrix',
          icon: PhosphorIconsLight.users,
          onTap: _openMatrix,
        ),
        SettingsLeapActionSetting(
          displayName: (context) => 'Discord',
          icon: PhosphorIconsLight.users,
          onTap: _openDiscord,
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).translate,
          icon: PhosphorIconsLight.translate,
          onTap: _openTranslate,
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).sourceCode,
          icon: PhosphorIconsLight.code,
          onTap: _openSourceCode,
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).changelog,
          icon: PhosphorIconsLight.arrowCounterClockwise,
          onTap: _openChangelog,
        ),
      ],
    ),
    'legal': SettingsLeapSection(
      settings: [
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).license,
          icon: PhosphorIconsLight.stack,
          onTap: _openLicense,
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).imprint,
          icon: PhosphorIconsLight.identificationCard,
          onTap: _openImprint,
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).privacypolicy,
          icon: PhosphorIconsLight.shield,
          onTap: _openPrivacyPolicy,
        ),
        SettingsLeapActionSetting(
          displayName: (context) =>
              AppLocalizations.of(context).thirdPartyLicenses,
          icon: PhosphorIconsLight.file,
          onTap: (context) => showLicensePage(context: context),
        ),
      ],
    ),
  },
);

class _Meta {
  const _Meta({
    required this.stableVersion,
    required this.nightlyVersion,
    required this.developVersion,
    required this.mainVersion,
  });

  _Meta.fromJson(Map<String, dynamic> json)
    : stableVersion = json['version']?['stable'] ?? '?',
      nightlyVersion = json['version']?['nightly'] ?? '?',
      developVersion = json['version']?['develop'] ?? '?',
      mainVersion = json['version']?['main'] ?? '?';

  final String stableVersion;
  final String nightlyVersion;
  final String developVersion;
  final String mainVersion;
}

Widget _currentVersionSetting(BuildContext context, ButterflySettings state) {
  return FutureBuilder<String>(
    future: getCurrentVersion(),
    builder: (context, snapshot) {
      final currentVersion = snapshot.data ?? '?';
      final currentVersionName = '$applicationVersionName $currentVersion';
      return ListTile(
        title: Text(AppLocalizations.of(context).currentVersion),
        subtitle: Text(currentVersionName),
        onTap: () => saveToClipboard(context, currentVersion),
      );
    },
  );
}

class _UpdateCheckSetting extends StatefulWidget {
  const _UpdateCheckSetting();

  @override
  State<_UpdateCheckSetting> createState() => _UpdateCheckSettingState();
}

class _UpdateCheckSettingState extends State<_UpdateCheckSetting> {
  Future<_Meta>? _metaFuture;
  final Future<String> _currentVersion = getCurrentVersion();

  void _loadMeta() => setState(() {
    _metaFuture = _fetchMeta();
  });

  Future<_Meta> _fetchMeta() async {
    final response = await http.get(
      Uri.parse('https://butterfly.linwood.dev/meta.json'),
    );
    return _Meta.fromJson({...json.decode(response.body)});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _currentVersion,
      builder: (context, snapshot) {
        final currentVersion = snapshot.data ?? '?';
        return FutureBuilder<_Meta>(
          future: _metaFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ListTile(
                title: Text(AppLocalizations.of(context).error),
                subtitle: Text('${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return ListTile(
                title: Text(AppLocalizations.of(context).checkForUpdates),
                subtitle: Text(
                  AppLocalizations.of(context).checkForUpdatesWarning,
                ),
                onTap: _loadMeta,
              );
            }
            final meta = snapshot.data!;
            final stableVersion = meta.stableVersion;
            final nightlyVersion = meta.nightlyVersion;
            final isStable = currentVersion == stableVersion;
            final isNightly = currentVersion == nightlyVersion;
            final isDevelop = currentVersion == meta.developVersion;
            final isMain = currentVersion == meta.mainVersion;
            final isError =
                meta.nightlyVersion == '?' || meta.stableVersion == '?';
            final isUpdateAvailable =
                !isError && !isStable && !isNightly && !isDevelop && !isMain;
            return Column(
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context).stable),
                  subtitle: Text(stableVersion),
                  onTap: () => saveToClipboard(context, stableVersion),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).nightly),
                  subtitle: Text(nightlyVersion),
                  onTap: () => saveToClipboard(context, nightlyVersion),
                ),
                const Divider(),
                if (isStable)
                  ListTile(
                    title: Text(AppLocalizations.of(context).usingLatestStable),
                  )
                else if (isNightly || isDevelop || isMain)
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context).usingLatestNightly,
                    ),
                  )
                else if (isError)
                  ListTile(title: Text(AppLocalizations.of(context).error))
                else if (isUpdateAvailable)
                  ListTile(
                    title: Text(AppLocalizations.of(context).updateAvailable),
                    subtitle: Text(AppLocalizations.of(context).updateNow),
                    leading: const PhosphorIcon(PhosphorIconsLight.arrowRight),
                    onTap: _openDownloads,
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

Widget _updateCheckSetting(BuildContext context, ButterflySettings state) =>
    const _UpdateCheckSetting();

Future<void> _openUrl(Uri uri) =>
    launchUrl(uri, mode: LaunchMode.externalApplication);

void _openDocumentation(BuildContext context) =>
    _openUrl(Uri.https('butterfly.linwood.dev', ''));

void _openMatrix(BuildContext context) =>
    _openUrl(Uri.https('go.linwood.dev', 'matrix'));

void _openDiscord(BuildContext context) =>
    _openUrl(Uri.https('go.linwood.dev', 'discord'));

void _openTranslate(BuildContext context) =>
    _openUrl(Uri.https('go.linwood.dev', 'butterfly/translate'));

void _openSourceCode(BuildContext context) =>
    _openUrl(Uri.https('go.linwood.dev', 'butterfly/source'));

void _openChangelog(BuildContext context) =>
    _openUrl(Uri.https('butterfly.linwood.dev', 'changelog'));

void _openLicense(BuildContext context) =>
    _openUrl(Uri.https('go.linwood.dev', 'butterfly/license'));

void _openImprint(BuildContext context) =>
    _openUrl(Uri.https('go.linwood.dev', 'imprint'));

void _openPrivacyPolicy(BuildContext context) =>
    _openUrl(Uri.https('butterfly.linwood.dev', 'privacypolicy'));

void _openDownloads() =>
    _openUrl(Uri.parse('https://butterfly.linwood.dev/downloads'));
