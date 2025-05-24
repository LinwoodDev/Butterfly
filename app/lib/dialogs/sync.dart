import 'package:butterfly/visualizer/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
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
  final List<int> _openedPanels = [];
  @override
  Widget build(BuildContext context) {
    final service = context.read<SyncService>();
    return StreamBuilder<SyncStatus>(
      stream: service.statusStream,
      builder: (context, snapshot) {
        final status = snapshot.data;
        return Dialog(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Header(
                  title: Text(status.getLocalizedName(context)),
                  actions: [
                    IconButton(
                      icon: PhosphorIcon(status.getIcon()),
                      onPressed: () => service.sync(),
                      tooltip: status.getLocalizedName(context),
                    ),
                  ],
                  leading: IconButton.outlined(
                    icon: const PhosphorIcon(PhosphorIconsLight.x),
                    onPressed: () => Navigator.pop(context),
                    tooltip: MaterialLocalizations.of(context).closeButtonLabel,
                  ),
                ),
                const Divider(),
                SingleChildScrollView(
                  child: ExpansionPanelList(
                    expansionCallback: (panelIndex, isExpanded) {
                      setState(() {
                        if (isExpanded) {
                          _openedPanels.add(panelIndex);
                        } else {
                          _openedPanels.remove(panelIndex);
                        }
                      });
                    },
                    children: [
                      ...service.syncs.asMap().entries.map(
                        (entry) => ExpansionPanel(
                          canTapOnHeader: true,
                          isExpanded: _openedPanels.contains(entry.key),
                          headerBuilder: (context, isExpanded) => ListTile(
                            title: Text(entry.value.remoteStorage.identifier),
                            leading: StreamBuilder<SyncStatus>(
                              stream: entry.value.statusStream,
                              builder: (context, snapshot) => IconButton(
                                tooltip: snapshot.data.getLocalizedName(
                                  context,
                                ),
                                icon: PhosphorIcon(snapshot.data.getIcon()),
                                onPressed: () => service.sync(),
                              ),
                            ),
                          ),
                          body: _RemoteSyncView(sync: entry.value),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RemoteSyncView extends StatelessWidget {
  final RemoteSync sync;

  const _RemoteSyncView({required this.sync});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SyncFile>>(
      stream: sync.filesStream,
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
        if (!snapshot.hasData) {
          return Align(
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context).noElements),
          );
        }
        final files = snapshot.data!;
        return ListView.builder(
          itemCount: files.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final file = files[index];
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(file.location.path),
                    subtitle: Text(file.status.getLocalizedName(context)),
                    leading: PhosphorIcon(file.status.getIcon()),
                  ),
                  if (file.status == FileSyncStatus.conflict) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            sync.resolve(
                              file.location.path,
                              FileSyncStatus.localLatest,
                            );
                          },
                          child: Text(AppLocalizations.of(context).keepLocal),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            sync.resolve(
                              file.location.path,
                              FileSyncStatus.remoteLatest,
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context).keepConnection,
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            sync.resolve(
                              file.location.path,
                              FileSyncStatus.conflict,
                            );
                          },
                          child: Text(AppLocalizations.of(context).keepBoth),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
