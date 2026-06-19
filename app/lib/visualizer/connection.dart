import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/sync.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension FileSyncStatusVisualizer on FileSyncStatus? {
  String getLocalizedName(BuildContext context) => switch (this) {
    FileSyncStatus.localLatest => AppLocalizations.of(context).localLatest,
    FileSyncStatus.remoteLatest => AppLocalizations.of(
      context,
    ).connectionLatest,
    FileSyncStatus.synced => AppLocalizations.of(context).synced,
    FileSyncStatus.conflict => AppLocalizations.of(context).conflict,
    FileSyncStatus.offline => AppLocalizations.of(context).offline,
    _ => AppLocalizations.of(context).loading,
  };

  PhosphorIconData getIcon() => switch (this) {
    FileSyncStatus.localLatest => PhosphorIconsLight.upload,
    FileSyncStatus.remoteLatest => PhosphorIconsLight.download,
    FileSyncStatus.synced => PhosphorIconsLight.check,
    FileSyncStatus.conflict => PhosphorIconsLight.warning,
    FileSyncStatus.offline => PhosphorIconsLight.wifiSlash,
    _ => PhosphorIconsLight.arrowClockwise,
  };

  Color getColor(ColorScheme colorScheme) => switch (this) {
    FileSyncStatus.synced => colorScheme.primary,
    FileSyncStatus.localLatest => colorScheme.secondary,
    FileSyncStatus.remoteLatest => colorScheme.tertiary,
    FileSyncStatus.conflict => colorScheme.error,
    FileSyncStatus.offline => colorScheme.onSurface,
    _ => colorScheme.onSurface,
  };
}

extension SyncStatusVisualizer on SyncStatus? {
  String getLocalizedName(BuildContext context) => switch (this) {
    SyncStatus.syncing => AppLocalizations.of(context).syncing,
    SyncStatus.synced => AppLocalizations.of(context).synced,
    SyncStatus.error => AppLocalizations.of(context).error,
    _ => AppLocalizations.of(context).loading,
  };

  PhosphorIconData getIcon() => switch (this) {
    SyncStatus.synced => PhosphorIconsLight.check,
    SyncStatus.error => PhosphorIconsLight.warning,
    _ => PhosphorIconsLight.arrowClockwise,
  };

  Color getColor(ColorScheme colorScheme) => switch (this) {
    SyncStatus.synced => colorScheme.primary,
    SyncStatus.error => colorScheme.error,
    _ => colorScheme.onSurface,
  };
}

extension SyncModeVisualizer on SyncMode {
  String getLocalizedName(BuildContext context) => switch (this) {
    SyncMode.always => AppLocalizations.of(context).always,
    SyncMode.noMobile => AppLocalizations.of(context).noMobile,
    SyncMode.manual => AppLocalizations.of(context).manual,
  };

  PhosphorIconData getIcon() => switch (this) {
    SyncMode.always => PhosphorIconsLight.wifiHigh,
    SyncMode.noMobile => PhosphorIconsLight.wifiSlash,
    SyncMode.manual => PhosphorIconsLight.arrowClockwise,
  };
}

extension ExternalStorageVisualizer on ExternalStorage {
  IconGetter get typeIcon => switch (this) {
    LocalStorage() => PhosphorIcons.house,
    DavRemoteStorage() => PhosphorIcons.cloud,
  };
  String getLocalizedTypeName(BuildContext context) => switch (this) {
    LocalStorage() => AppLocalizations.of(context).local,
    DavRemoteStorage() => AppLocalizations.of(context).dav,
  };
}

List<ExternalStorage> getSupportedStorages() => [
  const LocalStorage(),
  const DavRemoteStorage(username: '', url: ''),
];
