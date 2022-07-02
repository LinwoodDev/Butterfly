import 'package:butterfly/api/file_system_remote.dart';
import 'package:butterfly/visualizer/sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/sync.dart';

class SyncDialog extends StatelessWidget {
  final String remote;
  const SyncDialog({super.key, required this.remote});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SyncFile>>(
      stream: context.read<SyncService>().getSync(remote)?.files,
      builder: (context, snapshot) {
        String status = AppLocalizations.of(context)!.synced;
        if (snapshot.hasData) {
          status = AppLocalizations.of(context)!.syncing;
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          status = AppLocalizations.of(context)!.loading;
        }
        List<SyncFile> files = snapshot.data ?? [];
        return AlertDialog(
            title: Text(status),
            scrollable: true,
            content: ListView.builder(
              shrinkWrap: true,
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return ListTile(
                  title: Text(file.location.path),
                  subtitle: Text(file.status.getLocalizedName(context)),
                );
              },
            ));
      },
    );
  }
}
