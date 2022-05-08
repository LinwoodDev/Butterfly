import 'package:butterfly/settings/behaviors.dart';
import 'package:butterfly/settings/data.dart';
import 'package:butterfly/settings/personalization.dart';
import 'package:butterfly/widgets/header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/open_release_notes.dart';

enum SettingsView { data, behaviors, personalization }

class SettingsPage extends StatefulWidget {
  final bool isDialog;
  const SettingsPage({Key? key, this.isDialog = false}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsView _view = SettingsView.data;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: widget.isDialog ? Colors.transparent : null,
        child: LayoutBuilder(builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          var navigation = Column(children: [
            Header(
              title: Text(AppLocalizations.of(context)!.settings),
              leading: IconButton(
                icon: const Icon(PhosphorIcons.xLight),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Flexible(
              child: Material(
                child: ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.data),
                        leading: const Icon(PhosphorIcons.databaseLight),
                        selected: widget.isDialog && !isMobile
                            ? _view == SettingsView.data
                            : false,
                        onTap: () {
                          if (isMobile) {
                            Navigator.of(context).pop();
                            GoRouter.of(context).go('/settings/data');
                          } else {
                            setState(() {
                              _view = SettingsView.data;
                            });
                          }
                        },
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.behaviors),
                        leading: const Icon(PhosphorIcons.fadersLight),
                        selected: widget.isDialog && !isMobile
                            ? _view == SettingsView.behaviors
                            : false,
                        onTap: () {
                          if (isMobile) {
                            Navigator.of(context).pop();
                            GoRouter.of(context).go('/settings/behaviors');
                          } else {
                            setState(() {
                              _view = SettingsView.behaviors;
                            });
                          }
                        },
                      ),
                      ListTile(
                          leading: const Icon(PhosphorIcons.monitorLight),
                          title: Text(
                              AppLocalizations.of(context)!.personalization),
                          selected: widget.isDialog && !isMobile
                              ? _view == SettingsView.personalization
                              : false,
                          onTap: () {
                            if (isMobile) {
                              Navigator.of(context).pop();
                              GoRouter.of(context)
                                  .go('/settings/personalization');
                            } else {
                              setState(() {
                                _view = SettingsView.personalization;
                              });
                            }
                          }),
                      const Divider(),
                      ListTile(
                          leading: const Icon(PhosphorIcons.articleLight),
                          title:
                              Text(AppLocalizations.of(context)!.documentation),
                          onTap: () => launchUrl(
                              Uri.https('docs.butterfly.linwood.dev', ''))),
                      ListTile(
                          leading: const Icon(PhosphorIcons.flagLight),
                          title:
                              Text(AppLocalizations.of(context)!.releaseNotes),
                          onTap: () => openReleaseNotes()),
                      ListTile(
                          leading: const Icon(PhosphorIcons.usersLight),
                          title: const Text('Discord'),
                          onTap: () => launchUrl(
                              Uri.https('go.linwood.dev', 'discord'))),
                      ListTile(
                          leading: const Icon(PhosphorIcons.translateLight),
                          title: const Text('Crowdin'),
                          onTap: () => launchUrl(Uri.https(
                              'go.linwood.dev', 'butterfly/crowdin'))),
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
                      const Divider(),
                      ListTile(
                          leading: const Icon(PhosphorIcons.stackLight),
                          title: Text(AppLocalizations.of(context)!.license),
                          onTap: () => launchUrl(Uri.https(
                              'go.linwood.dev', 'butterfly/license'))),
                      ListTile(
                          leading:
                              const Icon(PhosphorIcons.identificationCardLight),
                          title: Text(AppLocalizations.of(context)!.imprint),
                          onTap: () => launchUrl(
                              Uri.https('go.linwood.dev', 'impress'))),
                      ListTile(
                          leading: const Icon(PhosphorIcons.shieldLight),
                          title:
                              Text(AppLocalizations.of(context)!.privacypolicy),
                          onTap: () => launchUrl(Uri.https(
                              'docs.butterfly.linwood.dev', 'privacypolicy'))),
                      ListTile(
                          leading: const Icon(PhosphorIcons.infoLight),
                          title:
                              Text(AppLocalizations.of(context)!.information),
                          onTap: () => PackageInfo.fromPlatform().then((info) =>
                              showAboutDialog(
                                  context: context,
                                  children: [
                                    ElevatedButton(
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .copyVersion),
                                        onPressed: () => Clipboard.setData(
                                            ClipboardData(text: info.version))),
                                  ],
                                  applicationVersion: info.version,
                                  applicationIcon: Image.asset(
                                      'images/logo.png',
                                      height: 50)))),
                      if (kIsWeb)
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                                onTap: () => launchUrl(Uri.https(
                                        'vercel.com', '', {
                                      'utm_source': 'Linwood',
                                      'utm_campaign': 'oss'
                                    })),
                                child: Material(
                                  child: SizedBox(
                                      height: 50,
                                      child: SvgPicture.asset(
                                          'images/powered-by-vercel.svg',
                                          placeholderBuilder: (BuildContext
                                                  context) =>
                                              Container(
                                                  padding: const EdgeInsets.all(
                                                      30.0),
                                                  child:
                                                      const CircularProgressIndicator()),
                                          semanticsLabel: 'Powered by Vercel')),
                                )))
                    ]),
              ),
            )
          ]);
          if (isMobile) {
            return navigation;
          }
          Widget content;
          switch (_view) {
            case SettingsView.data:
              content = const DataSettingsPage(inView: true);
              break;
            case SettingsView.behaviors:
              content = const BehaviorsSettingsPage(inView: true);
              break;
            case SettingsView.personalization:
              content = const PersonalizationSettingsPage(inView: true);
              break;
          }
          return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(width: 300, child: navigation),
            Expanded(child: content),
          ]);
        }),
      ),
    );
  }
}
