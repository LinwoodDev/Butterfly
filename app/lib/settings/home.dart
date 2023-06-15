import 'package:butterfly/settings/behaviors/home.dart';
import 'package:butterfly/settings/data.dart';
import 'package:butterfly/settings/personalization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'general.dart';
import 'connections.dart';

enum SettingsView {
  general,
  data,
  behaviors,
  personalization,
  connections;

  String getLocalizedName(BuildContext context) {
    switch (this) {
      case SettingsView.general:
        return AppLocalizations.of(context).general;
      case SettingsView.data:
        return AppLocalizations.of(context).data;
      case SettingsView.behaviors:
        return AppLocalizations.of(context).behaviors;
      case SettingsView.personalization:
        return AppLocalizations.of(context).personalization;
      case SettingsView.connections:
        return AppLocalizations.of(context).connections;
    }
  }

  PhosphorIconData getIcon() {
    switch (this) {
      case SettingsView.general:
        return PhosphorIconsLight.gear;
      case SettingsView.data:
        return PhosphorIconsLight.database;
      case SettingsView.behaviors:
        return PhosphorIconsLight.faders;
      case SettingsView.personalization:
        return PhosphorIconsLight.monitor;
      case SettingsView.connections:
        return PhosphorIconsLight.cloud;
    }
  }

  String get path => '/settings/$name';
}

class SettingsPage extends StatefulWidget {
  final bool isDialog;
  const SettingsPage({super.key, this.isDialog = false});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsView _view = SettingsView.general;
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

          void navigateTo(SettingsView view) {
            if (isMobile) {
              Navigator.of(context).pop();
              context.go(view.path);
            } else {
              setState(() {
                _view = view;
              });
            }
          }

          var navigation = Column(children: [
            Header(
              title: Text(AppLocalizations.of(context).settings),
              leading: IconButton(
                icon: const PhosphorIcon(PhosphorIconsLight.x),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Flexible(
              child: Material(
                color: widget.isDialog ? Colors.transparent : null,
                child: ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    children: [
                      ...SettingsView.values.map((view) => ListTile(
                            leading: PhosphorIcon(view.getIcon()),
                            title: Text(view.getLocalizedName(context)),
                            onTap: () => navigateTo(view),
                            selected: _view == view && !isMobile,
                          )),
                      if (kIsWeb) ...[
                        const Divider(),
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                                onTap: () => launchUrl(
                                    Uri.https('vercel.com', '', {
                                      'utm_source': 'Linwood',
                                      'utm_campaign': 'oss'
                                    }),
                                    mode: LaunchMode.externalApplication),
                                child: Material(
                                  color: Colors.transparent,
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
                      ],
                    ]),
              ),
            )
          ]);
          if (isMobile) {
            return navigation;
          }
          Widget content;
          switch (_view) {
            case SettingsView.general:
              content = const GeneralSettingsPage(inView: true);
              break;
            case SettingsView.data:
              content = const DataSettingsPage(inView: true);
              break;
            case SettingsView.behaviors:
              content = const BehaviorsSettingsPage(inView: true);
              break;
            case SettingsView.personalization:
              content = const PersonalizationSettingsPage(inView: true);
              break;
            case SettingsView.connections:
              content = const ConnectionsSettingsPage(inView: true);
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
