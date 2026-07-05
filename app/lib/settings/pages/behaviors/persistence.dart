part of '../../home.dart';

final _persistenceSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) =>
      AppLocalizations.of(context).persistenceDocumentStates,
  icon: PhosphorIconsLight.database,
  appBarBuilder: _butterflyAppBar,
  builder: _buildPersistenceSettingsPage,
);

Widget _buildPersistenceSettingsPage(
  BuildContext context,
  ButterflySettings state,
  bool inView,
) {
  final settings = state.documentStatePersistence;
  void change(DocumentStatePersistenceSettings next) {
    context.read<SettingsCubit>().changeDocumentStatePersistence(next);
  }

  return ListView(
    children: [
      SwitchListTile(
        value: settings.enabled,
        secondary: const PhosphorIcon(PhosphorIconsLight.power),
        title: Text(AppLocalizations.of(context).persistentStatesEnabled),
        onChanged: (value) => change(settings.copyWith(enabled: value)),
      ),
      const Divider(),
      SwitchListTile(
        value: settings.page,
        secondary: const PhosphorIcon(PhosphorIconsLight.file),
        title: Text(AppLocalizations.of(context).persistentStateCurrentPage),
        onChanged: settings.enabled
            ? (value) => change(settings.copyWith(page: value))
            : null,
      ),
      SwitchListTile(
        value: settings.camera,
        secondary: const PhosphorIcon(PhosphorIconsLight.frameCorners),
        title: Text(AppLocalizations.of(context).persistentStateViewport),
        onChanged: settings.enabled
            ? (value) => change(settings.copyWith(camera: value))
            : null,
      ),
      SwitchListTile(
        value: settings.locks,
        secondary: const PhosphorIcon(PhosphorIconsLight.lockKey),
        title: Text(AppLocalizations.of(context).lock),
        onChanged: settings.enabled
            ? (value) => change(settings.copyWith(locks: value))
            : null,
      ),
      SwitchListTile(
        value: settings.tool,
        secondary: const PhosphorIcon(PhosphorIconsLight.toolbox),
        title: Text(AppLocalizations.of(context).persistentStateSelectedTool),
        onChanged: settings.enabled
            ? (value) => change(settings.copyWith(tool: value))
            : null,
      ),
      SwitchListTile(
        value: settings.navigator,
        secondary: const PhosphorIcon(PhosphorIconsLight.sidebar),
        title: Text(AppLocalizations.of(context).navigator),
        onChanged: settings.enabled
            ? (value) => change(settings.copyWith(navigator: value))
            : null,
      ),
      SwitchListTile(
        value: settings.layers,
        secondary: const PhosphorIcon(PhosphorIconsLight.stack),
        title: Text(AppLocalizations.of(context).layers),
        onChanged: settings.enabled
            ? (value) => change(settings.copyWith(layers: value))
            : null,
      ),
      SwitchListTile(
        value: settings.areas,
        secondary: const PhosphorIcon(PhosphorIconsLight.selection),
        title: Text(AppLocalizations.of(context).areas),
        onChanged: settings.enabled
            ? (value) => change(settings.copyWith(areas: value))
            : null,
      ),
      const Divider(),
      ExactSlider(
        header: Text(AppLocalizations.of(context).persistentStateMaxRecords),
        leading: const PhosphorIcon(PhosphorIconsLight.listNumbers),
        value: settings.maxEntries.toDouble(),
        min: 20,
        max: 2000,
        defaultValue: 400,
        fractionDigits: 0,
        onChangeEnd: (value) =>
            change(settings.copyWith(maxEntries: value.toInt())),
      ),
      ExactSlider(
        header: Text(
          AppLocalizations.of(context).persistentStateDeleteOlderThanDays,
        ),
        leading: const PhosphorIcon(PhosphorIconsLight.calendar),
        value: settings.maxAgeDays.toDouble(),
        min: 7,
        max: 730,
        defaultValue: 180,
        fractionDigits: 0,
        onChangeEnd: (value) =>
            change(settings.copyWith(maxAgeDays: value.toInt())),
      ),
      ListTile(
        leading: const PhosphorIcon(PhosphorIconsLight.trash),
        title: Text(AppLocalizations.of(context).persistentStateCleanup),
        subtitle: Text(
          AppLocalizations.of(context).persistentStateCleanupDescription,
        ),
        enabled: settings.enabled,
        onTap: settings.enabled
            ? () => _cleanupPersistentStates(context)
            : null,
      ),
    ],
  );
}

