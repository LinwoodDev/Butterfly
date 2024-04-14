import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/color.dart';
import 'package:butterfly/main.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly/widgets/responsive_dialog.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/open.dart';
import '../../bloc/document_bloc.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final currentIndexCubit = context.read<CurrentIndexCubit>();
    void addTool(Tool tool) {
      final state = bloc.state;
      if (state is! DocumentLoaded) return;
      final background =
          state.page.backgrounds.firstOrNull?.defaultColor ?? BasicColors.white;
      final defaultTool = updateToolDefaultColor(tool, background);
      bloc.add(ToolCreated(defaultTool));
      currentIndexCubit.changeTool(
        bloc,
        index: state.info.tools.length,
        handler: Handler.fromTool(defaultTool),
      );
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
        size: 120,
        subtitle: caption.isEmpty ? null : Text(caption),
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PhosphorIcon(
            tool.icon(PhosphorIconsStyle.light),
            color: color,
          ),
        ),
        trailing: tool.isAction()
            ? IconButton(
                onPressed: () => handler.onSelected(context),
                icon: const PhosphorIcon(PhosphorIconsLight.playCircle),
                tooltip: AppLocalizations.of(context).play,
              )
            : null,
        onTap: () => addTool(tool),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) => ResponsiveDialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 950,
            maxHeight: 800,
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.outlined(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const PhosphorIcon(PhosphorIconsLight.x),
                    tooltip: AppLocalizations.of(context).close,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    AppLocalizations.of(context).add,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Align(
                    child: SearchBar(
                      constraints:
                          const BoxConstraints(maxWidth: 200, minHeight: 50),
                      leading: const PhosphorIcon(
                          PhosphorIconsLight.magnifyingGlass),
                      hintText: AppLocalizations.of(context).search,
                      controller: _searchController,
                    ),
                  )),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => openHelp(['add']),
                    icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
                    tooltip: AppLocalizations.of(context).help,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Material(
                type: MaterialType.transparency,
                child: ValueListenableBuilder(
                  valueListenable: _searchController,
                  builder: (context, value, _) => FutureBuilder<
                          List<ImportType>>(
                      future: Future.wait(ImportType.values
                              .map((e) async => (e, await e.isAvailable())))
                          .then((value) => value
                              .where((e) => e.$2)
                              .map((e) => e.$1)
                              .toList()),
                      builder: (context, snapshot) {
                        final isMobile = constraints.maxWidth <= kMobileWidth;
                        final search = value.text;
                        final imports = (snapshot.data ?? [])
                            .where((e) => e
                                .getLocalizedName(context)
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                            .toList();
                        final tools = [
                          Tool.hand,
                          () => Tool.select(mode: SelectMode.lasso),
                          () => Tool.select(mode: SelectMode.rectangle),
                          Tool.pen,
                          Tool.stamp,
                          Tool.laser,
                          Tool.pathEraser,
                          Tool.label,
                          Tool.eraser,
                          Tool.layer,
                          Tool.area,
                          Tool.presentation,
                          () => Tool.spacer(axis: Axis2D.vertical),
                          () => Tool.spacer(axis: Axis2D.horizontal),
                          Tool.eyeDropper,
                        ]
                            .map((e) => e())
                            .where((e) => e
                                .getLocalizedName(context)
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                            .toList();
                        final shapes = [
                          PathShape.circle,
                          PathShape.rectangle,
                          PathShape.line,
                          PathShape.triangle,
                        ]
                            .map((e) => e())
                            .where((e) => e
                                .getLocalizedName(context)
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                            .toList();
                        final textures = [SurfaceTexture.pattern]
                            .map((e) => e())
                            .where((e) => e
                                .getLocalizedName(context)
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                            .toList();
                        final actions = [
                          Tool.undo,
                          Tool.redo,
                          Tool.fullSceen,
                        ]
                            .map((e) => e())
                            .where((e) => e
                                .getLocalizedName(context)
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                            .toList();
                        return BlocBuilder<DocumentBloc, DocumentState>(
                            builder: (context, state) => ListView(
                                  children: [
                                    if (imports.isNotEmpty) ...[
                                      _ToolsListView(
                                        isMobile: isMobile,
                                        title:
                                            AppLocalizations.of(context).import,
                                        children: imports
                                            .map(
                                              (e) => BoxTile(
                                                title: Text(
                                                  e.getLocalizedName(context),
                                                  textAlign: TextAlign.center,
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () => addTool(
                                                      Tool.asset(
                                                          importType: e)),
                                                  tooltip: AppLocalizations.of(
                                                          context)
                                                      .pin,
                                                  icon: const PhosphorIcon(
                                                      PhosphorIconsLight
                                                          .pushPin),
                                                ),
                                                icon: PhosphorIcon(e.icon(
                                                    PhosphorIconsStyle.light)),
                                                onTap: () async {
                                                  final bloc = context
                                                      .read<DocumentBloc>();
                                                  final importService = context
                                                      .read<ImportService>();
                                                  Navigator.of(context).pop();
                                                  await showImportAssetWizard(
                                                      e,
                                                      context,
                                                      bloc,
                                                      importService);
                                                },
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                    if (tools.isNotEmpty) ...[
                                      _ToolsListView(
                                        isMobile: isMobile,
                                        title:
                                            AppLocalizations.of(context).tools,
                                        children: tools.map(buildTool).toList(),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                    if (shapes.isNotEmpty ||
                                        textures.isNotEmpty) ...[
                                      _ToolsListView(
                                        isMobile: isMobile,
                                        title: AppLocalizations.of(context)
                                            .surface,
                                        children: [
                                          ...shapes.map((e) => BoxTile(
                                                title: Text(
                                                  e.getLocalizedName(context),
                                                  textAlign: TextAlign.center,
                                                ),
                                                icon: Icon(e.icon(
                                                    PhosphorIconsStyle.light)),
                                                onTap: () => addTool(ShapeTool(
                                                    property: ShapeProperty(
                                                        shape: e))),
                                              )),
                                          ...textures.map((e) => BoxTile(
                                                title: Text(
                                                  e.getLocalizedName(context),
                                                  textAlign: TextAlign.center,
                                                ),
                                                icon: Icon(e.icon(
                                                    PhosphorIconsStyle.light)),
                                                onTap: () => addTool(
                                                    TextureTool(texture: e)),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                    if (actions.isNotEmpty) ...[
                                      _ToolsListView(
                                        isMobile: isMobile,
                                        title: AppLocalizations.of(context)
                                            .actions,
                                        children:
                                            actions.map(buildTool).toList(),
                                      ),
                                    ],
                                  ],
                                ));
                      }),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _ToolsListView extends StatelessWidget {
  final List<Widget> children;
  final bool isMobile;
  final String title;
  final ScrollController _scrollController = ScrollController();

  _ToolsListView({
    required this.children,
    required this.title,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        if (isMobile)
          SizedBox(
            height: 130,
            child: Scrollbar(
              controller: _scrollController,
              child: ListView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                children: children,
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(4),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: children,
            ),
          )
      ],
    );
  }
}
