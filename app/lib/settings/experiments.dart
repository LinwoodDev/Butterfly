import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ExperimentsSettingsPage extends StatelessWidget {
  final bool inView;
  const ExperimentsSettingsPage({super.key, this.inView = false});

  List<({String name, String description, IconGetter icon})> _getExperiments(
    BuildContext context,
  ) => [
    (
      name: 'collaboration',
      description: AppLocalizations.of(context).collaboration,
      icon: PhosphorIcons.chatTeardrop,
    ),
    (
      name: 'smoothNavigation',
      description: AppLocalizations.of(context).smoothNavigation,
      icon: PhosphorIcons.caretCircleDoubleDown,
    ),
  ];

  static const Map<String, String> _featureHelps = {
    'collaboration': 'collaboration',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).experiments),
        backgroundColor: inView ? Colors.transparent : null,
        inView: inView,
        actions: [
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.clockCounterClockwise),
            tooltip: LeapLocalizations.of(context).reset,
            onPressed: () => context.read<SettingsCubit>().resetFlags(),
          ),
        ],
      ),
      body: BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) => previous.flags != current.flags,
        builder: (context, state) {
          final experiments = _getExperiments(context);
          if (experiments.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context).noElements));
          }
          return ListView(
            children: [
              Card(
                margin: settingsCardMargin,
                child: Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 16,
                            children: [
                              Icon(PhosphorIconsLight.warning),
                              Flexible(
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  ).experimentsWarning,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: experiments.length,
                        itemBuilder: (context, index) {
                          final experiment = experiments[index];
                          final currentHelp = _featureHelps[experiment.name];
                          final enabled = state.hasFlag(experiment.name);
                          return AdvancedSwitchListTile(
                            value: enabled,
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              if (value == true) {
                                cubit.addFlag(experiment.name);
                              } else {
                                cubit.removeFlag(experiment.name);
                              }
                            },
                            title: Text(experiment.description),
                            leading: PhosphorIcon(
                              experiment.icon(PhosphorIconsStyle.light),
                            ),
                            onTap: currentHelp == null
                                ? null
                                : () => openHelp([currentHelp]),
                          );
                        },
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
