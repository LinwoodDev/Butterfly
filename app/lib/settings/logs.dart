import 'dart:io';
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
  List<File> _archivedFiles = [];
  File? _selectedFile;
  List<TalkerData> _selectedArchivedLogs = [];

  @override
  void initState() {
    super.initState();
    _loadArchiveList();
  }

  Future<void> _loadArchiveList() async {
    final archives = await getArchivedLogs();
    setState(() {
      _archivedFiles = archives;
    });
  }

  Future<void> _selectArchive(File? file) async {
    if (file == null) {
      setState(() {
        _selectedFile = null;
        _selectedArchivedLogs = [];
      });
      return;
    }
    final logs = await loadArchivedLogFile(file);
    setState(() {
      _selectedFile = file;
      _selectedArchivedLogs = logs;
    });
  }

  String _getFileName(File file) {
    try {
      final name = file.path.split(Platform.pathSeparator).last;
      return name.replaceAll('logs_', '').replaceAll('.json', '');
    } catch (_) {
      return 'Archive';
    }
  }

  Widget _buildList(List<TalkerData> allLogs, bool showVerbose) {
    final logs = allLogs.where((element) {
      if (showVerbose) return true;
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
  }

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
                  final sourceLogs = _selectedFile == null
                      ? talker.history
                      : _selectedArchivedLogs;
                  final text = sourceLogs
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
                  clearPersistedLogs();
                  _loadArchiveList();
                  _selectArchive(null);
                  setState(() {});
                },
              ),
            ],
          ),
          body: Column(
            children: [
              if (_archivedFiles.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: DropdownMenuFormField<File?>(
                    initialSelection: _selectedFile,
                    expandedInsets: EdgeInsets.zero,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: null,
                        label: AppLocalizations.of(context).currentVersion,
                      ),
                      ..._archivedFiles.map(
                        (file) => DropdownMenuEntry(
                          value: file,
                          label: _getFileName(file),
                        ),
                      ),
                    ],
                    onSelected: _selectArchive,
                  ),
                ),
              SwitchListTile(
                title: const Text('Show verbose logs'),
                value: state.showVerboseLogs,
                onChanged: (value) {
                  context.read<SettingsCubit>().changeShowVerboseLogs(value);
                },
              ),
              Expanded(
                child: _selectedFile == null
                    ? StreamBuilder(
                        stream: talker.stream,
                        builder: (context, snapshot) {
                          return _buildList(
                            talker.history,
                            state.showVerboseLogs,
                          );
                        },
                      )
                    : _buildList(_selectedArchivedLogs, state.showVerboseLogs),
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
