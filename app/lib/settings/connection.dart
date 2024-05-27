import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ConnectionSettingsPage extends StatefulWidget {
  final String remote;
  const ConnectionSettingsPage({super.key, required this.remote});

  @override
  State<ConnectionSettingsPage> createState() => _ConnectionSettingsPageState();
}

class _ConnectionSettingsPageState extends State<ConnectionSettingsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  ExternalStorage? storage;

  @override
  void initState() {
    super.initState();
    storage = context.read<SettingsCubit>().getRemote(widget.remote);
    _tabController = TabController(length: _isRemote ? 2 : 1, vsync: this);
  }

  bool get _isRemote => storage is RemoteStorage;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<FloatingActionButton?> _createFab() => [
        null,
        FloatingActionButton.extended(
          onPressed: _showCreateDialog,
          label: Text(AppLocalizations.of(context).createCache),
          icon: const PhosphorIcon(PhosphorIconsLight.plus),
        )
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(widget.remote),
        bottom: _isRemote
            ? TabBar(
                controller: _tabController,
                onTap: (_) => setState(() {}),
                tabs: [
                  HorizontalTab(
                    icon: const PhosphorIcon(PhosphorIconsLight.gear),
                    label: Text(AppLocalizations.of(context).general),
                  ),
                  HorizontalTab(
                    icon: const PhosphorIcon(PhosphorIconsLight.files),
                    label: Text(AppLocalizations.of(context).caches),
                  ),
                ],
                isScrollable: true,
              )
            : null,
      ),
      body: storage == null
          ? Center(child: Text(AppLocalizations.of(context).noConnections))
          : TabBarView(
              controller: _tabController,
              children: [
                _GeneralConnectionSettingsView(storage: storage!),
                if (_isRemote)
                  _CachesConnectionSettingsView(
                      storage: storage as RemoteStorage),
              ],
            ),
      floatingActionButton: _createFab()[_tabController.index],
    );
  }

  Future<void> _showCreateDialog() async {
    final settingsCubit = context.read<SettingsCubit>();
    final pathController = TextEditingController();
    final success = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context).createCache),
            content: TextField(
              controller: pathController,
              onSubmitted: (value) => Navigator.of(context).pop(true),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).path,
              ),
            ),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context).cancel),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              ElevatedButton(
                child: Text(AppLocalizations.of(context).create),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        ) ??
        false;
    if (!success) return;

    settingsCubit.addCache(
      widget.remote,
      pathController.text,
    );
  }
}

class _GeneralConnectionSettingsView extends StatelessWidget {
  final ExternalStorage storage;
  const _GeneralConnectionSettingsView({required this.storage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
        child: ListView(children: [
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppLocalizations.of(context).manage,
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    if (storage is RemoteStorage) ...[
                      BlocBuilder<SettingsCubit, ButterflySettings>(
                          builder: (context, state) {
                        final storage = state.getRemote(this.storage.identifier)
                            as RemoteStorage?;
                        return CheckboxListTile(
                          value: storage?.cachedDocuments.contains('/'),
                          onChanged: (value) {
                            if (storage == null) return;
                            if (storage.cachedDocuments.contains('/')) {
                              context.read<SettingsCubit>().removeCache(
                                    storage.identifier,
                                    '/',
                                  );
                            } else {
                              context.read<SettingsCubit>().addCache(
                                    storage.identifier,
                                    '/',
                                  );
                            }
                          },
                          title: Text(
                              AppLocalizations.of(context).syncRootDirectory),
                          secondary:
                              const PhosphorIcon(PhosphorIconsLight.folder),
                        );
                      }),
                      ListTile(
                        title: Text(AppLocalizations.of(context).clearCaches),
                        leading: const PhosphorIcon(PhosphorIconsLight.fileX),
                        onTap: () {
                          context.read<SettingsCubit>().clearCaches(storage);
                        },
                      ),
                    ],
                    ListTile(
                      title: Text(AppLocalizations.of(context).delete),
                      leading: const PhosphorIcon(PhosphorIconsLight.trash),
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

class _CachesConnectionSettingsView extends StatelessWidget {
  final RemoteStorage storage;
  const _CachesConnectionSettingsView({required this.storage});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        builder: (context, state) {
      return Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
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
    });
  }
}
