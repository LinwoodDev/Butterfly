import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/logger.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LogsSettingsPage extends StatefulWidget {
  final bool inView;
  const LogsSettingsPage({super.key, this.inView = false});

  @override
  State<LogsSettingsPage> createState() => _LogsSettingsPageState();
}

class _LogsSettingsPageState extends State<LogsSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      builder: (context, state) {
        talker.configure(
          settings: talker.settings.copyWith(
            useConsoleLogs: state.showVerboseLogs,
          ),
        );
        return Scaffold(
          backgroundColor: widget.inView ? Colors.transparent : null,
          appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
            title: Text(AppLocalizations.of(context).logs),
            backgroundColor: widget.inView ? Colors.transparent : null,
            inView: widget.inView,
            actions: [
              IconButton(
                icon: const PhosphorIcon(PhosphorIconsLight.copy),
                tooltip: AppLocalizations.of(context).copy,
                onPressed: () {
                  final text = talker.history
                      .map((e) => e.generateTextMessage())
                      .join('\n');
                  Clipboard.setData(ClipboardData(text: text));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context).copyTitle),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const PhosphorIcon(PhosphorIconsLight.trash),
                tooltip: AppLocalizations.of(context).delete,
                onPressed: () {
                  talker.cleanHistory();
                  setState(() {});
                },
              ),
            ],
          ),
          body: Column(
            children: [
              SwitchListTile(
                title: const Text('Show verbose logs'),
                value: state.showVerboseLogs,
                onChanged: (value) {
                  context.read<SettingsCubit>().changeShowVerboseLogs(value);
                },
              ),
              Expanded(
                child: StreamBuilder(
                  stream: talker.stream,
                  builder: (context, snapshot) {
                    final logs = talker.history.where((element) {
                      if (state.showVerboseLogs) return true;
                      return element.logLevel != LogLevel.verbose &&
                          element.logLevel != LogLevel.debug;
                    }).toList();
                    if (logs.isEmpty) {
                      return const Center(child: Text('No logs'));
                    }
                    return ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final log = logs[logs.length - 1 - index];
                        return _LogTile(log: log);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LogTile extends StatelessWidget {
  final TalkerData log;
  const _LogTile({required this.log});

  @override
  Widget build(BuildContext context) {
    Color? color;
    switch (log.logLevel) {
      case LogLevel.error:
      case LogLevel.critical:
        color = Colors.red;
        break;
      case LogLevel.warning:
        color = Colors.orange;
        break;
      case LogLevel.verbose:
      case LogLevel.debug:
        color = Colors.grey;
        break;
      case LogLevel.info:
      default:
        break;
    }

    return ListTile(
      title: Text(
        log.generateTextMessage(),
        style: TextStyle(color: color),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(DateFormat('HH:mm:ss').format(log.time)),
      trailing: IconButton(
        icon: const PhosphorIcon(PhosphorIconsLight.copy),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: log.generateTextMessage()));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).copyTitle)),
          );
        },
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(log.title ?? 'Log'),
            content: SingleChildScrollView(
              child: SelectableText(log.generateTextMessage()),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: log.generateTextMessage()),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context).copyTitle),
                    ),
                  );
                },
                child: Text(AppLocalizations.of(context).copy),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
