import 'package:butterfly/api/file_system_remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension SyncStatusVisualizer on SyncStatus {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case SyncStatus.localLatest:
        return AppLocalizations.of(context)!.localLatest;
      case SyncStatus.remoteLatest:
        return AppLocalizations.of(context)!.remoteLatest;
      case SyncStatus.synced:
        return AppLocalizations.of(context)!.synced;
      case SyncStatus.conflict:
        return AppLocalizations.of(context)!.conflict;
      case SyncStatus.offline:
        return AppLocalizations.of(context)!.offline;
    }
  }
}
