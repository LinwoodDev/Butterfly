import 'package:butterfly/settings/behaviors.dart';
import 'package:butterfly/settings/inputs/home.dart';
import 'package:butterfly/settings/data.dart';
import 'package:butterfly/settings/personalization.dart';
import 'package:butterfly/settings/view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'experiments.dart';
import 'general.dart';
import 'connections.dart';
import 'logs.dart';

enum SettingsView {
  general,
  data,
  behaviors,
  inputs,
  personalization,
  view,
  connections,
  experiments,
  logs;

  bool get isEnabled => this != SettingsView.connections || !kIsWeb;

  String getLocalizedName(BuildContext context) => switch (this) {
    SettingsView.general => AppLocalizations.of(context).general,
    SettingsView.data => AppLocalizations.of(context).data,
    SettingsView.behaviors => AppLocalizations.of(context).behaviors,
    SettingsView.inputs => AppLocalizations.of(context).inputs,
    SettingsView.personalization => AppLocalizations.of(
      context,
    ).personalization,
    SettingsView.view => AppLocalizations.of(context).view,
    SettingsView.connections => AppLocalizations.of(context).connections,
    SettingsView.experiments => AppLocalizations.of(context).experiments,
    SettingsView.logs => AppLocalizations.of(context).logs,
  };

  IconGetter get icon => switch (this) {
    SettingsView.general => PhosphorIcons.gear,
    SettingsView.data => PhosphorIcons.database,
    SettingsView.behaviors => PhosphorIcons.faders,
    SettingsView.inputs => PhosphorIcons.keyboard,
    SettingsView.personalization => PhosphorIcons.monitor,
    SettingsView.view => PhosphorIcons.eye,
    SettingsView.connections => PhosphorIcons.cloud,
    SettingsView.experiments => PhosphorIcons.flask,
    SettingsView.logs => PhosphorIcons.bug,
  };
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < LeapBreakpoints.compact;
    final content = switch (_view) {
      SettingsView.general => const GeneralSettingsPage(inView: true),
      SettingsView.data => const DataSettingsPage(inView: true),
      SettingsView.behaviors => const BehaviorsSettingsPage(inView: true),
      SettingsView.inputs => const InputsSettingsPage(inView: true),
      SettingsView.personalization => const PersonalizationSettingsPage(
        inView: true,
      ),
      SettingsView.view => const ViewSettingsPage(inView: true),
      SettingsView.connections => const ConnectionsSettingsPage(inView: true),
      SettingsView.experiments => const ExperimentsSettingsPage(inView: true),
      SettingsView.logs => const LogsSettingsPage(inView: true),
    };

    final drawer = NavigationDrawer(
      selectedIndex: SettingsView.values
          .where((e) => e.isEnabled)
          .toList()
          .indexOf(_view),
      onDestinationSelected: (index) {
        final view = SettingsView.values
            .where((e) => e.isEnabled)
            .toList()[index];
        setState(() {
          _view = view;
        });
        if (isMobile) {
          Navigator.of(context).pop();
        }
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 16),
          child: Row(
            spacing: 16,
            children: [
              if (widget.isDialog && !isMobile)
                IconButton.outlined(
                  icon: const PhosphorIcon(PhosphorIconsLight.x),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                ),
              Expanded(
                child: Text(
                  AppLocalizations.of(context).settings,
                  style: TextTheme.of(context).headlineSmall,
                ),
              ),
            ],
          ),
        ),
        ...SettingsView.values.where((e) => e.isEnabled).map((view) {
          return NavigationDrawerDestination(
            icon: PhosphorIcon(view.icon(PhosphorIconsStyle.light)),
            selectedIcon: PhosphorIcon(view.icon(PhosphorIconsStyle.fill)),
            label: Text(view.getLocalizedName(context)),
          );
        }),
      ],
    );

    final child = isMobile
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isDialog)
                Header(
                  leading: IconButton.outlined(
                    icon: const PhosphorIcon(PhosphorIconsLight.x),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).closeButtonTooltip,
                  ),
                  title: Text(AppLocalizations.of(context).settings),
                ),
              ListView(
                shrinkWrap: true,
                children: SettingsView.values.where((e) => e.isEnabled).map((
                  view,
                ) {
                  return ListTile(
                    leading: PhosphorIcon(view.icon(PhosphorIconsStyle.light)),
                    title: Text(view.getLocalizedName(context)),
                    onTap: () => context.push(view.path),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              drawer,
              Expanded(child: content),
            ],
          );

    if (widget.isDialog) return child;

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).settings)),
      body: child,
    );
  }
}
