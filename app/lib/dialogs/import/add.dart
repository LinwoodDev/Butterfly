import 'dart:convert';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/color.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/open.dart';
import '../../bloc/document_bloc.dart';

enum _ToolPresetSource { core, pack, bundled }

typedef _ToolPresetItem = ({
  bool useCoreLayout,
  String name,
  String sourceName,
  _ToolPresetSource source,
  Tool tool,
});

class AddDialog extends StatefulWidget {
  const AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  static const _dialogMaxWidth = 1260.0;
  static const _dialogMaxHeight = 1000.0;
  static const _tileSize = 150.0;
  static const _gap = 4.0;
  static const _headerHeight = 56.0;
  static const _chipBarHeight = 48.0;
  static const _searchMaxWidth = 350.0;

  final _keyboardFocusNode = FocusNode();
  final _chipScrollController = ScrollController();
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  late final PackFileSystem _packSystem;
  late final Future<List<_ToolPresetItem>> _toolPresetsFuture;
  late final Future<(List<ImportType>, List<_ToolPresetItem>)>
  _dialogItemsFuture;

  String? _packFilter;

  @override
  void initState() {
    super.initState();
    _packSystem = context.read<ButterflyFileSystem>().buildDefaultPackSystem();
    _toolPresetsFuture = _getToolPresets();
    _dialogItemsFuture = _getDialogItems();
  }

  @override
  void dispose() {
    _keyboardFocusNode.dispose();
    _chipScrollController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent || _searchFocusNode.hasFocus) return;

    final character = event.character;
    final isPrintable = character != null && character.trim().isNotEmpty;
    final isNavigationKey = event.logicalKey.keyLabel.startsWith('Arrow');

