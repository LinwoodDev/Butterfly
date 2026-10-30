import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/import/confirmation.dart';
import 'package:butterfly/dialogs/packs/bundled.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/save.dart';
import '../../widgets/connection_button.dart';
import 'pack.dart';
import 'widgets.dart';

class PacksDialog extends StatefulWidget {
  final bool globalOnly;
  const PacksDialog({super.key, this.globalOnly = false});

  @override
  State<PacksDialog> createState() => _PacksDialogState();
}

class _PacksDialogState extends State<PacksDialog> {
  late final ButterflyFileSystem _fileSystem;
  late PackFileSystem _packSystem;
  ExternalStorage? _storage;
  late Future<List<FileSystemFile<NoteData>>> _packsFuture;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fileSystem = context.read<ButterflyFileSystem>();
    _storage = _fileSystem.settingsCubit.state.getDefaultRemote();
    _packSystem = _fileSystem.buildPackSystem(_storage);
    _packsFuture = _getPacks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<FileSystemFile<NoteData>>> _getPacks() {
    final system = _packSystem;
    return system.initialize().then((_) => system.getFiles());
  }

  void _refresh() {
    if (!mounted) return;
    setState(() {
      _packsFuture = _getPacks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return FutureBuilder<List<FileSystemFile<NoteData>>>(
      future: _packsFuture,
      builder: (context, snapshot) {
        final width = snapshot.hasData && snapshot.data!.length <= 1
            ? 560.0
            : 880.0;
        return ResponsiveAlertDialog(
          constraints: BoxConstraints(maxWidth: width, maxHeight: 820),
          title: Text(loc.packs),
          clipBehavior: .antiAlias,
          headerActions: [
            IconButton(
              icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
              tooltip: loc.help,
              onPressed: () => openHelp(['pack']),
            ),
            MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.archive),
                  onPressed: () => _exportPacks(),
                  child: Text(loc.packagedFile),
                ),
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(
                    PhosphorIconsLight.file,
                    textDirection: .ltr,
                  ),
                  onPressed: () => _exportPacks(isTextBased: true),
                  child: Text(loc.rawFile),
                ),
              ],
              builder: defaultMenuButton(
                icon: const PhosphorIcon(PhosphorIconsLight.export),
                tooltip: loc.export,
              ),
            ),
            ConnectionButton(
              currentRemote: _storage?.identifier ?? '',
              onChanged: (value) {
                setState(() {
                  _storage = value;
                  _packSystem = _fileSystem.buildPackSystem(value);
                  _packsFuture = _getPacks();
                });
              },
            ),
          ],
          leading: IconButton.outlined(
            onPressed: () => Navigator.of(context).pop(),
            icon: const PhosphorIcon(PhosphorIconsLight.x),
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          ),
          contentBuilder: (context, fullscreen) => SizedBox(
            width: width,
            height: fullscreen ? double.infinity : null,
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SearchBar(
                    controller: _searchController,
                    constraints: const BoxConstraints(minHeight: 50),
                    hintText: loc.search,
                    leading: const PhosphorIcon(
                      PhosphorIconsLight.magnifyingGlass,
                    ),
                    trailing: [
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          tooltip: MaterialLocalizations.of(context)
                              .clearButtonTooltip,
                          icon: const PhosphorIcon(PhosphorIconsLight.x),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        ),
                    ],
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                Flexible(
                  fit: fullscreen ? FlexFit.tight : FlexFit.loose,
                  child: _buildPacks(context, snapshot),
                ),
              ],
            ),
          ),
          actions: _buildActions(context),
        );
      },
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return [
      if (!widget.globalOnly)
        TextButton.icon(
          icon: const PhosphorIcon(PhosphorIconsLight.cube),
          label: Text(loc.bundledPacks),
          onPressed: () async {
            final bloc = context.read<DocumentBloc>();
            await showDialog(
              context: context,
              builder: (context) => BlocProvider.value(
                value: bloc,
                child: BundledPacksDialog(onRefresh: _refresh),
              ),
            );
          },
        ),
      MenuAnchor(
        menuChildren: [
          MenuItemButton(
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.arrowSquareIn),
            onPressed: _importPack,
            child: Text(loc.import),
          ),
          MenuItemButton(
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.cube),
            onPressed: _importCorePack,
            child: Text(loc.importCorePack),
          ),
        ],
        builder: (context, controller, child) => OutlinedButton.icon(
          icon: const PhosphorIcon(PhosphorIconsLight.downloadSimple),
          label: Text(loc.import),
          onPressed: () =>
              controller.isOpen ? controller.close() : controller.open(),
        ),
      ),
      ElevatedButton.icon(
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
        label: Text(loc.createPack),
        onPressed: _createPack,
      ),
    ];
  }

  Widget _buildPacks(
    BuildContext context,
    AsyncSnapshot<List<FileSystemFile<NoteData>>> snapshot,
  ) {
    final loc = AppLocalizations.of(context);
    if (snapshot.hasError) {
      return SizedBox(
        height: 200,
        child: PackEmptyState(
          icon: PhosphorIconsLight.warningCircle,
          title: loc.error,
          description: snapshot.error.toString(),
          action: OutlinedButton.icon(
            onPressed: _refresh,
            icon: const PhosphorIcon(PhosphorIconsLight.arrowClockwise),
            label: Text(loc.refresh),
          ),
        ),
      );
    }
    if (snapshot.connectionState != ConnectionState.done) {
      return const SizedBox(
        height: 160,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    final query = _searchController.text.trim().toLowerCase();
    final packs =
        (snapshot.data ?? []).where((file) {
          final pack = file.data;
          if (pack == null) return false;
          final metadata = pack.getMetadata();
          return [
            getPackDisplayName(pack, file.pathWithoutLeadingSlash),
            metadata?.author ?? '',
            metadata?.description ?? '',
          ].any((text) => text.toLowerCase().contains(query));
        }).toList()..sort(
          (a, b) => getPackDisplayName(a.data!, a.path).toLowerCase().compareTo(
            getPackDisplayName(b.data!, b.path).toLowerCase(),
          ),
        );
    if (packs.isEmpty) {
      return SizedBox(
        height: 200,
        child: PackEmptyState(
          icon: query.isEmpty
              ? PhosphorIconsLight.package
              : PhosphorIconsLight.magnifyingGlass,
          title: query.isEmpty ? loc.noPacks : loc.searchNoResults,
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = ((constraints.maxWidth + 12) / (300 + 12))
            .floor()
            .clamp(1, 3);
        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisExtent:
                224 *
                MediaQuery.textScalerOf(context)
                    .scale(1)
                    .clamp(1, double.infinity),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: packs.length,
          itemBuilder: (context, index) => _buildPackCard(packs[index]),
        );
      },
    );
  }

  Widget _buildPackCard(FileSystemFile<NoteData> file) {
    final loc = AppLocalizations.of(context);
    final pack = file.data!;
    final metadata = pack.getMetadata();
    final colors = ColorScheme.of(context);
    final details = [
      if (metadata?.author.isNotEmpty ?? false) loc.byAuthor(metadata!.author),
      if (metadata?.description.isNotEmpty ?? false) metadata!.description,
    ].join(' · ');
    return ContextRegion(
      tooltip: loc.actions,
      menuChildren: [
        if (!widget.globalOnly)
          MenuItemButton(
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.cube),
            onPressed: () => context.read<DocumentBloc>().add(PackAdded(pack)),
            child: Text(loc.bundlePackInDocument),
          ),
        SubmenuButton(
          leadingIcon: const PhosphorIcon(PhosphorIconsLight.export),
          menuChildren: [
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.archive),
              onPressed: () => exportData(context, pack),
              child: Text(loc.packagedFile),
            ),
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.file),
              onPressed: () => exportData(context, pack, isTextBased: true),
              child: Text(loc.rawFile),
            ),
          ],
          child: Text(loc.export),
        ),
        MenuItemButton(
          leadingIcon: const PhosphorIcon(PhosphorIconsLight.trash),
          onPressed: () async {
            final system = _packSystem;
            await system.deleteFile(file.path);
            _refresh();
          },
          child: Text(loc.delete),
        ),
      ],
      builder: (context, button, controller) => Card(
        margin: EdgeInsets.zero,
        clipBehavior: .antiAlias,
        child: InkWell(
          onTap: () => _editPack(file),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        getPackDisplayName(pack, file.pathWithoutLeadingSlash),
                        maxLines: 1,
                        softWrap: false,
                        overflow: .ellipsis,
                        style: TextTheme.of(context).titleMedium,
                      ),
                    ),
                    const SizedBox(width: 8),
                    button,
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    details,
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: TextTheme.of(context).bodyMedium
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 32),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    heightFactor: 1,
                    child: PackAssetCounts(pack: pack),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createPack() async {
    final storage = _storage;
    final pack = await showDialog<NoteData>(
      context: context,
      builder: (_) => const PackDialog(),
    );
    if (pack != null) await _addPack(pack, storage: storage);
  }

  Future<void> _editPack(FileSystemFile<NoteData> file) async {
    final system = _packSystem;
    final bloc = context.read<DocumentBloc?>();
    final pack = await showDialog<NoteData>(
      context: context,
      builder: (_) {
        final dialog = PackDialog(pack: file.data);
        return bloc == null
            ? dialog
            : BlocProvider.value(value: bloc, child: dialog);
      },
    );
    if (pack == null) return;
    await system.updateFile(file.path, pack);
    _refresh();
  }

  Future<void> _importPack() async {
    final storage = _storage;
    final (data, _, name) = await importFile(context, [
      AssetFileType.note,
      AssetFileType.textNote,
    ]);
    if (data == null || !mounted) return;
    final pack = NoteData.fromData(data);
    final metadata = pack.getMetadata();
    if (metadata?.type != NoteFileType.pack) return;
    final success = await showDialog<bool>(
      context: context,
      builder: (context) => PackImportConfirmationDialog(pack: metadata!),
    );
    if (success == true) await _addPack(pack, storage: storage, name: name);
  }

  Future<void> _importCorePack() async {
    final system = _packSystem;
    final storage = _storage;
    final pack = await DocumentDefaults.getCorePack();
    try {
      await system.deleteFile(kCorePackFileName);
    } catch (_) {}
    await _addPack(pack, storage: storage, name: kCorePackFileName);
  }

  Future<void> _addPack(
    NoteData pack, {
    required ExternalStorage? storage,
    String? name,
  }) async {
    await _fileSystem.createPack(pack, name: name, storage: storage);
    _refresh();
  }

  Future<void> _exportPacks({bool isTextBased = false}) async {
    final archive = Archive();
    final files = await _packSystem.getFiles();
    for (final file in files) {
      final data = file.data!.toFile(isTextBased: isTextBased).data;
      archive.addFile(
        ArchiveFile(
          '${file.fileNameWithoutExtension}.${isTextBased ? 'tbfly' : 'bfly'}',
          data.length,
          data,
        ),
      );
    }
    await exportZip(context, ZipEncoder().encodeBytes(archive));
  }
}
