import 'dart:async';

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/backup.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum _BackupDurationUnit {
  hours(Duration(hours: 1)),
  days(Duration(days: 1)),
  weeks(Duration(days: 7));

  final Duration duration;
  const _BackupDurationUnit(this.duration);
}

Widget buildBackupSetting(BuildContext context, ButterflySettings state) {
  final localizations = AppLocalizations.of(context);
  final settingsCubit = context.read<SettingsCubit>();
  final remotes = state.connections.whereType<RemoteStorage>().toList();
  final selectedRemote =
      remotes.any((storage) => storage.identifier == state.backupRemote)
      ? state.backupRemote
      : null;

  return Column(
    children: [
      ListTile(
        leading: const PhosphorIcon(PhosphorIconsLight.cloudArrowUp),
        title: Text(localizations.backupConnection),
        subtitle: Text(
          remotes
                  .where((storage) => storage.identifier == selectedRemote)
                  .firstOrNull
                  ?.label ??
              localizations.select,
        ),
        trailing: PopupMenuButton<String>(
          enabled: remotes.isNotEmpty,
          icon: const PhosphorIcon(PhosphorIconsLight.caretDown),
          itemBuilder: (context) => remotes
              .map(
                (storage) => PopupMenuItem(
                  value: storage.identifier,
                  child: Text(storage.label),
                ),
              )
              .toList(),
          onSelected: settingsCubit.changeBackupRemote,
        ),
      ),
      SwitchListTile(
        secondary: const PhosphorIcon(PhosphorIconsLight.clockCountdown),
        title: Text(localizations.automaticBackups),
        subtitle: Text(localizations.automaticBackupsDescription),
        value: state.automaticBackup,
        onChanged: selectedRemote == null
            ? null
            : settingsCubit.changeAutomaticBackup,
      ),
      ListTile(
        leading: const PhosphorIcon(PhosphorIconsLight.timer),
        title: Text(localizations.backupInterval),
        subtitle: Text(
          _formatBackupInterval(localizations, state.backupIntervalMinutes),
        ),
        enabled: selectedRemote != null,
        onTap: selectedRemote != null
            ? () => _changeBackupInterval(
                context,
                Duration(minutes: state.backupIntervalMinutes),
              )
            : null,
      ),
      ListTile(
        leading: const PhosphorIcon(PhosphorIconsLight.archive),
        title: Text(localizations.backupNow),
        subtitle: Text(
          state.lastBackup == null
              ? '${localizations.lastBackup}: ${localizations.never}'
              : '${localizations.lastBackup}: ${DateFormat.yMd(Localizations.localeOf(context).languageCode).add_Hm().format(state.lastBackup!.toLocal())}',
        ),
        enabled: selectedRemote != null,
        onTap: selectedRemote == null ? null : () => _runBackupNow(context),
      ),
    ],
  );
}

String _formatBackupInterval(
  AppLocalizations localizations,
  int intervalMinutes,
) {
  const minutesPerHour = 60;
  const minutesPerDay = 24 * minutesPerHour;
  const minutesPerWeek = 7 * minutesPerDay;
  if (intervalMinutes % minutesPerWeek == 0) {
    final value = intervalMinutes ~/ minutesPerWeek;
    return '$value ${value == 1 ? localizations.week : localizations.weeks}';
  }
  if (intervalMinutes % minutesPerDay == 0) {
    final value = intervalMinutes ~/ minutesPerDay;
    return '$value ${value == 1 ? localizations.day : localizations.days}';
  }
  final value = intervalMinutes ~/ minutesPerHour;
  return '$value ${value == 1 ? localizations.hour : localizations.hours}';
}

Future<void> _changeBackupInterval(
  BuildContext context,
  Duration currentInterval,
) async {
  var unit = currentInterval.inDays >= 7 && currentInterval.inDays % 7 == 0
      ? _BackupDurationUnit.weeks
      : currentInterval.inHours >= 24 && currentInterval.inHours % 24 == 0
      ? _BackupDurationUnit.days
      : _BackupDurationUnit.hours;
  final amount = switch (unit) {
    _BackupDurationUnit.hours => currentInterval.inHours,
    _BackupDurationUnit.days => currentInterval.inDays,
    _BackupDurationUnit.weeks => currentInterval.inDays ~/ 7,
  };
  final controller = TextEditingController(text: amount.toString());
  final formKey = GlobalKey<FormState>();
  final localizations = AppLocalizations.of(context);
  final result = await showDialog<Duration>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(localizations.backupInterval),
        content: Form(
          key: formKey,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(filled: true),
                  validator: (value) {
                    final parsed = int.tryParse(value ?? '');
                    return parsed == null || parsed < 1
                        ? LeapLocalizations.of(context).shouldNotEmpty
                        : null;
                  },
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<_BackupDurationUnit>(
                value: unit,
                items: _BackupDurationUnit.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(switch (value) {
                          _BackupDurationUnit.hours => localizations.hours,
                          _BackupDurationUnit.days => localizations.days,
                          _BackupDurationUnit.weeks => localizations.weeks,
                        }),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => unit = value);
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () {
              if (!(formKey.currentState?.validate() ?? false)) return;
              final amount = int.parse(controller.text);
              Navigator.pop(context, unit.duration * amount);
            },
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
          ),
        ],
      ),
    ),
  );
  controller.dispose();
  if (result != null && context.mounted) {
    await context.read<SettingsCubit>().changeBackupInterval(result);
  }
}

Future<void> _runBackupNow(BuildContext context) async {
  final navigator = Navigator.of(context, rootNavigator: true);
  final messenger = ScaffoldMessenger.of(context);
  final localizations = AppLocalizations.of(context);
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(localizations.backup),
        content: const Center(
          widthFactor: 1,
          heightFactor: 1,
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );
  try {
    final fileName = await context.read<BackupService>().backupNow();
    if (navigator.mounted) navigator.pop();
    if (!context.mounted) return;
    messenger.showSnackBar(
      SnackBar(content: Text('${localizations.backupCreated}: $fileName')),
    );
  } catch (error) {
    if (navigator.mounted) navigator.pop();
    if (!context.mounted) return;
    messenger.showSnackBar(SnackBar(content: Text(error.toString())));
  }
}
