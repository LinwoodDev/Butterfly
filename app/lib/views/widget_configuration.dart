import 'dart:async';
import 'dart:convert';

import 'package:butterfly/actions/new.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/views/files/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_file_system/lw_file_system.dart';

const homeWidgetChannel = MethodChannel('linwood.dev/butterfly/widgets');

String _documentRoute(AssetLocation location) => Uri(
  pathSegments: [
    '',
    if (location.isRemote) 'remote' else 'local',
    if (location.isRemote) location.remote,
    ...location.pathWithoutLeadingSlash.split('/'),
  ],
).toString();

Map<String, Object?> _documentJson(
  FileSystemFile<NoteFile> file,
  ButterflySettings settings,
) {
  final data = file.data == null
      ? null
      : displayConnectionNoteFile(
          settings.getRemote(file.location.remote),
          file.data!,
        );
  final title = data?.getMetadata()?.name;
  return {
    'remote': file.location.remote,
    'path': file.location.path,
    'route': _documentRoute(file.location),
    'title': title == null || title.isEmpty
        ? file.location.fileNameWithoutExtension
        : title,
    'thumbnail': data?.getThumbnail() == null
        ? null
        : base64Encode(data!.getThumbnail()!),
  };
}

/// Keeps launcher widgets in sync with Butterfly's existing recent history.
class HomeWidgetSync extends StatefulWidget {
  final Widget child;
  const HomeWidgetSync({super.key, required this.child});

  @override
  State<HomeWidgetSync> createState() => _HomeWidgetSyncState();
}

