part of '../home.dart';

final _logsSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).logs,
  icon: PhosphorIconsLight.bug,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'content': SettingsLeapSection(
      settings: [
        SettingsLeapBoolSetting(
          displayName: (context) => AppLocalizations.of(context).logs,
          read: (state) => state.showVerboseLogs,
          write: (context, value) =>
              context.read<SettingsCubit>().changeShowVerboseLogs(value),
        ),
      ],
      builder: _logsSection,
      wrapBuilder: false,
      fillRemaining: true,
    ),
  },
);

Widget _logsSection(
  BuildContext context,
  ButterflySettings state,
  Widget child,
) => const LogsSettingsContent();

class LogsSettingsContent extends StatefulWidget {
  const LogsSettingsContent({super.key});

  @override
  State<LogsSettingsContent> createState() => _LogsSettingsContentState();
}

class _LogsSettingsContentState extends State<LogsSettingsContent> {
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
        return Column(
          children: [
            if (_archivedFiles.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Padding(
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
                  ),

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

String _startupBehaviorName(BuildContext context, StartupBehavior value) =>
    switch (value) {
      StartupBehavior.openHomeScreen => AppLocalizations.of(context).homeScreen,
      StartupBehavior.openLastNote => AppLocalizations.of(context).lastNote,
      StartupBehavior.openNewNote => AppLocalizations.of(context).newNote,
    };
