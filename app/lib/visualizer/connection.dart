import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/sync.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension FileSyncStatusVisualizer on FileSyncStatus? {
  String getLocalizedName(BuildContext context) => switch (this) {
    .localLatest => AppLocalizations.of(context).localLatest,
    .remoteLatest => AppLocalizations.of(context).connectionLatest,
    .synced => AppLocalizations.of(context).synced,
    .conflict => AppLocalizations.of(context).conflict,
    .offline => AppLocalizations.of(context).offline,
    _ => AppLocalizations.of(context).loading,
  };

  PhosphorIconData getIcon() => switch (this) {
    .localLatest => PhosphorIconsLight.upload,
    .remoteLatest => PhosphorIconsLight.download,
    .synced => PhosphorIconsLight.check,
    .conflict => PhosphorIconsLight.warning,
    .offline => PhosphorIconsLight.wifiSlash,
    _ => PhosphorIconsLight.arrowClockwise,
  };

  Color getColor(ColorScheme colorScheme) => switch (this) {
    .synced => colorScheme.primary,
    .localLatest => colorScheme.secondary,
    .remoteLatest => colorScheme.tertiary,
    .conflict => colorScheme.error,
    .offline => colorScheme.onSurface,
    _ => colorScheme.onSurface,
  };
}

extension SyncStatusVisualizer on SyncStatus? {
  String getLocalizedName(BuildContext context) => switch (this) {
    .syncing => AppLocalizations.of(context).syncing,
    .synced => AppLocalizations.of(context).synced,
    .error => AppLocalizations.of(context).error,
    _ => AppLocalizations.of(context).loading,
  };

  PhosphorIconData getIcon() => switch (this) {
    .synced => PhosphorIconsLight.check,
    .error => PhosphorIconsLight.warning,
    _ => PhosphorIconsLight.arrowClockwise,
  };

  Color getColor(ColorScheme colorScheme) => switch (this) {
    .synced => colorScheme.primary,
    .error => colorScheme.error,
    _ => colorScheme.onSurface,
  };
}

extension SyncModeVisualizer on SyncMode {
  String getLocalizedName(BuildContext context) => switch (this) {
    .always => AppLocalizations.of(context).always,
    .noMobile => AppLocalizations.of(context).noMobile,
    .manual => AppLocalizations.of(context).manual,
  };

  PhosphorIconData getIcon() => switch (this) {
    .always => PhosphorIconsLight.wifiHigh,
    .noMobile => PhosphorIconsLight.wifiSlash,
    .manual => PhosphorIconsLight.arrowClockwise,
  };
}

extension ExternalStorageVisualizer on ExternalStorage {
  PhosphorIconData typeIcon({bool filled = false}) => switch (this) {
    LocalStorage() =>
      filled ? PhosphorIconsFill.house : PhosphorIconsLight.house,
    DavRemoteStorage() =>
      filled ? PhosphorIconsFill.cloud : PhosphorIconsLight.cloud,
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