class _HomeWidgetSyncState extends State<HomeWidgetSync>
    with WidgetsBindingObserver {
  StreamSubscription<ButterflySettings>? _subscription;
  bool _busy = false;
  bool _again = false;

  @override
  void initState() {
    super.initState();
    if (defaultTargetPlatform != TargetPlatform.android || kIsWeb) return;
    final settings = context.read<SettingsCubit>();
    var previousHistory = settings.state.history;
    _subscription = settings.stream.listen((next) {
      if (listEquals(previousHistory, next.history)) return;
      previousHistory = next.history;
      _sync();
    });
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _sync();
  }

  Future<void> _sync() async {
    if (!mounted) return;
    if (_busy) {
      _again = true;
      return;
    }
    _busy = true;
    try {
      final settings = context.read<SettingsCubit>().state;
      final system = context.read<ButterflyFileSystem>();
      final configs =
          await homeWidgetChannel.invokeListMethod<dynamic>('getConfigs') ?? [];
      final previewLocations = <AssetLocation>[];
      for (final raw in configs) {
        if (raw is! Map || raw['kind'] != 'preview') continue;
        previewLocations.add(
          AssetLocation(
            remote: raw['remote'] as String? ?? '',
            path: raw['path'] as String? ?? '',
          ),
        );
      }
      final locations = [...settings.history, ...previewLocations];
      List<FileSystemEntity<NoteFile>> files = [];
      await for (final result
          in GeneralDirectoryFileSystem.fetchAssetsGlobalSync(
            locations,
            system.buildAllDocumentSystems(),
          )) {
        files = result;
      }
      final byLocation = <String, Map<String, Object?>>{};
      for (final file in files) {
        if (file is! FileSystemFile<NoteFile>) continue;
        byLocation[jsonEncode([file.location.remote, file.location.path])] =
            _documentJson(file, settings);
      }
      Map<String, Object?>? find(AssetLocation location) =>
          byLocation[jsonEncode([location.remote, location.path])];
      final recents = [
        for (final location in settings.history) ?find(location),
      ];
      final previews = <String, Object?>{};
      for (final raw in configs) {
        if (raw is! Map || raw['kind'] != 'preview') continue;
        final id = raw['id'];
        if (id is! int) continue;
        previews['$id'] = find(
          AssetLocation(
            remote: raw['remote'] as String? ?? '',
            path: raw['path'] as String? ?? '',
          ),
        );
      }
      await homeWidgetChannel.invokeMethod<void>(
        'update',
        jsonEncode({'recents': recents, 'previews': previews}),
      );
    } catch (error) {
      debugPrint('Could not refresh Android widgets: $error');
    } finally {
      _busy = false;
      if (_again) {
        _again = false;
        _sync();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class WidgetConfigurationPage extends StatefulWidget {
  final int widgetId;
  final String kind;
  const WidgetConfigurationPage({
    super.key,
    required this.widgetId,
    required this.kind,
  });

  @override
  State<WidgetConfigurationPage> createState() =>
      _WidgetConfigurationPageState();
}

class _TemplateChoice {
  final String label;
  final String? core;
  final String? remote;
  final String? path;
  const _TemplateChoice(this.label, {this.core, this.remote, this.path});

  Map<String, Object?> toJson(String kind) => {
    'kind': kind,
    'template': {
      if (core != null) 'core': core,
      if (path != null) 'path': path,
      if (remote != null) 'remote': remote,
    },
  };
}

class _WidgetConfigurationPageState extends State<WidgetConfigurationPage> {
  late final Future<List<_TemplateChoice>> _templates = _loadTemplates();
  Map<String, dynamic>? _configuredTemplate;
  bool _saving = false;

  Future<List<_TemplateChoice>> _loadTemplates() async {
    final raw = widget.kind == 'shortcut'
        ? null
        : await homeWidgetChannel.invokeMethod<String>(
            'getConfig',
            widget.widgetId,
          );
    if (raw != null) {
      final config = jsonDecode(raw) as Map<String, dynamic>;
      _configuredTemplate = config['template'] is Map
          ? Map<String, dynamic>.from(config['template'] as Map)
          : null;
    }
    final fileSystem = context.read<ButterflyFileSystem>();
    final settings = context.read<SettingsCubit>().state;
    final core = await DocumentDefaults.getCoreTemplates(context);
    final choices = <_TemplateChoice>[
      for (var i = 0; i < core.length; i++)
        _TemplateChoice(
          core[i].getMetadata()?.name ?? core[i].name ?? 'Template',
          core: '$i',
        ),
    ];
    for (final remote in [null, ...settings.connections]) {
      final system = fileSystem.buildTemplateSystem(remote);
      try {
        await system.initialize();
        for (final file in await system.getFiles()) {
          if (file.data == null) continue;
          choices.add(
            _TemplateChoice(
              file.data!.getMetadata()?.name ?? file.location.fileName,
              remote: remote?.identifier ?? '',
              path: file.location.path,
            ),
          );
        }
      } catch (error) {
        debugPrint('Could not load widget templates: $error');
      }
    }
    return choices;
  }

  bool _isSelected(_TemplateChoice choice) =>
      _configuredTemplate?['core'] == choice.core &&
      _configuredTemplate?['remote'] == choice.remote &&
      _configuredTemplate?['path'] == choice.path;

  Future<void> _save(Map<String, Object?> config) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      if (widget.kind == 'shortcut') {
        await homeWidgetChannel.invokeMethod<void>(
          'createShortcut',
          jsonEncode(config),
        );
      } else {
        await homeWidgetChannel.invokeMethod<void>('saveConfig', {
          'id': widget.widgetId,
          'config': jsonEncode(config),
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  Future<void> _choosePreview(FileSystemEntity<NoteFile> entity) async {
    if (entity is! FileSystemFile<NoteFile>) return;
    final location = entity.location;
    final settings = context.read<SettingsCubit>().state;
    final system = context.read<ButterflyFileSystem>().buildDocumentSystem(
      settings.getRemote(location.remote),
    );
    FileSystemFile<NoteFile> file = entity;
    try {
      await for (final asset in system.fetchAsset(
        location.path,
        readData: true,
      )) {
        if (asset is FileSystemFile<NoteFile>) file = asset;
      }
      if (!mounted) return;
      await _save({'kind': 'preview', ..._documentJson(file, settings)});
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        widget.kind == 'preview'
            ? 'Choose document for widget'
            : 'Choose template for new document',
      ),
    ),
    body: _saving
        ? const Center(child: CircularProgressIndicator())
        : widget.kind == 'preview'
        ? FilesView(isMobile: true, isPage: true, onTap: _choosePreview)
        : FutureBuilder<List<_TemplateChoice>>(
            future: _templates,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.auto_awesome_outlined),
                    title: const Text('Use default template'),
                    trailing: _configuredTemplate == null
                        ? const Icon(Icons.check)
                        : null,
                    onTap: () => _save({'kind': widget.kind}),
                  ),
                  for (final choice in snapshot.data!)
                    ListTile(
                      leading: const Icon(Icons.description_outlined),
                      title: Text(choice.label),
                      trailing: _isSelected(choice)
                          ? const Icon(Icons.check)
                          : null,
                      onTap: () => _save(choice.toJson(widget.kind)),
                    ),
                ],
              );
            },
          ),
  );
}

class WidgetCreatePage extends StatefulWidget {
  final int widgetId;
  final String? shortcutConfig;
  const WidgetCreatePage({
    super.key,
    required this.widgetId,
    this.shortcutConfig,
  });

  @override
  State<WidgetCreatePage> createState() => _WidgetCreatePageState();
}

class _WidgetCreatePageState extends State<WidgetCreatePage> {
  Object? error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _create());
  }

  Future<void> _create() async {
    try {
      final raw =
          widget.shortcutConfig ??
          await homeWidgetChannel.invokeMethod<String>(
            'getConfig',
            widget.widgetId,
          );
      final config = raw == null
          ? null
          : jsonDecode(raw) as Map<String, dynamic>;
      final template = config?['template'];
      NoteData? data;
      String? remote;
      if (template is! Map) {
        final system = context
            .read<ButterflyFileSystem>()
            .buildDefaultTemplateSystem();
        final settings = context.read<SettingsCubit>().state;
        data = await system.getDefaultFile(
          system.storage?.defaults['template'] ?? settings.defaultTemplate,
        );
      } else if (template['core'] is String) {
        final index = int.parse(template['core'] as String);
        final core = await DocumentDefaults.getCoreTemplates(context);
        if (index < 0 || index >= core.length) {
          throw RangeError.index(index, core);
        }
        data = core[index];
      } else {
        remote = template['remote'] as String? ?? '';
        final storage = context.read<SettingsCubit>().state.getRemote(remote);
        data = await context
            .read<ButterflyFileSystem>()
            .buildTemplateSystem(storage)
            .getFile(template['path'] as String);
      }
      if (template is Map && data == null) {
        throw StateError('Selected template is unavailable');
      }
      if (!mounted) return;
      await openNewDocument(context, true, template: data, remote: remote);
    } catch (cause) {
      if (mounted) setState(() => error = cause);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('New document')),
    body: Center(
      child: error == null
          ? const CircularProgressIndicator()
          : Text('Could not create document: $error'),
    ),
  );
}
