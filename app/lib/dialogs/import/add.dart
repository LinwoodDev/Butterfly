import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/color.dart';
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

class AddDialog extends StatefulWidget {
  const AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final ScrollController _filterScrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  ToolCategory? _category;

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
                maxWidth: 1050,
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
    void addTool(Tool tool) {
      final state = bloc.state;
      if (state is! DocumentLoaded) return;
      final background =
          state.page.backgrounds.firstOrNull?.defaultColor ?? SRGBColor.white;
      final defaultTool = updateToolDefaultColor(tool, background);
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

    Widget buildTool(Tool tool) {
      final caption = tool.getLocalizedCaption(context);
      final handler = Handler.fromTool(tool);
      final color =
          handler.getStatus(context.read<DocumentBloc>()) == ToolStatus.disabled
          ? Theme.of(context).disabledColor
          : null;
      return BoxTile(
        title: Text(
          tool.getLocalizedName(context),
          textAlign: TextAlign.center,
        ),
        size: 140,
        subtitle: caption.isEmpty ? null : Text(caption),
        icon: Padding(
          padding: const EdgeInsets.all(4.0),
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
        onTap: () => addTool(tool),
      );
    }

    return Material(
      type: MaterialType.transparency,
      key: ValueKey(('add-dialog-body', _category)),
      child: ValueListenableBuilder(
        valueListenable: _searchController,
        builder: (context, value, _) => FutureBuilder<List<ImportType>>(
          future: Future.wait(
            ImportType.values.map((e) async => (e, await e.isAvailable())),
          ).then((value) => value.where((e) => e.$2).map((e) => e.$1).toList()),
          builder: (context, snapshot) {
            final search = value.text;
            final imports = (snapshot.data ?? [])
                .where(
                  (e) => e
                      .getLocalizedName(context)
                      .toLowerCase()
                      .contains(search.toLowerCase()),
                )
                .toList();
            final tools =
                [
                      Tool.hand,
                      () => Tool.select(mode: SelectMode.lasso),
                      () => Tool.select(mode: SelectMode.rectangle),
                      Tool.pen,
                      Tool.laser,
                      Tool.pathEraser,
                      Tool.label,
                      Tool.eraser,
                      Tool.area,
                      Tool.presentation,
                      Tool.polygon,
                      () => Tool.spacer(axis: Axis2D.vertical),
                      () => Tool.spacer(axis: Axis2D.horizontal),
                      Tool.stamp,
                      ...[
                        PathShape.circle,
                        PathShape.rectangle,
                        PathShape.line,
                        PathShape.triangle,
                      ].map(
                        (e) =>
                            () =>
                                Tool.shape(property: ShapeProperty(shape: e())),
                      ),
                      ...[SurfaceTexture.pattern].map(
                        (e) =>
                            () => TextureTool(texture: e()),
                      ),
                      Tool.undo,
                      Tool.redo,
                      Tool.fullScreen,
                      Tool.collection,
                      Tool.eyeDropper,
                      Tool.ruler,
                      Tool.grid,
                      ...BarcodeType.values.map(
                        (e) =>
                            () => Tool.barcode(barcodeType: e),
                      ),
                    ]
                    .map((e) => e())
                    .where((e) => _category == null || e.category == _category)
                    .where(
                      (e) =>
                          e
                              .getLocalizedName(context)
                              .toLowerCase()
                              .contains(search.toLowerCase()) ||
                          e
                              .getLocalizedCaption(context)
                              .toLowerCase()
                              .contains(search.toLowerCase()),
                    )
                    .toList();
            return ListView(
              children: [
                if ((_category == null || _category == ToolCategory.import) &&
                    imports.isNotEmpty) ...[
                  _ToolsListView(
                    isMobile: isMobile && _category == null,
                    children: imports
                        .map(
                          (e) => BoxTile(
                            title: Text(
                              e.getLocalizedName(context),
                              textAlign: TextAlign.center,
                            ),
                            trailing: IconButton(
                              onPressed: () =>
                                  addTool(Tool.asset(importType: e)),
                              tooltip: AppLocalizations.of(context).pin,
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.pushPin,
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                            icon: PhosphorIcon(
                              e.icon(PhosphorIconsStyle.light),
                              textDirection: TextDirection.ltr,
                            ),
                            onTap: () async {
                              final bloc = context.read<DocumentBloc>();
                              final importService = context
                                  .read<ImportService>();
                              Navigator.of(context).pop();
                              await showImportAssetWizard(
                                e,
                                context,
                                bloc,
                                importService,
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                if (tools.isEmpty && imports.isEmpty)
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
                  ),
                if (tools.isNotEmpty) ...[
                  _ToolsListView(
                    isMobile: false,
                    title: imports.isEmpty || _category != null
                        ? null
                        : AppLocalizations.of(context).tools,
                    children: tools.map(buildTool).toList(),
                  ),
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

class _ToolsListView extends StatefulWidget {
  final List<Widget> children;
  final bool isMobile;
  final String? title;

  const _ToolsListView({
    required this.children,
    this.title,
    required this.isMobile,
  });

  @override
  State<_ToolsListView> createState() => _ToolsListViewState();
}

class _ToolsListViewState extends State<_ToolsListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: TextTheme.of(context).bodyLarge,
            textAlign: TextAlign.center,
          ),
        if (widget.isMobile)
          SizedBox(
            height: 130,
            child: Scrollbar(
              controller: _scrollController,
              child: ListView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                children: widget.children,
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(4),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: widget.children,
            ),
          ),
      ],
    );
  }
}
