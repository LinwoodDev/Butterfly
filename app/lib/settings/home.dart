import 'package:butterfly/cubits/settings.dart';
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

enum SettingsView {
  general,
  data,
  behaviors,
  inputs,
  personalization,
  view,
  connections,
  experiments;

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
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < LeapBreakpoints.compact;
    final body = _buildBody(context, isMobile);
    if (widget.isDialog) {
      return body;
    }
    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).settings),
      ),
      body: body,
    );
  }

  Widget _buildBody(BuildContext context, bool isMobile) {
    void navigateTo(SettingsView view) {
      if (isMobile) {
        context.push(view.path);
      } else {
        setState(() {
          _view = view;
        });
      }
    }

    var navigation = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.isDialog)
          Header(
            title: Text(AppLocalizations.of(context).settings),
            leading: IconButton.outlined(
              icon: const PhosphorIcon(PhosphorIconsLight.x),
              onPressed: () => Navigator.of(context).pop(),
              tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            ),
          ),
        Flexible(
          child: Material(
            type: MaterialType.transparency,
            child: ListView(
              controller: _scrollController,
              shrinkWrap: true,
              children: [
                ...SettingsView.values.where((e) => e.isEnabled).map((view) {
                  final selected = _view == view && !isMobile;
                  return ListTile(
                    leading: PhosphorIcon(
                      view.icon(
                        selected
                            ? PhosphorIconsStyle.fill
                            : PhosphorIconsStyle.light,
                      ),
                    ),
                    title: Text(view.getLocalizedName(context)),
                    onTap: () => navigateTo(view),
                    selected: selected,
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
    if (isMobile) {
      return navigation;
    }
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
    };
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: 300, child: navigation),
        Expanded(child: content),
      ],
    );
  }
}