    if (isPrintable && !isNavigationKey) {
      _searchFocusNode.requestFocus();
    }
  }

  Future<List<_ToolPresetItem>> _getToolPresets() async {
    final presets = <_ToolPresetItem>[];
    final seen = <String>{};

    void addPack(
      NoteData pack, {
      bool useCoreLayout = false,
      required String sourceName,
      required _ToolPresetSource source,
    }) {
      for (final preset in pack.getNamedToolPresets()) {
        final key = jsonEncode({'name': preset.$1, 'tool': preset.$2.toJson()});

        if (!seen.add(key)) continue;

        presets.add((
          useCoreLayout: useCoreLayout,
          name: preset.$1,
          sourceName: sourceName,
          source: source,
          tool: preset.$2,
        ));
      }
    }

    final corePack = await DocumentDefaults.getCorePack();
    addPack(
      corePack,
      useCoreLayout: true,
      sourceName: corePack.getMetadata()?.name ?? '',
      source: _ToolPresetSource.core,
    );

    final files = await _packSystem.getFiles();
    for (final file in files) {
      final pack = file.data;
      if (pack == null) continue;

      addPack(
        pack,
        sourceName: _getPackDisplayName(
          pack,
          fallback: file.pathWithoutLeadingSlash,
        ),
        source: _ToolPresetSource.pack,
      );
    }

    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoaded) return presets;

    for (final packName in state.data.getBundledPacks()) {
      final pack = state.data.getBundledPack(packName);
      if (pack == null) continue;

      addPack(
        pack,
        sourceName: _getPackDisplayName(pack, fallback: packName),
        source: _ToolPresetSource.bundled,
      );
    }

    return presets;
  }

  Future<List<ImportType>> _getAvailableImports() async {
    final imports = await Future.wait(
      ImportType.values.map((type) async => (type, await type.isAvailable())),
    );

    return imports
        .where((import) => import.$2)
        .map((import) => import.$1)
        .toList();
  }

  Future<(List<ImportType>, List<_ToolPresetItem>)> _getDialogItems() async {
    final imports = await _getAvailableImports();

    try {
      return (imports, await _toolPresetsFuture);
    } catch (_) {
      return (imports, <_ToolPresetItem>[]);
    }
  }

  String _getPackDisplayName(NoteData pack, {required String fallback}) {
    final metadataName = pack.getMetadata()?.name;
    return metadataName?.trim().isNotEmpty == true ? metadataName! : fallback;
  }

  String _getPresetSourceLabel(BuildContext context, _ToolPresetItem preset) {
    final sourceName = preset.sourceName.trim();
    return sourceName.isEmpty ? AppLocalizations.of(context).tools : sourceName;
  }

  String _getPresetSourceKey(_ToolPresetItem preset) {
    return '${preset.source.index}:${preset.sourceName}';
  }

  bool _isFavoriteTool(Tool tool) {
    return switch (tool) {
      HandTool() ||
      SelectTool() ||
      PenTool() ||
      EraserTool() ||
      LabelTool() ||
      AreaTool() => true,
      _ => false,
    };
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _keyboardFocusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < LeapBreakpoints.compact;

            return ResponsiveDialog(
              constraints: const BoxConstraints(
                maxWidth: _dialogMaxWidth,
                maxHeight: _dialogMaxHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context, isMobile: isMobile),
                  if (isMobile) _buildMobileSearchBar(context),
                  _buildSourceFilterBar(context),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _buildBody(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, {required bool isMobile}) {
    final localizations = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(_gap),
      child: SizedBox(
        height: _headerHeight,
        child: NavigationToolbar(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              IconButton.outlined(
                onPressed: () => Navigator.of(context).pop(),
                icon: const PhosphorIcon(PhosphorIconsLight.x),
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isMobile ? 220 : 360),
                child: Text(
                  '${localizations.add} ${localizations.tool}',
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headlineSmall,
                ),
              ),
            ],
          ),
          middle: isMobile ? null : _buildSearchBar(context),
          trailing: IconButton(
            onPressed: () => openHelp(['add']),
            icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
            tooltip: localizations.help,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return SearchBar(
      controller: _searchController,
      focusNode: _searchFocusNode,
      constraints: const BoxConstraints(
        maxWidth: _searchMaxWidth,
        minHeight: 50,
      ),
      leading: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
      hintText: AppLocalizations.of(context).search,
    );
  }

  Widget _buildMobileSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(_gap, 0, _gap, _gap),
      child: _buildSearchBar(context),
    );
  }

  Widget _buildSourceFilterBar(BuildContext context) {
    return FutureBuilder<List<_ToolPresetItem>>(
      future: _toolPresetsFuture,
      builder: (context, snapshot) {
        final presets = snapshot.data ?? <_ToolPresetItem>[];
        final sources = <String, String>{};

        for (final preset in presets) {
          sources.putIfAbsent(
            _getPresetSourceKey(preset),
            () => _getPresetSourceLabel(context, preset),
          );
        }

        if (sources.length <= 1) return const SizedBox.shrink();

        return SizedBox(
          height: _chipBarHeight,
          child: Scrollbar(
            controller: _chipScrollController,
            child: SingleChildScrollView(
              controller: _chipScrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: _gap),
              child: Row(
                children: [
                  for (final source in sources.entries)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(source.value),
                        showCheckmark: false,
                        avatar: const PhosphorIcon(PhosphorIconsLight.package),
                        selected: _packFilter == source.key,
                        onSelected: (selected) {
                          setState(() {
                            _packFilter = selected ? source.key : null;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    final bloc = context.read<DocumentBloc>();
    final currentIndexCubit = context.read<CurrentIndexCubit>();

    void addTool(Tool tool, {bool updateDefaultColor = true}) {
      final state = bloc.state;
      if (state is! DocumentLoaded) return;

      final background =
          state.page.backgrounds.firstOrNull?.defaultColor ?? SRGBColor.white;
      final copyTool = tool.copyWith(id: tool.id ?? createUniqueId());
      final defaultTool = updateDefaultColor
          ? updateToolDefaultColor(copyTool, background)
          : copyTool;

      bloc.add(ToolCreated(defaultTool));

      if (!defaultTool.isAction()) {
        currentIndexCubit.changeTool(
          bloc,
          index: state.info.tools.length,
          context: context,
          handler: Handler.fromTool(defaultTool),
        );
      }

      Navigator.of(context).pop();
    }

    Widget buildTool(_ToolPresetItem preset, {bool showFavorite = true}) {
      final tool = preset.tool;
      final handler = Handler.fromTool(tool);
      final caption = tool.getLocalizedCaption(context);
      final status = handler.getStatus(bloc);
      final title = preset.useCoreLayout
          ? tool.getDisplay(context)
          : preset.name;
      final type = tool.getLocalizedName(context);
      final details = [
        if (!preset.useCoreLayout && type != title) type,
        if (caption.isNotEmpty) caption,
      ].join(' - ');

      return BoxTile(
        size: _tileSize,
        title: Text(title, textAlign: TextAlign.center),
        subtitle: details.isEmpty
            ? null
            : Text(
                details,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
        icon: Padding(
          padding: const EdgeInsets.all(4),
          child: PhosphorIcon(
            handler.getIcon(bloc) ?? tool.icon(PhosphorIconsStyle.light),
            color: status == ToolStatus.disabled
                ? Theme.of(context).disabledColor
                : null,
            textDirection: TextDirection.ltr,
          ),
        ),
        leading: showFavorite
            ? IconButton(
                onPressed: () {},
                selectedIcon: PhosphorIcon(PhosphorIconsFill.star),
                icon: PhosphorIcon(PhosphorIconsLight.star),
              )
            : null,
        trailing: tool.isAction()
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  handler.onSelected(context, false);
                },
                icon: const PhosphorIcon(PhosphorIconsLight.playCircle),
                tooltip: AppLocalizations.of(context).play,
              )
            : null,
        onTap: () => addTool(
          tool,
          updateDefaultColor: preset.source == _ToolPresetSource.core,
        ),
      );
    }

    Widget buildImport(ImportType type) {
      return BoxTile(
        size: _tileSize,
        title: Text(
          type.getLocalizedName(context),
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          onPressed: () => addTool(Tool.asset(importType: type)),
          tooltip: AppLocalizations.of(context).pin,
          icon: const PhosphorIcon(
            PhosphorIconsLight.pushPin,
            textDirection: TextDirection.ltr,
          ),
        ),
        icon: PhosphorIcon(
          type.icon(PhosphorIconsStyle.light),
          textDirection: TextDirection.ltr,
        ),
        onTap: () async {
          final bloc = context.read<DocumentBloc>();
          final importService = context.read<ImportService>();

          Navigator.of(context).pop();
          await showImportAssetWizard(type, context, bloc, importService);
        },
      );
    }

    return Material(
      key: ValueKey(('add-dialog-body', _packFilter)),
      type: MaterialType.transparency,
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: _searchController,
        builder: (context, value, _) {
          return FutureBuilder<(List<ImportType>, List<_ToolPresetItem>)>(
            future: _dialogItemsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return _buildErrorState(context);
              }

              final (imports, presets) =
                  snapshot.data ?? const (<ImportType>[], <_ToolPresetItem>[]);
              final search = value.text.trim().toLowerCase();

              final importItems = imports
                  .where((type) => _packFilter == null)
                  .where(
                    (type) => type
                        .getLocalizedName(context)
                        .toLowerCase()
                        .contains(search),
                  )
                  .map(buildImport)
                  .toList();

              final toolPresets = presets
                  .where(
                    (preset) =>
                        _packFilter == null ||
                        _getPresetSourceKey(preset) == _packFilter,
                  )
                  .where((preset) => _matchesSearch(context, preset, search))
                  .toList();

              final favoriteTools = toolPresets
                  .where((preset) => _isFavoriteTool(preset.tool))
                  .map((preset) => buildTool(preset, showFavorite: false))
                  .toList();

              final categorizedTools = {
                for (final category in ToolCategory.values)
                  category: <_ToolPresetItem>[],
              };

              for (final preset in toolPresets) {
                categorizedTools[preset.tool.category]!.add(preset);
              }

              final sections = <Widget>[
                if (favoriteTools.isNotEmpty)
                  _buildSection(
                    context,
                    title: 'Favorites',
                    icon: PhosphorIconsLight.star,
                    children: favoriteTools,
                  ),
                for (final category in ToolCategory.values)
                  _buildSection(
                    context,
                    title: category.getLocalizedName(context),
                    icon: category.icon(PhosphorIconsStyle.light),
                    children: category == ToolCategory.import
                        ? [
                            ...importItems,
                            ...categorizedTools[category]!.map(buildTool),
                          ]
                        : categorizedTools[category]!.map(buildTool).toList(),
                  ),
              ].where((section) => section is! SizedBox).toList();

              if (sections.isEmpty) return _buildEmptyState(context);

              return ListView(
                padding: const EdgeInsets.only(bottom: 16),
                children: sections,
              );
            },
          );
        },
      ),
    );
  }

  bool _matchesSearch(
    BuildContext context,
    _ToolPresetItem preset,
    String search,
  ) {
    if (search.isEmpty) return true;

    return preset.name.toLowerCase().contains(search) ||
        preset.tool.getDisplay(context).toLowerCase().contains(search) ||
        preset.tool.getLocalizedName(context).toLowerCase().contains(search) ||
        preset.tool.getLocalizedCaption(context).toLowerCase().contains(search);
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: Text(
          AppLocalizations.of(context).noElements,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: Text(
          'Failed to load elements',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final sectionWidth =
              constraints.maxWidth -
              ((constraints.maxWidth + _gap) % (_tileSize + _gap));

          return Align(
            alignment: AlignmentDirectional.center,
            child: SizedBox(
              width: sectionWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      PhosphorIcon(icon, size: 18),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: _gap),
                  Wrap(spacing: _gap, runSpacing: _gap, children: children),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
