import 'package:butterfly/visualizer/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../services/sync.dart';

class SyncDialog extends StatefulWidget {
  const SyncDialog({super.key});

  @override
  State<SyncDialog> createState() => _SyncDialogState();
}

class _SyncDialogState extends State<SyncDialog> {
  String? _selectedRemote;

  @override
  Widget build(BuildContext context) {
    final service = context.read<SyncService>();
    final windowSize = MediaQuery.sizeOf(context);
    final useDesktopWidth = windowSize.width >= LeapBreakpoints.medium;
    return StreamBuilder<SyncOverview>(
      stream: service.overviewStream,
      builder: (context, snapshot) {
        final overview = snapshot.data;
        final status = overview?.status;
        final syncs = service.syncs;
        if (syncs.isNotEmpty &&
            !syncs.any((sync) => sync.storage.identifier == _selectedRemote)) {
          _selectedRemote = syncs.first.storage.identifier;
        }
        final selectedSync = syncs
            .where((sync) => sync.storage.identifier == _selectedRemote)
            .firstOrNull;
        return ResponsiveDialog(
          insetPadding: const EdgeInsets.all(24),
          constraints: BoxConstraints(
            maxWidth: LeapBreakpoints.medium,
            maxHeight: LeapBreakpoints.large,
          ),
          breakpoint: LeapBreakpoints.compact,
          child: SizedBox(
            width: useDesktopWidth ? LeapBreakpoints.large : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Header(
                  title: Text(status.getLocalizedName(context)),
                  actions: [
                    IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.gear),
                      onPressed: selectedSync == null
                          ? null
                          : () {
                              final router = GoRouter.of(context);
                              Navigator.pop(context);
                              router.pushNamed(
                                'connection',
                                pathParameters: {
                                  'id': selectedSync.storage.identifier,
                                },
                              );
                            },
                      tooltip: AppLocalizations.of(context).settings,
                    ),
                    IconButton(
                      icon: const PhosphorIcon(
                        PhosphorIconsLight.arrowsClockwise,
                      ),
                      onPressed: selectedSync?.status == SyncStatus.syncing
                          ? null
                          : () => selectedSync?.sync(),
                      tooltip: selectedSync?.status.getLocalizedName(context),
                    ),
                    IconButton(
                      icon: status == SyncStatus.syncing
                          ? const SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : PhosphorIcon(
                              status.getIcon(),
                              textDirection: TextDirection.ltr,
                            ),
                      onPressed: status == SyncStatus.syncing
                          ? null
                          : () => service.sync(),
                      tooltip: AppLocalizations.of(context).connections,
                    ),
                  ],
                  leading: IconButton.outlined(
                    icon: const PhosphorIcon(PhosphorIconsLight.x),
                    onPressed: () => Navigator.pop(context),
                    tooltip: MaterialLocalizations.of(context).closeButtonLabel,
                  ),
                ),
                const Divider(),
                if (syncs.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      AppLocalizations.of(context).noConnections,
                      textAlign: TextAlign.center,
                    ),
                  )
                else ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownMenu<String>(
                          initialSelection: selectedSync?.storage.identifier,
                          expandedInsets: EdgeInsets.zero,
                          label: Text(AppLocalizations.of(context).connections),
                          leadingIcon: const PhosphorIcon(
                            PhosphorIconsLight.cloud,
                          ),
                          dropdownMenuEntries: syncs
                              .map(
                                (sync) => DropdownMenuEntry(
                                  value: sync.storage.identifier,
                                  label: sync.storage.label,
                                ),
                              )
                              .toList(),
                          onSelected: (value) =>
                              setState(() => _selectedRemote = value),
                        ),
                        const SizedBox(height: 12),
                        _SyncOverviewBar(overview: overview),
                      ],
                    ),
                  ),
                  Flexible(child: _RemoteSyncView(sync: selectedSync!)),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

enum _SyncFileFilter { all, notSynced }

class _RemoteSyncView extends StatefulWidget {
  final RemoteSync sync;

  const _RemoteSyncView({required this.sync});

  @override
  State<_RemoteSyncView> createState() => _RemoteSyncViewState();
}

