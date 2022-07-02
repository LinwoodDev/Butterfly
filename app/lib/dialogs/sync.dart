import 'package:butterfly/api/file_system_remote.dart';
import 'package:butterfly/visualizer/sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../services/sync.dart';
import '../widgets/header.dart';

class SyncDialog extends StatelessWidget {
  final String remote;
  const SyncDialog({super.key, required this.remote});

  @override
  Widget build(BuildContext context) {
    final service = context.read<SyncService>();
    final sync = service.getSync(remote);
    return StreamBuilder<List<SyncFile>>(
      stream: sync?.filesStream,
      builder: (context, snapshot) {
        String status = AppLocalizations.of(context)!.synced;
        if (snapshot.hasData) {
          status = AppLocalizations.of(context)!.syncing;
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          status = AppLocalizations.of(context)!.loading;
        }
        List<SyncFile> files = snapshot.data ?? [];
        return Dialog(
            child: Column(
          children: [
            Header(
              title: Text(status),
              actions: [
                IconButton(
                  icon: Icon(
                      sync?.status?.getIcon() ?? PhosphorIcons.questionLight),
                  onPressed: () => sync?.sync(),
                )
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  return Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(file.location.path),
                          subtitle: Text(
                            file.status.getLocalizedName(context),
                          ),
                          leading: Icon(file.status.getIcon()),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ));
      },
    );
  }
}
