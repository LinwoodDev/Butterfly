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

typedef ToolPresetItem = ({
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
  final ScrollController _filterScrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late final PackFileSystem _packSystem;
  late final Future<List<ToolPresetItem>> _toolPresetsFuture;
  late final Future<(List<ImportType>, List<ToolPresetItem>)>
  _dialogItemsFuture;
  ToolCategory? _category;
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
    _searchController.dispose();
    _filterScrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    if (_searchFocusNode.hasFocus) return;
    final character = event.character;
    if (character != null &&
        character.isNotEmpty &&
        !event.logicalKey.keyLabel.startsWith('Arrow')) {
      _searchFocusNode.requestFocus();
    }
  }

  Future<List<ToolPresetItem>> _getToolPresets() async {
    final presets = <ToolPresetItem>[];
    final seen = <String>{};
    void addPack(
      NoteData pack, {
      bool useCoreLayout = false,
      required String sourceName,
      required _ToolPresetSource source,
    }) {
      for (final preset in pack.getNamedToolPresets()) {
        final key = jsonEncode({'name': preset.$1, 'tool': preset.$2.toJson()});
        if (seen.add(key)) {
          presets.add((
            name: preset.$1,
            sourceName: sourceName,
            source: source,
            tool: preset.$2,
            useCoreLayout: useCoreLayout,
          ));
        }
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
      if (pack != null) {
        final metadataName = pack.getMetadata()?.name;
        final sourceName = metadataName?.trim().isNotEmpty == true
            ? metadataName!
            : file.pathWithoutLeadingSlash;
        addPack(pack, sourceName: sourceName, source: _ToolPresetSource.pack);
      }
    }
    final state = context.read<DocumentBloc>().state;
    if (state is DocumentLoaded) {
      for (final packName in state.data.getBundledPacks()) {
        final pack = state.data.getBundledPack(packName);
        if (pack != null) {
          final metadataName = pack.getMetadata()?.name;
          addPack(
            pack,
            sourceName: metadataName?.trim().isNotEmpty == true
                ? metadataName!
                : packName,
            source: _ToolPresetSource.bundled,
          );
        }
      }
    }
    return presets;
  }

  Future<List<ImportType>> _getAvailableImports() async {
    final imports = await Future.wait(
      ImportType.values.map((e) async => (e, await e.isAvailable())),
    );
    return imports.where((e) => e.$2).map((e) => e.$1).toList();
  }

  Future<(List<ImportType>, List<ToolPresetItem>)> _getDialogItems() async {
    final imports = await _getAvailableImports();
    try {
      return (imports, await _toolPresetsFuture);
    } catch (_) {
      return (imports, <ToolPresetItem>[]);
    }
  }

  String _getPresetSourceLabel(BuildContext context, ToolPresetItem preset) =>
      preset.sourceName.trim().isEmpty
      ? AppLocalizations.of(context).tools
      : preset.sourceName;

  String _getPresetSourceKey(ToolPresetItem preset) =>
      '${preset.source.index}:${preset.sourceName}';

  @override
  Widget build(BuildContext context) {
    final search = SearchBar(
      focusNode: _searchFocusNode,
      constraints: const BoxConstraints(maxWidth: 350, minHeight: 50),
      leading: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
      hintText: AppLocalizations.of(context).search,
      controller: _searchController,
    );
    return KeyboardListener(
      onKeyEvent: _handleKeyEvent,
      focusNode: FocusNode(),
      autofocus: true,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < LeapBreakpoints.compact;
            return ResponsiveDialog(
              constraints: const BoxConstraints(
                maxWidth: 1100,
                maxHeight: 1000,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      height: 48,
                      child: NavigationToolbar(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton.outlined(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const PhosphorIcon(PhosphorIconsLight.x),
                              tooltip: MaterialLocalizations.of(
                                context,
                              ).closeButtonTooltip,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context).add,
                              style: TextTheme.of(context).headlineSmall,
                            ),
                          ],
                        ),
                        middle: isMobile ? null : search,
                        trailing: IconButton(
                          onPressed: () => openHelp(['add']),
                          icon: const PhosphorIcon(
                            PhosphorIconsLight.sealQuestion,
                          ),
                          tooltip: AppLocalizations.of(context).help,
                        ),
                      ),
                    ),
                  ),
                  if (isMobile)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: search,
                    ),
                  const SizedBox(height: 4),
                  Scrollbar(
                    controller: _filterScrollController,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 2,
                          bottom: 4,
                        ),
                        child: SizedBox(
                          height: 48,
                          child: ListView(
                            controller: _filterScrollController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              ...ToolCategory.values.map(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: ChoiceChip(
                                    label: Text(e.getLocalizedName(context)),
                                    showCheckmark: false,
                                    avatar: PhosphorIcon(
                                      e.icon(PhosphorIconsStyle.light),
                                    ),
                                    onSelected: (selected) => setState(() {
                                      _category = selected ? e : null;
                                    }),
                                    selected: _category == e,
                                  ),
                                ),
                              ),
                              FutureBuilder<List<ToolPresetItem>>(
                                future: _toolPresetsFuture,
                                builder: (context, snapshot) {
                                  final presets =
                                      snapshot.data ?? <ToolPresetItem>[];
                                  final sources = <String, String>{};
                                  for (final preset in presets) {
                                    sources.putIfAbsent(
                                      _getPresetSourceKey(preset),
                                      () => _getPresetSourceLabel(
                                        context,
                                        preset,
                                      ),
                                    );
                                  }
                                  if (sources.length <= 1) {
                                    return const SizedBox.shrink();
                                  }
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const VerticalDivider(width: 16),
                                      ...sources.entries.map(
                                        (entry) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          child: ChoiceChip(
                                            label: Text(entry.value),
                                            showCheckmark: false,
                                            avatar: const PhosphorIcon(
                                              PhosphorIconsLight.package,
                                            ),
                                            onSelected: (selected) {
                                              setState(
                                                () => _packFilter = selected
                                                    ? entry.key
                                                    : null,
                                              );
                                            },
                                            selected: _packFilter == entry.key,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _buildBody(isMobile),
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

  Widget _buildBody(bool isMobile) {
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

    Widget buildTool(ToolPresetItem preset) {
      final tool = preset.tool;
      final handler = Handler.fromTool(tool);
      final caption = tool.getLocalizedCaption(context);
      final disabled =
          handler.getStatus(context.read<DocumentBloc>()) ==
          ToolStatus.disabled;
      final color = disabled ? Theme.of(context).disabledColor : null;
      final title = preset.useCoreLayout
          ? tool.getDisplay(context)
          : preset.name;
      final type = tool.getLocalizedName(context);
      final details = [
        if (!preset.useCoreLayout && type != title) type,
        if (caption.isNotEmpty) caption,
      ].join(' - ');
      return _CategorizedTile(
        category: tool.category,
        child: BoxTile(
          title: Text(title, textAlign: TextAlign.center),
          size: 150,
          subtitle: details.isEmpty
              ? null
              : Text(
                  details,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
          icon: Padding(
            padding: const EdgeInsets.all(4),
            child: PhosphorIcon(
              handler.getIcon(bloc) ?? tool.icon(PhosphorIconsStyle.light),
              color: color,
              textDirection: TextDirection.ltr,
            ),
          ),
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
        ),
      );
    }

    Widget buildImport(ImportType type) {
      return _CategorizedTile(
        category: ToolCategory.import,
        child: BoxTile(
          title: Text(
            type.getLocalizedName(context),
            textAlign: TextAlign.center,
          ),
          size: 150,
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
        ),
      );
    }

    return Material(
      type: MaterialType.transparency,
      key: ValueKey(('add-dialog-body', _category, _packFilter)),
      child: ValueListenableBuilder(
        valueListenable: _searchController,
        builder: (context, value, _) =>
            FutureBuilder<(List<ImportType>, List<ToolPresetItem>)>(
              future: _dialogItemsFuture,
              builder: (context, snapshot) {
                final search = value.text;
                final imports = (snapshot.data?.$1 ?? [])
                    .where(
                      (e) =>
                          _packFilter == null &&
                          (_category == null ||
                              _category == ToolCategory.import),
                    )
                    .where(
                      (e) => e
                          .getLocalizedName(context)
                          .toLowerCase()
                          .contains(search.toLowerCase()),
                    )
                    .map(buildImport);
                final tools = (snapshot.data?.$2 ?? <ToolPresetItem>[])
                    .where(
                      (e) =>
                          _packFilter == null ||
                          _getPresetSourceKey(e) == _packFilter,
                    )
                    .where(
                      (e) => _category == null || e.tool.category == _category,
                    )
                    .where(
                      (e) =>
                          e.name.toLowerCase().contains(search.toLowerCase()) ||
                          e.tool
                              .getDisplay(context)
                              .toLowerCase()
                              .contains(search.toLowerCase()) ||
                          e.tool
                              .getLocalizedCaption(context)
                              .toLowerCase()
                              .contains(search.toLowerCase()),
                    )
                    .map(buildTool);
                final children = [...imports, ...tools];
                return ListView(
                  children: [
                    if (children.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 64,
                          horizontal: 16,
                        ),
                        child: Text(
                          AppLocalizations.of(context).noElements,
                          textAlign: TextAlign.center,
                          style: TextTheme.of(context).bodyLarge,
                        ),
                      )
                    else ...[
                      _ToolsListView(children: children),
                      const SizedBox(height: 16),
                    ],
                  ],
                );
              },
            ),
      ),
    );
  }
}

class _CategorizedTile extends StatelessWidget {
  final ToolCategory category;
  final Widget child;

  const _CategorizedTile({required this.category, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Stack(
      children: [
        child,
        PositionedDirectional(
          top: 8,
          start: 8,
          child: Tooltip(
            message: category.getLocalizedName(context),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: PhosphorIcon(
                  category.icon(PhosphorIconsStyle.light),
                  size: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ToolsListView extends StatelessWidget {
  final List<Widget> children;

  const _ToolsListView({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Wrap(alignment: WrapAlignment.center, children: children),
    );
  }
}
