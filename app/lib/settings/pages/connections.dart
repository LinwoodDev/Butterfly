part of '../home.dart';

final _connectionsSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).connections,
  icon: PhosphorIconsLight.cloud,
  enabled: (context, state) => !kIsWeb,
  appBarBuilder: _butterflyAppBar,
  actionsBuilder: buildConnectionsSettingsActions,
  floatingActionButtonBuilder: buildConnectionsSettingsFloatingActionButton,
  sections: {
    'content': SettingsLeapSection(
      builder: (context, state, inView) {
        if (kIsWeb) {
          return Center(
            child: Text(AppLocalizations.of(context).webNotSupported),
          );
        }
        if (state.connections.isEmpty) {
          return Center(
            child: Text(AppLocalizations.of(context).noConnections),
          );
        }
        return Material(
          type: .transparency,
          child: ListView.builder(
            itemCount: state.connections.length,
            itemBuilder: (context, index) {
              final remote = state.connections[index];
              return Dismissible(
                key: Key(remote.identifier),
                confirmDismiss: (_) =>
                    showDeleteConnectionDialog(context, remote.label),
                onDismissed: (details) {
                  BlocProvider.of<SettingsCubit>(context)
                      .deleteRemote(remote.identifier);
                },
                child: ListTile(
                  title: Text(remote.label),
                  subtitle:
                      remote is RemoteStorage &&
                          remote.isConnectionEncryptionEnabled
                      ? Text(
                          AppLocalizations.of(context)
                              .documentEncryptionEnabled,
                        )
                      : null,
                  leading: remote.icon?.isEmpty ?? true
                      ? PhosphorIcon(remote.typeIcon())
                      : Image.memory(remote.icon!, width: 32, height: 32),
                  onTap: () =>
                      openConnectionSettings(context, remote.identifier),
                  trailing: IconButton(
                    icon: remote.identifier == state.defaultRemote
                        ? const PhosphorIcon(PhosphorIconsFill.cloud)
                        : const PhosphorIcon(PhosphorIconsLight.cloud),
                    tooltip: remote.identifier == state.defaultRemote
                        ? AppLocalizations.of(context).defaultConnection
                        : AppLocalizations.of(context).notDefaultConnection,
                    onPressed: () {
                      BlocProvider.of<SettingsCubit>(context)
                          .setDefaultRemote(remote.identifier);
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
      wrapBuilder: false,
      fillRemaining: true,
    ),
  },
);

List<Widget> buildConnectionsSettingsActions(
  BuildContext context,
  ButterflySettings state,
) => [
  IconButton(
    icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
    tooltip: AppLocalizations.of(context).help,
    onPressed: () => openHelp(['storage'], 'remote'),
  ),
  IconButton(
    icon: state.defaultRemote.isEmpty
        ? const PhosphorIcon(PhosphorIconsFill.house)
        : const PhosphorIcon(PhosphorIconsLight.house),
    tooltip: state.defaultRemote.isEmpty
        ? AppLocalizations.of(context).defaultConnection
        : AppLocalizations.of(context).notDefaultConnection,
    onPressed: () => context.read<SettingsCubit>().setDefaultRemote(''),
  ),
];

Widget? buildConnectionsSettingsFloatingActionButton(
  BuildContext context,
  ButterflySettings state,
) {
  if (kIsWeb) return null;
  return FloatingActionButton.extended(
    onPressed: () =>
        showLeapBottomSheet<ExternalStorage>(
          context: context,
          titleBuilder: (context) =>
              Text(AppLocalizations.of(context).addConnection),
          childrenBuilder: (context) => getSupportedStorages()
              .map(
                (e) => ListTile(
                  title: Text(e.getLocalizedTypeName(context)),
                  leading: PhosphorIcon(e.typeIcon()),
                  onTap: () => Navigator.pop(context, e),
                ),
              )
              .toList(),
        ).then((value) {
          if (value == null) return;
          showDialog<void>(
            context: context,
            builder: (context) => _AddRemoteDialog(storage: value),
          );
        }),
    label: Text(AppLocalizations.of(context).addConnection),
    icon: const PhosphorIcon(PhosphorIconsLight.plus),
  );
}

bool _isAbsoluteConnectionPath(String path) =>
    path.startsWith('content://') || Directory(path).isAbsolute;

String _formatSha1Uint8List(Uint8List sha1Bytes) {
  // Convert Uint8List to List<int>
  List<int> byteList = sha1Bytes.toList();

  // Convert each byte to its hexadecimal representation
  List<String> hexStrings = byteList
      .map((byte) => byte.toRadixString(16).toUpperCase().padLeft(2, '0'))
      .toList();

  // Join the hexadecimal strings with colons
  String formattedSha1 = hexStrings.join(':');

  return formattedSha1;
}

class _AddRemoteDialog extends StatefulWidget {
  final ExternalStorage storage;

  const _AddRemoteDialog({required this.storage});

  @override
  State<_AddRemoteDialog> createState() => __AddRemoteDialogState();
}

class __AddRemoteDialogState extends State<_AddRemoteDialog> {
  final TextEditingController _nameController = .new(),
      _urlController = TextEditingController(),
      _usernameController = TextEditingController(),
      _passwordController = TextEditingController(),
      _encryptionPasswordController = TextEditingController(),
      _directoryController = TextEditingController(),
      _documentsDirectoryController = TextEditingController(text: 'Documents'),
      _templatesDirectoryController = TextEditingController(text: 'Templates'),
      _packsDirectoryController = TextEditingController(text: 'Packs');
  bool _isConnected = false,
      _advanced = false,
      _showPassword = false,
      _showEncryptionPassword = false,
      _syncRootDirectory = false;

  bool get _isRemote => widget.storage is! LocalStorage;
  final HttpClient _httpClient = .new();
  Uint8List? _icon;

  @override
  void initState() {
    super.initState();
    _isConnected = !_isRemote;
    _httpClient.badCertificateCallback = _onBadCertificate;
  }

  @override
  void dispose() {
    super.dispose();
    _httpClient.close(force: true);
    _nameController.dispose();
    _urlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _encryptionPasswordController.dispose();
    _directoryController.dispose();
    _documentsDirectoryController.dispose();
    _templatesDirectoryController.dispose();
    _packsDirectoryController.dispose();
  }

  String? _certificateSha1;
  bool _badCertificate = false;

  bool _onBadCertificate(X509Certificate cert, String host, int port) {
    final connectionUrl = Uri.tryParse(_urlController.text.trim());
    if (connectionUrl?.scheme != 'https' ||
        connectionUrl?.host != host ||
        connectionUrl?.port != port) {
      return false;
    }
    final sha1 = String.fromCharCodes(cert.sha1);
    if (_certificateSha1 == null) {
      _badCertificate = true;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context).unsecureConnectionTitle),
          content: Text(
            AppLocalizations.of(context)
                .unsecureConnectionMessage(_formatSha1Uint8List(cert.sha1)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _certificateSha1 = sha1;
                Navigator.pop(context);
                _connect();
              },
              child: Text(AppLocalizations.of(context).continueAnyway),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
          ],
        ),
      );
      return false;
    }
    return _certificateSha1 == sha1;
  }

  void _connect() async {
    try {
      final loc = AppLocalizations.of(context);
      final url = Uri.tryParse(_urlController.text.trim());
      if (_urlController.text.isEmpty || url == null) {
        _showCreatingError(loc.urlNotValid);
        return;
      }
      final storage = _buildDavRemoteStorage(url: url.toString());
      final passwordStorage = InMemoryPasswordStorage()
        ..write(storage, _passwordController.text);
      final isConnected = await DavRemoteDirectoryFileSystem.checkConnectivity(
        storage: storage,
        passwordStorage: passwordStorage,
        certificateSha1: _certificateSha1,
      );
      if (!isConnected) {
        _showCreatingError(loc.cannotConnect);
        return;
      }
      setState(() => _isConnected = true);
    } catch (e) {
      if (_badCertificate) {
        _badCertificate = false;
        return;
      }
      _showCreatingError(AppLocalizations.of(context).cannotConnect, e);
    }
  }

  Future<Uint8List?> _getIcon() async {
    if (_icon != null) return _icon;
    if (!_isRemote) return null;
    final baseUrl = Uri.tryParse(_urlController.text.trim());
    if (baseUrl == null) return null;

    try {
      final candidates = await _getIconCandidates(baseUrl);
      for (final candidate in candidates) {
        final bytes = await _fetchBytes(candidate);
        if (bytes == null) continue;

        final icon = await decodeConnectionIcon(bytes);
        if (icon != null) return icon;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<List<Uri>> _getIconCandidates(Uri baseUrl) async {
    final candidates = <Uri>[];
    void addCandidate(Uri? uri) {
      if (uri == null || !uri.hasScheme || candidates.contains(uri)) return;
      candidates.add(uri);
    }

    addCandidate(baseUrl.replace(path: '/favicon.ico', query: ''));

    final htmlPages = <String>[];
    final connectionHtml = await _fetchString(baseUrl);
    if (connectionHtml != null) htmlPages.add(connectionHtml);
    final rootHtml = await _fetchString(baseUrl.replace(path: '/', query: ''));
    if (rootHtml != null && rootHtml != connectionHtml) {
      htmlPages.add(rootHtml);
    }
    for (final html in htmlPages) {
      final document = html_parser.parse(html);
      final icons =
          document.querySelectorAll('link[rel][href]').where((element) {
            final rel = element.attributes['rel']?.toLowerCase() ?? '';
            return rel.split(RegExp(r'\s+')).any((part) => part == 'icon');
          }).toList()..sort((a, b) {
            final aSize = _largestIconSize(a.attributes['sizes']);
            final bSize = _largestIconSize(b.attributes['sizes']);
            return bSize.compareTo(aSize);
          });

      for (final icon in icons) {
        addCandidate(baseUrl.resolve(icon.attributes['href'] ?? ''));
      }
    }

    return candidates;
  }

  int _largestIconSize(String? sizes) {
    if (sizes == null) return 0;
    return RegExp(r'(\d+)x(\d+)').allMatches(sizes).fold(0, (size, match) {
      final width = int.tryParse(match.group(1) ?? '') ?? 0;
      final height = int.tryParse(match.group(2) ?? '') ?? 0;
      return math.max(size, math.max(width, height));
    });
  }

  Future<String?> _fetchString(Uri url) async {
    final bytes = await _fetchBytes(url);
    if (bytes == null) return null;
    return utf8.decode(bytes, allowMalformed: true);
  }

  Future<Uint8List?> _fetchBytes(Uri url) => fetchConnectionIconBytes(
    client: _httpClient,
    connectionUrl: Uri.parse(_urlController.text.trim()),
    url: url,
    username: _usernameController.text,
    password: _passwordController.text,
  );

  Future<void> _create() async {
    final navigator = Navigator.of(context);
    final settingsCubit = context.read<SettingsCubit>();
    final name = _nameController.text.trim();
    final paths = {
      '': _directoryController.text.trim(),
      'documents': _documentsDirectoryController.text.trim(),
      'templates': _templatesDirectoryController.text.trim(),
      'packs': _packsDirectoryController.text.trim(),
    };
    if (!_isRemote &&
        (paths['']!.isEmpty
            ? paths.entries
                  .where((e) => e.key.isNotEmpty && e.value.isNotEmpty)
                  .any((e) => !_isAbsoluteConnectionPath(e.value))
            : !_isAbsoluteConnectionPath(paths['']!))) {
      await _showCreatingError(
        AppLocalizations.of(context).connectionPathRequired,
      );
      return;
    }
    var remoteStorage = switch (widget.storage) {
      DavRemoteStorage() => _buildDavRemoteStorage(),
      LocalStorage() => LocalStorage(name: name, paths: paths),
    };
    if (settingsCubit.state.hasRemote(remoteStorage.identifier)) {
      await _showCreatingError(
        AppLocalizations.of(context).connectionAlreadyExists,
      );
      return;
    }
    remoteStorage = remoteStorage.copyWith(icon: await _getIcon());
    if (remoteStorage is RemoteStorage &&
        _encryptionPasswordController.text.isNotEmpty) {
      await connectionEncryptionPasswordStorage.write(
        remoteStorage,
        _encryptionPasswordController.text,
      );
    }
    await settingsCubit.addRemote(
      remoteStorage,
      password: _passwordController.text,
    );
    navigator.pop();
  }

  DavRemoteStorage _buildDavRemoteStorage({String? url}) {
    return DavRemoteStorage(
      name: _nameController.text.trim(),
      username: _usernameController.text,
      url: url ?? _urlController.text,
      paths: {
        '': _directoryController.text.trim(),
        'documents': _documentsDirectoryController.text.trim(),
        'templates': _templatesDirectoryController.text.trim(),
        'packs': _packsDirectoryController.text.trim(),
      },
      certificateSha1: _certificateSha1,
      pinnedPaths: {
        'documents': [if (_syncRootDirectory) '/'],
      },
      extra: {
        if (_encryptionPasswordController.text.isNotEmpty)
          connectionEncryptionEnabledKey: true,
      },
    );
  }

  Future<void> _showCreatingError(String error, [dynamic e]) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).errorWhileCreatingConnection),
        content: Column(
          mainAxisSize: .min,
          children: [
            Text(error),
            if (e != null)
              Text(e.toString(), style: TextTheme.of(context).bodyLarge),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      constraints: const BoxConstraints(maxWidth: 640, maxHeight: 800),
      title: Text(AppLocalizations.of(context).addConnection),
      headerActions: [
        IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
          tooltip: AppLocalizations.of(context).help,
          onPressed: () =>
              openHelp(['storage'], _isRemote ? 'remote' : 'local'),
        ),
      ],
      content: ListView(
        shrinkWrap: true,
        children: [
          if (_isRemote) ...[
            TextField(
              controller: _urlController,
              readOnly: _isConnected,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).url,
                suffixIcon: _ConnectionHelpButton(
                  message: AppLocalizations.of(context).webDavUrlDescription,
                ),
                filled: true,
                icon: const PhosphorIcon(PhosphorIconsLight.link),
              ),
            ),
            const Divider(height: 32),
          ],
          if (!_isConnected) ...[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).username,
                suffixIcon: _ConnectionHelpButton(
                  message: AppLocalizations.of(context)
                      .connectionUsernameDescription,
                ),
                filled: true,
                icon: const PhosphorIcon(PhosphorIconsLight.user),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: !_showPassword,
              keyboardType: _showPassword
                  ? TextInputType.visiblePassword
                  : TextInputType.text,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).password,
                filled: true,
                suffixIcon: Row(
                  mainAxisSize: .min,
                  children: [
                    IconButton(
                      icon: PhosphorIcon(
                        _showPassword
                            ? PhosphorIconsLight.eye
                            : PhosphorIconsLight.eyeSlash,
                      ),
                      tooltip: _showPassword
                          ? AppLocalizations.of(context).hide
                          : AppLocalizations.of(context).show,
                      onPressed: () =>
                          setState(() => _showPassword = !_showPassword),
                    ),
                    _ConnectionHelpButton(
                      message: AppLocalizations.of(context)
                          .connectionPasswordDescription,
                    ),
                  ],
                ),
                icon: const PhosphorIcon(PhosphorIconsLight.lock),
              ),
            ),
            CheckboxListTile(
              value: _syncRootDirectory,
              onChanged: (value) => setState(
                () => _syncRootDirectory = value ?? _syncRootDirectory,
              ),
              title: Text(AppLocalizations.of(context).syncRootDirectory),
              secondary: _ConnectionHelpButton(
                message: AppLocalizations.of(context)
                    .connectionSyncRootDescription,
              ),
            ),
          ] else ...[
            if (_isRemote) ...[
              TextField(
                controller: _encryptionPasswordController,
                obscureText: !_showEncryptionPassword,
                keyboardType: _showEncryptionPassword
                    ? TextInputType.visiblePassword
                    : TextInputType.text,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)
                      .documentEncryptionPassword,
                  filled: true,
                  suffixIcon: Row(
                    mainAxisSize: .min,
                    children: [
                      IconButton(
                        icon: PhosphorIcon(
                          _showEncryptionPassword
                              ? PhosphorIconsLight.eye
                              : PhosphorIconsLight.eyeSlash,
                        ),
                        tooltip: _showEncryptionPassword
                            ? AppLocalizations.of(context).hide
                            : AppLocalizations.of(context).show,
                        onPressed: () => setState(
                          () => _showEncryptionPassword =
                              !_showEncryptionPassword,
                        ),
                      ),
                      _ConnectionHelpButton(
                        message: AppLocalizations.of(context)
                            .documentEncryptionPasswordDescription,
                      ),
                    ],
                  ),
                  icon: const PhosphorIcon(PhosphorIconsLight.shieldCheck),
                ),
              ),
              const SizedBox(height: 8),
            ],
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: LeapLocalizations.of(context).name,
                suffixIcon: _ConnectionHelpButton(
                  message: AppLocalizations.of(context)
                      .connectionNameDescription,
                ),
                filled: true,
                icon: const PhosphorIcon(
                  PhosphorIconsLight.textAa,
                  textDirection: .ltr,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ConnectionIconField(
              value: _icon,
              fallbackIcon: widget.storage.typeIcon(),
              onChanged: (icon) => setState(() => _icon = icon),
            ),
            const SizedBox(height: 8),
            _DirectoryField(
              controller: _directoryController,
              label: AppLocalizations.of(context).directory,
              help: _isRemote
                  ? AppLocalizations.of(context).connectionDirectoryDescription
                  : AppLocalizations.of(context)
                        .localConnectionDirectoryDescription,
              icon: const PhosphorIcon(
                PhosphorIconsLight.folder,
                textDirection: .ltr,
              ),
              pickDirectory: !_isRemote,
            ),
            const SizedBox(height: 8),
            ExpansionPanelList(
              expansionCallback: (index, isExpanded) =>
                  setState(() => _advanced = isExpanded),
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) => ListTile(
                    title: Text(AppLocalizations.of(context).advanced),
                  ),
                  canTapOnHeader: true,
                  isExpanded: _advanced,
                  body: Column(
                    children: [
                      _DirectoryField(
                        controller: _documentsDirectoryController,
                        label: AppLocalizations.of(context).documentsDirectory,
                        icon: const PhosphorIcon(
                          PhosphorIconsLight.file,
                          textDirection: .ltr,
                        ),
                        help: AppLocalizations.of(context)
                            .connectionPathDescription,
                        pickDirectory: !_isRemote,
                      ),
                      const SizedBox(height: 8),
                      _DirectoryField(
                        controller: _templatesDirectoryController,
                        label: AppLocalizations.of(context).templatesDirectory,
                        icon: const PhosphorIcon(
                          PhosphorIconsLight.fileDashed,
                          textDirection: .ltr,
                        ),
                        help: AppLocalizations.of(context)
                            .connectionPathDescription,
                        pickDirectory: !_isRemote,
                      ),
                      const SizedBox(height: 8),
                      _DirectoryField(
                        controller: _packsDirectoryController,
                        label: AppLocalizations.of(context).packsDirectory,
                        icon: const PhosphorIcon(PhosphorIconsLight.package),
                        help: AppLocalizations.of(context)
                            .connectionPathDescription,
                        pickDirectory: !_isRemote,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_isConnected && _isRemote) {
              setState(() {
                _isConnected = false;
                _certificateSha1 = null;
              });
              return;
            }
            Navigator.of(context).pop();
          },
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        if (_isConnected) ...[
          ListenableBuilder(
            listenable: Listenable.merge([
              _directoryController,
              _documentsDirectoryController,
              _templatesDirectoryController,
              _packsDirectoryController,
            ]),
            builder: (context, _) => ElevatedButton(
              onPressed:
                  _directoryController.text.trim().isEmpty &&
                      _documentsDirectoryController.text.trim().isEmpty &&
                      _templatesDirectoryController.text.trim().isEmpty &&
                      _packsDirectoryController.text.trim().isEmpty
                  ? null
                  : _create,
              child: Text(LeapLocalizations.of(context).create),
            ),
          ),
        ] else ...[
          ElevatedButton(
            onPressed: _connect,
            child: Text(AppLocalizations.of(context).connect),
          ),
        ],
      ],
    );
  }
}

