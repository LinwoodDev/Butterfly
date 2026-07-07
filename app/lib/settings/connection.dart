import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/theme.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
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
  bool? _isRemote;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _isRemote =
        context.read<SettingsCubit>().getRemote(widget.remote) is RemoteStorage;
    _tabController = TabController(
      length: (_isRemote ?? false) ? 2 : 1,
      vsync: this,
    );
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
      label: Text(AppLocalizations.of(context).createCache),
      icon: const PhosphorIcon(PhosphorIconsLight.plus),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(widget.remote),
        bottom: (_isRemote ?? false)
            ? TabBar(
                controller: _tabController,
                onTap: (_) => setState(() {}),
                tabs: [
                  HorizontalTab(
                    icon: const PhosphorIcon(
                      PhosphorIconsLight.gear,
                      textDirection: TextDirection.ltr,
                    ),
                    label: Text(AppLocalizations.of(context).general),
                  ),
                  HorizontalTab(
                    icon: const PhosphorIcon(
                      PhosphorIconsLight.files,
                      textDirection: TextDirection.ltr,
                    ),
                    label: Text(AppLocalizations.of(context).caches),
                  ),
                ],
                isScrollable: true,
              )
            : null,
      ),
      body: _isRemote == null
          ? Center(child: Text(AppLocalizations.of(context).noConnections))
          : TabBarView(
              controller: _tabController,
              children: [
                _GeneralConnectionSettingsView(
                  identifier: widget.remote,
                  isRemote: _isRemote ?? false,
                ),
                if (_isRemote ?? false)
                  _CachesConnectionSettingsView(identifier: widget.remote),
              ],
            ),
      floatingActionButton: _createFab()[_tabController.index],
    );
  }

  Future<void> _showCreateDialog() async {
    final settingsCubit = context.read<SettingsCubit>();
    final pathController = TextEditingController();
    final success =
        await showDialog<bool>(
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
                child: Text(
                  MaterialLocalizations.of(context).cancelButtonLabel,
                ),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              ElevatedButton(
                child: Text(LeapLocalizations.of(context).create),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        ) ??
        false;
    if (!success) return;

    settingsCubit.addCache(widget.remote, pathController.text);
  }
}

class _GeneralConnectionSettingsView extends StatelessWidget {
  final String identifier;
  final bool isRemote;

  const _GeneralConnectionSettingsView({
    required this.identifier,
    required this.isRemote,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
        child: ListView(
          children: [
            Card(
              margin: settingsCardMargin,
              child: Padding(
                padding: settingsCardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context).manage,
                      style: TextTheme.of(context).headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    if (isRemote) ...[
                      BlocBuilder<SettingsCubit, ButterflySettings>(
                        builder: (context, state) {
                          final storage =
                              state.getRemote(identifier) as RemoteStorage?;
                          final isRootCached =
                              storage?.pinnedPaths['documents']?.contains(
                                '/',
                              ) ??
                              false;
                          return CheckboxListTile(
                            value: isRootCached,
                            onChanged: (value) {
                              if (storage == null) return;
                              if (isRootCached) {
                                context.read<SettingsCubit>().removeCache(
                                  identifier,
                                  '/',
                                );
                              } else {
                                context.read<SettingsCubit>().addCache(
                                  identifier,
                                  '/',
                                );
                              }
                            },
                            title: Text(
                              AppLocalizations.of(context).syncRootDirectory,
                            ),
                            secondary: const PhosphorIcon(
                              PhosphorIconsLight.folder,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context).clearCaches),
                        leading: const PhosphorIcon(PhosphorIconsLight.fileX),
                        onTap: () {
                          context.read<SettingsCubit>().clearCaches(identifier);
                        },
                      ),
                    ],
                    ListTile(
                      title: Text(AppLocalizations.of(context).delete),
                      leading: const PhosphorIcon(PhosphorIconsLight.trash),
                      onTap: () {
                        context.read<SettingsCubit>().deleteRemote(identifier);
                        GoRouter.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CachesConnectionSettingsView extends StatelessWidget {
  final String identifier;

  const _CachesConnectionSettingsView({required this.identifier});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      builder: (context, state) {
        final storage = state.getRemote(identifier);
        if (storage == null || storage is! RemoteStorage) {
          return Center(child: Text(AppLocalizations.of(context).noElements));
        }
        final cached = storage.pinnedPaths['documents'] ?? <String>[];
        return Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: LeapBreakpoints.compact,
            ),
            child: cached.isEmpty
                ? Text(AppLocalizations.of(context).noElements)
                : ListView.builder(
                    itemCount: cached.length,
                    itemBuilder: (context, index) {
                      final current = cached[index];
                      return Dismissible(
                        key: Key(current),
                        onDismissed: (_) {
                          context.read<SettingsCubit>().removeCache(
                            storage.identifier,
                            current,
                          );
                        },
                        child: ListTile(title: Text(current)),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
