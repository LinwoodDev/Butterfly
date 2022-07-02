import 'package:butterfly/api/file_system_remote.dart';
import 'package:butterfly/services/sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension FileSyncStatusVisualizer on FileSyncStatus {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case FileSyncStatus.localLatest:
        return AppLocalizations.of(context)!.localLatest;
      case FileSyncStatus.remoteLatest:
        return AppLocalizations.of(context)!.remoteLatest;
      case FileSyncStatus.synced:
        return AppLocalizations.of(context)!.synced;
      case FileSyncStatus.conflict:
        return AppLocalizations.of(context)!.conflict;
      case FileSyncStatus.offline:
        return AppLocalizations.of(context)!.offline;
    }
  }

  IconData getIcon() {
    switch (this) {
      case FileSyncStatus.localLatest:
        return PhosphorIcons.uploadLight;
      case FileSyncStatus.remoteLatest:
        return PhosphorIcons.downloadLight;
      case FileSyncStatus.synced:
        return PhosphorIcons.checkLight;
      case FileSyncStatus.conflict:
        return PhosphorIcons.warningCircleLight;
      case FileSyncStatus.offline:
        return PhosphorIcons.wifiSlashLight;
    }
  }
}

extension SyncStatusVisualizer on SyncStatus {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case SyncStatus.syncing:
        return AppLocalizations.of(context)!.syncing;
      case SyncStatus.synced:
        return AppLocalizations.of(context)!.synced;
      case SyncStatus.error:
        return AppLocalizations.of(context)!.error;
    }
  }

  IconData getIcon() {
    switch (this) {
      case SyncStatus.syncing:
        return PhosphorIcons.arrowClockwiseLight;
      case SyncStatus.synced:
        return PhosphorIcons.checkLight;
      case SyncStatus.error:
        return PhosphorIcons.warningLight;
    }
  }
}
