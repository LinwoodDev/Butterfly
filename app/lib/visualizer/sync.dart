import 'package:butterfly/api/file_system/file_system_remote.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension FileSyncStatusVisualizer on FileSyncStatus? {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case FileSyncStatus.localLatest:
        return AppLocalizations.of(context).localLatest;
      case FileSyncStatus.remoteLatest:
        return AppLocalizations.of(context).connectionLatest;
      case FileSyncStatus.synced:
        return AppLocalizations.of(context).synced;
      case FileSyncStatus.conflict:
        return AppLocalizations.of(context).conflict;
      case FileSyncStatus.offline:
        return AppLocalizations.of(context).offline;
      default:
        return AppLocalizations.of(context).loading;
    }
  }

  PhosphorIconData getIcon() {
    switch (this) {
      case FileSyncStatus.localLatest:
        return PhosphorIconsLight.upload;
      case FileSyncStatus.remoteLatest:
        return PhosphorIconsLight.download;
      case FileSyncStatus.synced:
        return PhosphorIconsLight.check;
      case FileSyncStatus.conflict:
        return PhosphorIconsLight.warning;
      case FileSyncStatus.offline:
        return PhosphorIconsLight.wifiSlash;
      default:
        return PhosphorIconsLight.arrowClockwise;
    }
  }

  Color getColor(ColorScheme colorScheme) {
    switch (this) {
      case FileSyncStatus.synced:
        return colorScheme.primary;
      case FileSyncStatus.localLatest:
        return colorScheme.secondary;
      case FileSyncStatus.remoteLatest:
        return colorScheme.tertiary;
      case FileSyncStatus.conflict:
        return colorScheme.error;
      case FileSyncStatus.offline:
        return colorScheme.onSurface;
      default:
        return colorScheme.onSurface;
    }
  }
}

extension SyncStatusVisualizer on SyncStatus? {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case SyncStatus.syncing:
        return AppLocalizations.of(context).syncing;
      case SyncStatus.synced:
        return AppLocalizations.of(context).synced;
      case SyncStatus.error:
        return AppLocalizations.of(context).error;
      default:
        return AppLocalizations.of(context).loading;
    }
  }

  PhosphorIconData getIcon() {
    switch (this) {
      case SyncStatus.syncing:
        return PhosphorIconsLight.arrowClockwise;
      case SyncStatus.synced:
        return PhosphorIconsLight.check;
      case SyncStatus.error:
        return PhosphorIconsLight.warning;
      default:
        return PhosphorIconsLight.arrowClockwise;
    }
  }

  Color getColor(ColorScheme colorScheme) {
    switch (this) {
      case SyncStatus.syncing:
        return colorScheme.onSurface;
      case SyncStatus.synced:
        return colorScheme.primary;
      case SyncStatus.error:
        return colorScheme.error;
      default:
        return colorScheme.onSurface;
    }
  }
}

extension SyncModeVisualizer on SyncMode {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case SyncMode.always:
        return AppLocalizations.of(context).always;
      case SyncMode.noMobile:
        return AppLocalizations.of(context).noMobile;
      case SyncMode.manual:
        return AppLocalizations.of(context).manual;
    }
  }

  PhosphorIconData getIcon() {
    switch (this) {
      case SyncMode.always:
        return PhosphorIconsLight.wifiHigh;
      case SyncMode.noMobile:
        return PhosphorIconsLight.wifiSlash;
      case SyncMode.manual:
        return PhosphorIconsLight.arrowClockwise;
    }
  }
}