class _DirectoryField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label, help;
  final Widget? icon;
  final bool pickDirectory;

  const _DirectoryField({
    this.controller,
    this.label,
    this.help,
    this.pickDirectory = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        icon: icon,
        filled: true,
        suffixIcon: Row(
          mainAxisSize: .min,
          children: [
            if (pickDirectory)
              IconButton(
                icon: const PhosphorIcon(
                  PhosphorIconsLight.folder,
                  textDirection: .ltr,
                ),
                tooltip: AppLocalizations.of(context).directory,
                onPressed: () async {
                  final path = await FilePicker.getDirectoryPath();
                  if (path != null) controller?.text = path;
                },
              ),
            if (help != null) _ConnectionHelpButton(message: help!),
          ],
        ),
      ),
    );
  }
}

class _ConnectionHelpButton extends StatelessWidget {
  final String message;

  const _ConnectionHelpButton({required this.message});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<TooltipState>();
    return Tooltip(
      key: key,
      message: message,
      triggerMode: TooltipTriggerMode.manual,
      showDuration: const Duration(seconds: 15),
      constraints: BoxConstraints(
        maxWidth: math.min(400, MediaQuery.sizeOf(context).width - 32),
      ),
      padding: const EdgeInsets.all(12),
      child: IconButton(
        icon: const PhosphorIcon(PhosphorIconsLight.info),
        onPressed: () => key.currentState?.ensureTooltipVisible(),
      ),
    );
  }
}
