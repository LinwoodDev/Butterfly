import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/dialogs/import/add.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly/widgets/option_button.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../cubits/settings.dart';
import '../handlers/handler.dart';

class EditToolbar extends StatefulWidget {
  final bool isMobile;
  final bool? centered;
  final Axis direction;

  const EditToolbar({
    super.key,
    required this.isMobile,
    this.centered,
    this.direction = Axis.horizontal,
  });

  @override
  State<EditToolbar> createState() => _EditToolbarState();
}

enum _MouseState { normal, multi }

class _EditToolbarState extends State<EditToolbar> {
  final ScrollController _scrollController = ScrollController();

  _MouseState _mouseState = _MouseState.normal;

  @override
  void initState() {
    super.initState();

    HardwareKeyboard.instance.addHandler(_handleKey);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKey);
    super.dispose();
  }

  bool _handleKey(KeyEvent event) {
    if (HardwareKeyboard.instance.isControlPressed) {
      _mouseState = _MouseState.multi;
    } else {
      _mouseState = _MouseState.normal;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: _scrollController,
        child: SizedBox(
          height: widget.direction == Axis.horizontal ? 60 : null,
          width: widget.direction == Axis.horizontal ? null : 80,
          child: BlocBuilder<SettingsCubit, ButterflySettings>(
              buildWhen: (previous, current) =>
                  previous.inputConfiguration != current.inputConfiguration ||
                  previous.fullScreen != current.fullScreen,
              builder: (context, settings) {
                final shortcuts = settings.inputConfiguration.getShortcuts();
                return BlocBuilder<DocumentBloc, DocumentState>(
                  buildWhen: (previous, current) =>
                      previous is! DocumentLoadSuccess ||
                      current is! DocumentLoadSuccess ||
                      previous.tool != current.tool ||
                      previous.info.tools != current.info.tools,
                  builder: (context, state) {
                    if (state is! DocumentLoadSuccess) return Container();
                    final tools = state.info.tools;

                    return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                      buildWhen: (previous, current) =>
                          previous.index != current.index ||
                          previous.handler != current.handler ||
                          previous.temporaryHandler !=
                              current.temporaryHandler ||
                          previous.selection != current.selection,
                      builder: (context, currentIndex) {
                        return Card(
                          elevation: 10,
                          child: _buildBody(
                            state,
                            currentIndex,
                            settings,
                            tools,
                            shortcuts,
                          ),
                        );
                      },
                    );
                  },
                );
              }),
        ));
  }

  Widget _buildIcon(PhosphorIconData data, bool action, [Color? color]) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          PhosphorIcon(
            data,
            color: color,
          ),
          SizedBox(
            width: 8,
            child: action
                ? PhosphorIcon(
                    PhosphorIconsLight.playCircle,
                    size: 16,
                    color: color,
                  )
                : null,
          ),
        ],
      );
  ListView _buildBody(
    DocumentLoadSuccess state,
    CurrentIndex currentIndex,
    ButterflySettings settings,
    List<Tool> tools,
    Set<int> shortcuts,
  ) {
    final temp = currentIndex.temporaryHandler;
    final tempData = temp?.data;
    PhosphorIconData icon = PhosphorIconsLight.cube;
    PhosphorIconData iconFilled = PhosphorIconsFill.cube;
    var tooltip = tempData?.name.trim();
    if (tooltip?.isEmpty ?? false) {
      if (tempData is Tool) {
        tooltip = tempData.getLocalizedName(context);
        icon = tempData.icon(PhosphorIconsStyle.light);
        iconFilled = tempData.icon(PhosphorIconsStyle.fill);
      }
    }
    tooltip ??= '';
    int lastReorderable = 0;
    return ListView(
        controller: _scrollController,
        scrollDirection: widget.direction,
        shrinkWrap: true,
        children: [
          if (state.embedding?.editable ?? true) ...[
            if (temp != null && tempData != null) ...[
              OptionButton(
                tooltip: tooltip,
                selected: true,
                highlighted:
                    currentIndex.selection?.selected.contains(tempData) ??
                        false,
                icon: PhosphorIcon(icon),
                selectedIcon: PhosphorIcon(iconFilled),
                onLongPressed: () =>
                    context.read<CurrentIndexCubit>().changeSelection(tempData),
                onPressed: () {
                  if (tempData == null) return;
                  if (_mouseState == _MouseState.multi) {
                    context
                        .read<CurrentIndexCubit>()
                        .insertSelection(tempData, true);
                  } else {
                    context
                        .read<CurrentIndexCubit>()
                        .changeSelection(tempData, true);
                  }
                },
              ),
              const VerticalDivider(),
            ],
            ReorderableListView.builder(
              shrinkWrap: true,
              buildDefaultDragHandles: false,
              scrollDirection: widget.direction,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tools.length + 1,
              itemBuilder: (context, i) {
                if (tools.length <= i) {
                  final add = Padding(
                    padding: widget.direction == Axis.horizontal
                        ? const EdgeInsets.all(8)
                        : const EdgeInsets.all(16),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: FloatingActionButton.small(
                        tooltip: AppLocalizations.of(context).add,
                        heroTag: null,
                        onPressed: () {
                          final bloc = context.read<DocumentBloc>();
                          final cubit = context.read<CurrentIndexCubit>();
                          final importService = context.read<ImportService>();
                          showDialog(
                            context: context,
                            builder: (ctx) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(value: bloc),
                                BlocProvider.value(value: cubit),
                              ],
                              child: RepositoryProvider.value(
                                value: importService,
                                child: AddDialog(),
                              ),
                            ),
                          );
                        },
                        child: const PhosphorIcon(PhosphorIconsLight.plus),
                      ),
                    ),
                  );

                  if (widget.direction == Axis.horizontal) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      key: const Key('add-horizontal'),
                      children: [
                        const VerticalDivider(),
                        add,
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      key: const Key('add-vertical'),
                      children: [
                        const Divider(),
                        add,
                      ],
                    );
                  }
                }
                var e = tools[i];
                final selected = i == currentIndex.index;
                final highlighted = currentIndex.selection?.selected
                        .any((element) => element.hashCode == e.hashCode) ??
                    false;
                String tooltip = e.name.trim();
                if (tooltip.isEmpty) {
                  tooltip = e.getLocalizedName(context);
                }

                final bloc = context.read<DocumentBloc>();

                final handler = Handler.fromTool(e);

                final color = handler.getStatus(context.read<DocumentBloc>()) ==
                        ToolStatus.disabled
                    ? Theme.of(context).disabledColor
                    : null;
                var icon = handler.getIcon(bloc) ??
                    e.icon(selected
                        ? PhosphorIconsStyle.fill
                        : PhosphorIconsStyle.light);
                final toolWidget = Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: OptionButton(
                        tooltip: tooltip,
                        onLongPressed: selected || highlighted
                            ? null
                            : () => context
                                .read<CurrentIndexCubit>()
                                .insertSelection(e, true),
                        onSecondaryPressed: () => context
                            .read<CurrentIndexCubit>()
                            .changeSelection(e),
                        focussed: shortcuts.contains(i),
                        selected: selected,
                        highlighted: highlighted,
                        selectedIcon: _buildIcon(icon, e.isAction(), color),
                        icon: _buildIcon(icon, e.isAction(), color),
                        onPressed: () {
                          if (_mouseState == _MouseState.multi) {
                            context
                                .read<CurrentIndexCubit>()
                                .insertSelection(e, true);
                          } else if (!selected || temp != null) {
                            context.read<CurrentIndexCubit>().resetSelection();
                            context.read<CurrentIndexCubit>().changeTool(
                                  context.read<DocumentBloc>(),
                                  i,
                                  handler,
                                );
                          } else {
                            context
                                .read<CurrentIndexCubit>()
                                .changeSelection(e, true);
                          }
                        }));
                return ReorderableDelayedDragStartListener(
                  index: i,
                  key: ObjectKey(i),
                  enabled: selected || highlighted,
                  child: toolWidget,
                );
              },
              onReorderStart: (index) => lastReorderable = index,
              onReorderEnd: (index) {
                if (lastReorderable != index) return;
                context
                    .read<CurrentIndexCubit>()
                    .insertSelection(tools[index], true);
              },
              onReorder: (oldIndex, newIndex) {
                if (oldIndex == newIndex) {
                  return;
                }
                final bloc = context.read<DocumentBloc>();
                final delete = newIndex > tools.length;
                if (delete) {
                  bloc.add(ToolsRemoved([oldIndex]));
                  return;
                }
                bloc.add(ToolReordered(oldIndex, newIndex));
              },
            ),
            IconButton(
              icon: const PhosphorIcon(PhosphorIconsLight.wrench),
              tooltip: AppLocalizations.of(context).tools,
              selectedIcon: const PhosphorIcon(PhosphorIconsFill.wrench),
              isSelected: currentIndex.selection?.selected
                      .any((element) => element is UtilitiesState) ??
                  false,
              onPressed: () {
                final cubit = context.read<CurrentIndexCubit>();
                final state = cubit.state.cameraViewport.utilities.element;
                cubit.changeSelection(state);
              },
            ),
            if (settings.fullScreen && tools.every((e) => e is! FullScreenTool))
              IconButton(
                icon: const PhosphorIcon(PhosphorIconsLight.arrowsIn),
                tooltip: AppLocalizations.of(context).exitFullScreen,
                onPressed: () {
                  context.read<SettingsCubit>().setFullScreen(false);
                },
              ),
            BlocBuilder<CurrentIndexCubit, CurrentIndex>(
              builder: (context, currentIndex) {
                final utilitiesState = currentIndex.utilitiesState;
                Widget buildButton(
                        bool selected,
                        UtilitiesState Function() update,
                        PhosphorIconData icon,
                        String title) =>
                    CheckboxMenuButton(
                      value: selected,
                      trailingIcon: PhosphorIcon(icon),
                      onChanged: (value) => context
                          .read<CurrentIndexCubit>()
                          .updateUtilities(utilities: update()),
                      child: Text(title),
                    );

                return MenuAnchor(
                  menuChildren: [
                    buildButton(
                      utilitiesState.lockZoom,
                      () => utilitiesState.copyWith(
                        lockZoom: !utilitiesState.lockZoom,
                      ),
                      PhosphorIconsLight.magnifyingGlassPlus,
                      AppLocalizations.of(context).zoom,
                    ),
                    buildButton(
                      utilitiesState.lockHorizontal,
                      () => utilitiesState.copyWith(
                        lockHorizontal: !utilitiesState.lockHorizontal,
                      ),
                      PhosphorIconsLight.arrowsHorizontal,
                      AppLocalizations.of(context).horizontal,
                    ),
                    buildButton(
                      utilitiesState.lockVertical,
                      () => utilitiesState.copyWith(
                        lockVertical: !utilitiesState.lockVertical,
                      ),
                      PhosphorIconsLight.arrowsVertical,
                      AppLocalizations.of(context).vertical,
                    ),
                  ],
                  style: const MenuStyle(
                    alignment: Alignment.bottomLeft,
                  ),
                  builder: defaultMenuButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.lockKey),
                    tooltip: AppLocalizations.of(context).lock,
                  ),
                );
              },
            ),
          ],
        ]);
  }
}