class _RemoteSyncViewState extends State<_RemoteSyncView> {
  _SyncFileFilter _filter = _SyncFileFilter.all;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RemoteSyncState>(
      stream: widget.sync.stateStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }
        final state = snapshot.data;
        if (state == null) {
          return Align(
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context).noElements),
          );
        }

        final visibleFiles = state.visibleFiles;
        final allFiles = <(SyncFileSystemType, SyncFile)>[];
        for (final type in SyncFileSystemType.values) {
          for (final file in visibleFiles[type] ?? <SyncFile>[]) {
            allFiles.add((type, file));
          }
        }
        final pendingFiles = allFiles.where((entry) => entry.$2.needsSync);
        final filteredFiles = switch (_filter) {
          _SyncFileFilter.all => allFiles,
          _SyncFileFilter.notSynced => pendingFiles.toList(),
        };
        final statusCounts = <FileSyncStatus, int>{};
        for (final (_, file) in allFiles) {
          statusCounts.update(
            file.status,
            (value) => value + 1,
            ifAbsent: () => 1,
          );
        }
        final storage = state.storage is RemoteStorage
            ? state.storage as RemoteStorage
            : null;
        final cachedPaths = storage?.pinnedPaths['documents'] ?? <String>[];

        final summaryChildren = [
          _RemoteSummaryCard(
            state: state,
            cachedPaths: cachedPaths,
            cachedFiles: allFiles.length,
            pendingFiles: pendingFiles.length,
            statusCounts: statusCounts,
          ),
          const SizedBox(height: 12),
          ...SyncFileSystemType.values.map(
            (type) => _ProgressTile(
              type: type,
              progress: state.progress[type],
              files: visibleFiles[type] ?? const [],
            ),
          ),
        ];
        final fileChildren = [
          Row(
            children: [
              Expanded(child: Text(AppLocalizations.of(context).files)),
              SegmentedButton<_SyncFileFilter>(
                showSelectedIcon: false,
                segments: [
                  ButtonSegment(
                    value: _SyncFileFilter.all,
                    icon: const PhosphorIcon(PhosphorIconsLight.files),
                    label: Text('${allFiles.length}'),
                    tooltip: AppLocalizations.of(context).files,
                  ),
                  ButtonSegment(
                    value: _SyncFileFilter.notSynced,
                    icon: const PhosphorIcon(PhosphorIconsLight.warning),
                    label: Text('${pendingFiles.length}'),
                    tooltip: AppLocalizations.of(context).notSynced,
                  ),
                ],
                selected: {_filter},
                onSelectionChanged: (selection) {
                  setState(() => _filter = selection.single);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (allFiles.isEmpty)
            Card(
              child: ListTile(
                leading: const PhosphorIcon(PhosphorIconsLight.cloudSlash),
                title: Text(AppLocalizations.of(context).notSynced),
              ),
            )
          else if (filteredFiles.isEmpty)
            Card(
              child: ListTile(
                leading: const PhosphorIcon(PhosphorIconsLight.check),
                title: Text(AppLocalizations.of(context).synced),
              ),
            )
          else
            ...filteredFiles.map(
              (entry) => _SyncFileCard(
                sync: widget.sync,
                fileSystemType: entry.$1,
                file: entry.$2,
              ),
            ),
        ];

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 840) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 360,
                      child: ListView(
                        shrinkWrap: true,
                        children: summaryChildren,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ListView(shrinkWrap: true, children: fileChildren),
                    ),
                  ],
                ),
              );
            }
            return ListView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              shrinkWrap: true,
              children: [
                ...summaryChildren,
                const SizedBox(height: 12),
                ...fileChildren,
              ],
            );
          },
        );
      },
    );
  }
}

class _SyncOverviewBar extends StatelessWidget {
  final SyncOverview? overview;

  const _SyncOverviewBar({required this.overview});

  @override
  Widget build(BuildContext context) {
    final status = overview?.status;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _StatusChip(
          icon: status.getIcon(),
          color: status?.getColor(ColorScheme.of(context)),
          label: status.getLocalizedName(context),
        ),
        _StatusChip(
          icon: PhosphorIconsLight.files,
          label:
              '${overview?.cachedFiles ?? 0} ${AppLocalizations.of(context).caches}',
        ),
        _StatusChip(
          icon: PhosphorIconsLight.warning,
          label:
              '${overview?.pendingFiles ?? 0} ${AppLocalizations.of(context).notSynced}',
        ),
      ],
    );
  }
}

class _RemoteSummaryCard extends StatelessWidget {
  final RemoteSyncState state;
  final List<String> cachedPaths;
  final int cachedFiles, pendingFiles;
  final Map<FileSyncStatus, int> statusCounts;

  const _RemoteSummaryCard({
    required this.state,
    required this.cachedPaths,
    required this.cachedFiles,
    required this.pendingFiles,
    required this.statusCounts,
  });

