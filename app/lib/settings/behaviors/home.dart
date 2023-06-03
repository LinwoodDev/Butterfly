import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/visualizer/sync.dart';
import 'package:butterfly/widgets/window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BehaviorsSettingsPage extends StatelessWidget {
  final bool inView;

  const BehaviorsSettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: inView ? Colors.transparent : null,
        appBar: WindowTitleBar(
          title: Text(AppLocalizations.of(context).behaviors),
          backgroundColor: inView ? Colors.transparent : null,
          inView: inView,
        ),
        body: BlocBuilder<SettingsCubit, ButterflySettings>(
            builder: (context, state) {
          return ListView(
            children: [
              if (!kIsWeb)
                Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(AppLocalizations.of(context).connection,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: 16),
                            ListTile(
                              title:
                                  Text(AppLocalizations.of(context).syncMode),
                              leading: PhosphorIcon(state.syncMode.getIcon()),
                              subtitle: Text(
                                  state.syncMode.getLocalizedName(context)),
                              onTap: () => _openSyncModeModal(context),
                            ),
                          ]),
                    )),
              Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(AppLocalizations.of(context).inputs,
                              style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 16),
                          ListTile(
                            leading:
                                const PhosphorIcon(PhosphorIconsLight.mouse),
                            title: Text(AppLocalizations.of(context).mouse),
                            onTap: () => GoRouter.of(context)
                                .go('/settings/behaviors/mouse'),
                          ),
                          ListTile(
                            leading:
                                const PhosphorIcon(PhosphorIconsLight.hand),
                            title: Text(AppLocalizations.of(context).touch),
                            onTap: () => GoRouter.of(context)
                                .go('/settings/behaviors/touch'),
                          ),
                          ListTile(
                            leading:
                                const PhosphorIcon(PhosphorIconsLight.keyboard),
                            title: Text(AppLocalizations.of(context).keyboard),
                            onTap: () => GoRouter.of(context)
                                .go('/settings/behaviors/keyboard'),
                          ),
                          ListTile(
                            leading: const PhosphorIcon(PhosphorIconsLight.pen),
                            title: Text(AppLocalizations.of(context).pen),
                            onTap: () => GoRouter.of(context)
                                .go('/settings/behaviors/pen'),
                          ),
                        ]),
                  )),
            ],
          );
        }));
  }

  Future<void> _openSyncModeModal(BuildContext context) => showLeapBottomSheet(
      context: context,
      title: AppLocalizations.of(context).syncMode,
      childrenBuilder: (ctx) {
        final settingsCubit = context.read<SettingsCubit>();
        void changeSyncMode(SyncMode syncMode) {
          settingsCubit.changeSyncMode(syncMode);
          Navigator.of(context).pop();
        }

        return [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              AppLocalizations.of(context).syncMode,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          ...SyncMode.values.map((syncMode) {
            return ListTile(
              title: Text(syncMode.getLocalizedName(context)),
              leading: PhosphorIcon(syncMode.getIcon()),
              selected: syncMode == settingsCubit.state.syncMode,
              onTap: () => changeSyncMode(syncMode),
            );
          }),
          const SizedBox(height: 32),
        ];
      });
}
