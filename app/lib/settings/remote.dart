import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../views/main.dart';

class RemoteSettingsPage extends StatefulWidget {
  final String remote;
  const RemoteSettingsPage({super.key, required this.remote});

  @override
  State<RemoteSettingsPage> createState() => _RemoteSettingsPageState();
}

class _RemoteSettingsPageState extends State<RemoteSettingsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<FloatingActionButton?> _createFab() => [
        null,
        FloatingActionButton.extended(
          onPressed: _showCreateDialog,
          label: Text(AppLocalizations.of(context)!.createCache),
          icon: const Icon(PhosphorIcons.plusLight),
        )
      ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      builder: (context, state) {
        final storage = state.getRemote(widget.remote);
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.remote),
            bottom: TabBar(
              controller: _tabController,
              onTap: (_) => setState(() {}),
              tabs: [
                Tab(
                  child: Row(children: [
                    const Icon(PhosphorIcons.gearLight),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.general),
                  ]),
                ),
                Tab(
                  child: Row(children: [
                    const Icon(PhosphorIcons.filesLight),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.caches),
                  ]),
                ),
              ],
              isScrollable: true,
            ),
            actions: [
              if (!kIsWeb && isWindow()) ...[
                const VerticalDivider(),
                const WindowButtons()
              ]
            ],
          ),
          body: storage == null
              ? Center(child: Text(AppLocalizations.of(context)!.noRemotes))
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _GeneralRemoteSettingsView(storage: storage),
                    _CachesRemoteSettingsView(storage: storage),
                  ],
                ),
          floatingActionButton: _createFab()[_tabController.index],
        );
      },
    );
  }

  void _showCreateDialog() {
    TextEditingController pathController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.createCache),
        content: TextField(
          controller: pathController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.path,
          ),
        ),
        actions: [
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.create),
            onPressed: () {
              Navigator.pop(context);
              context.read<SettingsCubit>().addCache(
                    widget.remote,
                    pathController.text,
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _GeneralRemoteSettingsView extends StatelessWidget {
  final RemoteStorage storage;
  const _GeneralRemoteSettingsView({required this.storage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(children: [
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppLocalizations.of(context)!.manage,
                        style: Theme.of(context).textTheme.headline5),
                    const SizedBox(height: 16),
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.clearCaches),
                      leading: const Icon(PhosphorIcons.fileXLight),
                      onTap: () {
                        context.read<SettingsCubit>().clearCaches(storage);
                      },
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.delete),
                      leading: const Icon(PhosphorIcons.trashLight),
                      onTap: () {
                        context
                            .read<SettingsCubit>()
                            .deleteRemote(storage.identifier);
                        GoRouter.of(context).pop();
                      },
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _CachesRemoteSettingsView extends StatelessWidget {
  final RemoteStorage storage;
  const _CachesRemoteSettingsView({required this.storage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView.builder(
          itemCount: storage.cachedDocuments.length,
          itemBuilder: (context, index) {
            final current = storage.cachedDocuments[index];
            return Dismissible(
              key: Key(current),
              onDismissed: (_) {
                context
                    .read<SettingsCubit>()
                    .removeCache(storage.identifier, current);
              },
              child: ListTile(
                title: Text(current),
              ),
            );
          },
        ),
      ),
    );
  }
}