  @override
  Widget build(BuildContext context) {
    final storage = state.storage;
    final colorScheme = ColorScheme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: PhosphorIcon(
                state.status.getIcon(),
                color: state.status.getColor(colorScheme),
              ),
              title: Text(storage.label),
              subtitle: Text(
                storage is RemoteStorage
                    ? storage.displayName
                    : storage.identifier,
              ),
              trailing: state.isSyncing
                  ? const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
            ),
            if (state.lastError != null) ...[
              const SizedBox(height: 8),
              Text(
                state.lastError!,
                style: TextTheme.of(
                  context,
                ).bodySmall?.copyWith(color: colorScheme.error),
              ),
            ],
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _StatusChip(
                  icon: PhosphorIconsLight.files,
                  label: '$cachedFiles ${AppLocalizations.of(context).files}',
                ),
                _StatusChip(
                  icon: PhosphorIconsLight.warning,
                  color: pendingFiles > 0 ? colorScheme.error : null,
                  label:
                      '$pendingFiles ${AppLocalizations.of(context).notSynced}',
                ),
                _StatusChip(
                  icon: PhosphorIconsLight.folderSimpleDashed,
                  label:
                      '${cachedPaths.length} ${AppLocalizations.of(context).caches}',
                ),
                for (final entry in statusCounts.entries)
                  _StatusChip(
                    icon: entry.key.getIcon(),
                    color: entry.key.getColor(colorScheme),
                    label:
                        '${entry.value} ${entry.key.getLocalizedName(context)}',
                  ),
              ],
            ),
            if (cachedPaths.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: cachedPaths
                    .map(
                      (path) => Chip(
                        avatar: const PhosphorIcon(
                          PhosphorIconsLight.folder,
                          size: 16,
                        ),
                        label: Text(path),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProgressTile extends StatelessWidget {
  final SyncFileSystemType type;
  final SyncProgress? progress;
  final List<SyncFile> files;

  const _ProgressTile({
    required this.type,
    required this.progress,
    required this.files,
  });

  String _getFileSystemTypeLabel(BuildContext context) {
    return switch (type) {
      SyncFileSystemType.documents => AppLocalizations.of(context).document,
      SyncFileSystemType.templates => AppLocalizations.of(context).templates,
      SyncFileSystemType.packs => AppLocalizations.of(context).packs,
    };
  }

  @override
  Widget build(BuildContext context) {
    final progress = this.progress;
    final pendingFiles = files.where((file) => file.needsSync).length;
    final colorScheme = ColorScheme.of(context);
    final trailingText = pendingFiles == 0
        ? AppLocalizations.of(context).synced
        : '$pendingFiles ${AppLocalizations.of(context).notSynced}';
    final value = progress == null || progress.totalFiles == 0
        ? null
        : progress.processedFiles / progress.totalFiles;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                PhosphorIcon(_getIcon()),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_getFileSystemTypeLabel(context)),
                      if (files.isNotEmpty)
                        Text(
                          '${files.length} ${AppLocalizations.of(context).files}',
                          style: TextTheme.of(
                            context,
                          ).bodySmall?.copyWith(color: colorScheme.outline),
                        ),
                    ],
                  ),
                ),
                Text(
                  trailingText,
                  style: TextTheme.of(context).bodyMedium?.copyWith(
                    color: pendingFiles == 0
                        ? colorScheme.primary
                        : colorScheme.error,
                  ),
                ),
              ],
            ),
            if (progress?.isRunning ?? false) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(value: value),
              if (progress?.currentFile != null) ...[
                const SizedBox(height: 8),
                Text(
                  '${progress?.currentAction?.name ?? AppLocalizations.of(context).syncing}: ${progress!.currentFile}',
                  style: TextTheme.of(context).bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  PhosphorIconData _getIcon() => switch (type) {
    SyncFileSystemType.documents => PhosphorIconsLight.file,
    SyncFileSystemType.templates => PhosphorIconsLight.fileDashed,
    SyncFileSystemType.packs => PhosphorIconsLight.package,
  };
}

class _StatusChip extends StatelessWidget {
  final PhosphorIconData icon;
  final String label;
  final Color? color;

  const _StatusChip({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: PhosphorIcon(icon, size: 16, color: color),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _SyncFileCard extends StatelessWidget {
  final RemoteSync sync;
  final SyncFileSystemType fileSystemType;
  final SyncFile file;

  const _SyncFileCard({
    required this.sync,
    required this.fileSystemType,
    required this.file,
  });

  String _getFileSystemTypeLabel(BuildContext context) {
    return switch (fileSystemType) {
      SyncFileSystemType.documents => AppLocalizations.of(context).document,
      SyncFileSystemType.templates => AppLocalizations.of(context).templates,
      SyncFileSystemType.packs => AppLocalizations.of(context).packs,
    };
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat.yMd(
      Localizations.localeOf(context).toString(),
    ).add_Hm();
    final modified =
        file.localLastModified ??
        file.remoteLastModified ??
        file.syncedLastModified;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(file.location.path),
            subtitle: Text(
              [
                _getFileSystemTypeLabel(context),
                file.status.getLocalizedName(context),
                if (modified != null) dateFormatter.format(modified),
              ].join(' • '),
            ),
            leading: PhosphorIcon(
              file.status.getIcon(),
              color: file.status.getColor(ColorScheme.of(context)),
            ),
          ),
          if (file.status == FileSyncStatus.conflict) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => sync.resolveConflict(
                    fileSystemType,
                    file.location.path,
                    ConflictResolution.keepLocal,
                  ),
                  child: Text(AppLocalizations.of(context).keepLocal),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => sync.resolveConflict(
                    fileSystemType,
                    file.location.path,
                    ConflictResolution.keepRemote,
                  ),
                  child: Text(AppLocalizations.of(context).keepConnection),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => sync.resolveConflict(
                    fileSystemType,
                    file.location.path,
                    ConflictResolution.keepBoth,
                  ),
                  child: Text(AppLocalizations.of(context).keepBoth),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
