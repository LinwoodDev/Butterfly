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
  late final TemplateFileSystem _templateSystem;
  Future<List<NoteData>>? _templatesFuture;

  @override
  void initState() {
    _templateSystem = context.read<ButterflyFileSystem>().buildTemplateSystem(
      widget.remote,
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        _templatesFuture = _fetchTemplates();
      }),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _QuickstartHomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remote != widget.remote) {
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

  Future<List<NoteData>> _fetchTemplates() => _templateSystem.initialize().then(
    (value) => _templateSystem.getFiles().then(
      (value) => value.map((e) => e.data!).toList(),
    ),
  );

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
            FutureBuilder<List<NoteData>>(
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
                  final thumbnail = e.getThumbnail();
                  final metadata = e.getMetadata()!;
                  return AssetCard(
                    metadata: metadata,
                    thumbnail: thumbnail,
                    onTap: () async {
                      await openNewDocument(
                        context,
                        false,
                        e,
                        widget.remote?.identifier,
                      );
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
