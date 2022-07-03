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
        List<SyncFile> files = snapshot.data ?? [];
        return Dialog(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Header(
                    title: Text(sync?.status?.getLocalizedName(context) ??
                        AppLocalizations.of(context)!.loading),
                    leading: IconButton(
                      icon: Icon(sync?.status?.getIcon() ??
                          PhosphorIcons.questionLight),
                      onPressed: () => sync?.sync(),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(PhosphorIcons.xLight),
                        onPressed: () => Navigator.pop(context),
                      ),
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
              )),
        );
      },
    );
  }
}
