part of 'page.dart';

class _QuickstartHomeView extends StatefulWidget {
  final ExternalStorage? remote;
  final bool isMobile;
  final VoidCallback onReload;

  const _QuickstartHomeView({
    this.remote,
    required this.onReload,
    required this.isMobile,
  });

  @override
  State<_QuickstartHomeView> createState() => _QuickstartHomeViewState();
}

class _QuickstartHomeViewState extends State<_QuickstartHomeView> {
  final ScrollController _scrollController = ScrollController();
  late TemplateFileSystem _templateSystem;
  Future<List<({NoteData file, String remote})>>? _templatesFuture;

  @override
  void initState() {
    super.initState();
    _templateSystem = context.read<ButterflyFileSystem>().buildTemplateSystem(
      widget.remote,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _templatesFuture = _fetchTemplates();
      });
    });
  }

  @override
  void didUpdateWidget(covariant _QuickstartHomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remote != widget.remote) {
      _templateSystem = context.read<ButterflyFileSystem>().buildTemplateSystem(
        widget.remote,
      );
      setState(() {
        _templatesFuture = _fetchTemplates();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<({NoteData file, String remote})>> _fetchTemplates() async {
    if (!mounted) return [];
    final settings = context.read<SettingsCubit>().state;
    final favorites = settings.favoriteTemplates;
    final fileSystem = context.read<ButterflyFileSystem>();
    final coreTemplates = await DocumentDefaults.getCoreTemplates(context);

    final result = <({NoteData file, String remote})>[];

    for (final location in favorites) {
      final remote = location.remote;
      if (remote == null) {
        final template = coreTemplates.firstWhereOrNull(
          (e) => e.name == location.path,
        );
        if (template == null) continue;
        result.add((file: template, remote: settings.defaultRemote));
        continue;
      }
      final templateSystem = fileSystem.buildTemplateSystem(
        settings.getRemote(remote),
      );
      final file = await templateSystem.getFile(location.path);
      if (file == null) continue;
      result.add((file: file, remote: remote));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: EdgeInsets.all(widget.isMobile ? 12 : 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context).quickstart,
                    style: TextTheme.of(context).headlineMedium,
                  ),
                ),
                IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.wrench),
                  tooltip: AppLocalizations.of(context).advanced,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (ctx) => const TemplateDialog(),
                  ),
                ),
                IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.arrowClockwise),
                  tooltip: AppLocalizations.of(context).refresh,
                  onPressed: () => setState(() {
                    _templatesFuture = _fetchTemplates();
                  }),
                ),
              ],
            ),
            SizedBox(height: widget.isMobile ? 8 : 16),
            FutureBuilder<List<({NoteData file, String remote})>>(
              future: _templatesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return ElevatedButton(
                    child: Text(AppLocalizations.of(context).view),
                    onPressed: () => setState(() {
                      _templatesFuture = _fetchTemplates();
                    }),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
                final templates = snapshot.data ?? [];
                if (templates.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).noTemplates,
                        style: TextTheme.of(context).bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () async {
                          await _templateSystem.initialize(force: true);
                          setState(() {
                            _templatesFuture = _fetchTemplates();
                          });
                          widget.onReload();
                        },
                        child: Text(
                          LeapLocalizations.of(context).reset,
                          style: TextTheme.of(context).bodyLarge,
                        ),
                      ),
                    ],
                  );
                }
                final children = templates.map((e) {
                  final data = e.file;
                  final thumbnail = data.getThumbnail();
                  final metadata = data.getMetadata()!;
                  return AssetCard(
                    metadata: metadata,
                    thumbnail: thumbnail,
                    onTap: () async {
                      await openNewDocument(context, false, data, e.remote);
                      widget.onReload();
                    },
                  );
                }).toList();
                if (widget.isMobile) {
                  return SizedBox(
                    height: 150,
                    child: Scrollbar(
                      controller: _scrollController,
                      child: ListView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        children: children,
                      ),
                    ),
                  );
                }
                return Column(children: children);
              },
            ),
          ],
        ),
      ),
    );
  }
}