Future<void> _cleanupPersistentStates(BuildContext context) async {
  final messenger = ScaffoldMessenger.of(context);
  final settingsCubit = context.read<SettingsCubit>();
  final fileSystem = context.read<ButterflyFileSystem>();
  final result = await _showCleanupTargetsDialog(
    context,
    settingsCubit,
    fileSystem,
  );
  if (result == null) return;
  if (!context.mounted) return;
  messenger.showSnackBar(
    SnackBar(
      content: Text(
        AppLocalizations.of(context).persistentStateCleanupFeedback(
          result.targetCount,
          result.deletedRecords,
        ),
      ),
    ),
  );
}

Future<_CleanupResult?> _showCleanupTargetsDialog(
  BuildContext context,
  SettingsCubit settingsCubit,
  ButterflyFileSystem fileSystem,
) async {
  final settings = settingsCubit.state;
  final targets = [
    _CleanupTarget(
      id: '',
      label: AppLocalizations.of(context).local,
      storage: null,
    ),
    ...settings.connections.map(
      (connection) => _CleanupTarget(
        id: connection.identifier,
        label: connection.identifier,
        storage: connection,
      ),
    ),
  ];
  final selected = targets.map((target) => target.id).toSet();
  var cleaning = false;

  return showDialog<_CleanupResult>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(AppLocalizations.of(context).persistentStateCleanup),
        scrollable: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (cleaning) ...[
              const LinearProgressIndicator(),
              const SizedBox(height: 16),
            ],
            for (final target in targets)
              CheckboxListTile(
                value: selected.contains(target.id),
                onChanged: cleaning
                    ? null
                    : (value) {
                        setState(() {
                          if (value ?? false) {
                            selected.add(target.id);
                          } else {
                            selected.remove(target.id);
                          }
                        });
                      },
                secondary: PhosphorIcon(
                  target.storage == null
                      ? PhosphorIconsLight.house
                      : PhosphorIconsLight.cloud,
                ),
                title: Text(target.label),
                controlAffinity: ListTileControlAffinity.leading,
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: cleaning ? null : () => Navigator.of(context).pop(),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          ElevatedButton(
            onPressed: selected.isEmpty || cleaning
                ? null
                : () async {
                    final selectedTargets = targets
                        .where((target) => selected.contains(target.id))
                        .toList();
                    setState(() => cleaning = true);
                    var deleted = 0;
                    for (final target in selectedTargets) {
                      final repository = DocumentStateRepository(
                        fileSystem.buildDocumentStateSystem(target.storage),
                        settingsProvider: () =>
                            settingsCubit.state.documentStatePersistence,
                      );
                      deleted += await repository.cleanup();
                    }
                    if (!context.mounted) return;
                    Navigator.of(context).pop(
                      _CleanupResult(
                        targetCount: selectedTargets.length,
                        deletedRecords: deleted,
                      ),
                    );
                  },
            child: cleaning
                ? Text(
                    AppLocalizations.of(
                      context,
                    ).persistentStateCleanupInProgress,
                  )
                : Text(AppLocalizations.of(context).delete),
          ),
        ],
      ),
    ),
  );
}

class _CleanupTarget {
  const _CleanupTarget({
    required this.id,
    required this.label,
    required this.storage,
  });

  final String id;
  final String label;
  final ExternalStorage? storage;
}

class _CleanupResult {
  const _CleanupResult({
    required this.targetCount,
    required this.deletedRecords,
  });

  final int targetCount;
  final int deletedRecords;
}
