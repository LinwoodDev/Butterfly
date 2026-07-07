import 'package:butterfly/visualizer/connection.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../services/sync.dart';
import '../sync.dart';

class SyncButton extends StatelessWidget {
  const SyncButton({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.read<SyncService>();
    return StreamBuilder<SyncOverview>(
      stream: service.overviewStream,
      builder: (context, snapshot) {
        final overview = snapshot.data;
        final status = overview?.status;
        final pendingFiles = overview?.pendingFiles ?? 0;
        final cachedFiles = overview?.cachedFiles ?? 0;
        final button = IconButton(
          icon: status == SyncStatus.syncing
              ? SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: status?.getColor(ColorScheme.of(context)),
                  ),
                )
              : PhosphorIcon(
                  status.getIcon(),
                  textDirection: TextDirection.ltr,
                  color: status?.getColor(ColorScheme.of(context)),
                ),
          tooltip:
              '${status.getLocalizedName(context)} · '
              '$cachedFiles ${AppLocalizations.of(context).caches}',
          onPressed: () => showDialog<void>(
            context: context,
            builder: (context) => const SyncDialog(),
          ),
        );
        if (pendingFiles <= 0) return button;
        return Badge(label: Text(pendingFiles.toString()), child: button);
      },
    );
  }
}
