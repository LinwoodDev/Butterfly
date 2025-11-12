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
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

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
    _scrollController.dispose();
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

  Axis get direction => widget.isMobile ? Axis.horizontal : widget.direction;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        controller: _scrollController,
        child: BlocBuilder<SettingsCubit, ButterflySettings>(
          buildWhen: (previous, current) =>
              previous.inputConfiguration != current.inputConfiguration ||
              previous.toolbarSize != current.toolbarSize ||
              previous.toolbarRows != current.toolbarRows ||
              previous.toolbarPosition != current.toolbarPosition,
          builder: (context, settings) {
            final shortcuts = settings.inputConfiguration.getShortcuts();
            final size = settings.toolbarSize.size;
            final fullSize = (size + 4) * settings.toolbarRows;
            return SizedBox(
              height: direction == Axis.horizontal ? fullSize : null,
              width: direction == Axis.horizontal ? null : fullSize,
              child: BlocBuilder<DocumentBloc, DocumentState>(
                builder: (context, state) {
                  if (state is! DocumentLoadSuccess) return Container();
                  final tools = state.info.tools;

                  return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                    buildWhen: (previous, current) =>
                        previous.index != current.index ||
                        previous.handler != current.handler ||
                        previous.toggleableHandlers !=
                            current.toggleableHandlers ||
                        previous.temporaryHandler != current.temporaryHandler ||
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
                          size,
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIcon(PhosphorIconData data, double size, [Color? color]) =>
      PhosphorIcon(data, size: size * (6 / 16), color: color);
  ListView _buildBody(
    DocumentLoadSuccess state,
    CurrentIndex currentIndex,
    ButterflySettings settings,
    List<Tool> tools,
    Set<InputMapping> shortcuts,
    double size,
  ) {
    final isMobile = widget.isMobile;
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
    return ListView(
      controller: _scrollController,
      scrollDirection: direction,
      shrinkWrap: true,
      children: [
        if (state.embedding?.editable ?? true) ...[
          if (temp != null && tempData != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Center(
                child: SizedBox.square(
                  dimension: size,
                  child: OptionButton(
                    tooltip: tooltip,
                    selected: true,
                    highlighted:
                        currentIndex.selection?.selected.contains(tempData) ??
                        false,
                    icon: _buildIcon(icon, size),
                    selectedIcon: _buildIcon(iconFilled, size),
                    onLongPressed: () => context
                        .read<CurrentIndexCubit>()
                        .changeSelection(tempData),
                    onPressed: () {
                      if (_mouseState == _MouseState.multi) {
                        context.read<CurrentIndexCubit>().insertSelection(
                          tempData,
                          true,
                        );
                      } else {
                        context.read<CurrentIndexCubit>().changeSelection(
                          tempData,
                          true,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            const VerticalDivider(),
          ],
          ReorderableGridView.count(
            shrinkWrap: true,
            scrollDirection: direction,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: settings.toolbarRows,
            childAspectRatio: 1,
            itemDragEnable: (index) => index != tools.length,
            buildDefaultDragHandles: false,
            children: List.generate(tools.length + 1, (i) {
              if (tools.length <= i) {
                final add = Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: FloatingActionButton.small(
                      tooltip: AppLocalizations.of(context).add,
                      heroTag: null,
                      onPressed: () {
                        final bloc = context.read<DocumentBloc>();
                        final cubit = context.read<CurrentIndexCubit>();
                        final importService = context.read<ImportService>();
                        showGeneralDialog(
                          context: context,
                          pageBuilder: (ctx, _, _) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(value: bloc),
                              BlocProvider.value(value: cubit),
                            ],
                            child: RepositoryProvider.value(
                              value: importService,
                              child: const AddDialog(),
                            ),
                          ),
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(
                            context,
                          ).modalBarrierDismissLabel,
                          transitionDuration: const Duration(milliseconds: 200),
                          transitionBuilder:
                              (context, animation, secondaryAnimation, child) {
                                // Animate the dialog from bottom to center
                                return SlideTransition(
                                  position:
                                      Tween<Offset>(
                                            begin: const Offset(0, 1),
                                            end: Offset.zero,
                                          )
                                          .chain(
                                            CurveTween(
                                              curve: Curves.easeOutQuart,
                                            ),
                                          )
                                          .animate(animation),
                                  child: child,
                                );
                              },
                        );
                      },
                      child: PhosphorIcon(
                        PhosphorIconsLight.plus,
                        size: size * 3 / 7,
                      ),
                    ),
                  ),
                );
                return direction == Axis.horizontal
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        key: const Key('add-row'),
                        children: [
                          const VerticalDivider(),
                          Expanded(child: add),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        key: const Key('add-column'),
                        children: [
                          const Divider(),
                          Expanded(child: add),
                        ],
                      );
              }
              final bloc = context.read<DocumentBloc>();
              return context.read<CurrentIndexCubit>().useHandler(bloc, i, (
                handler,
              ) {
                final selected = i == currentIndex.index;
                final tool = handler.data;
                final highlighted =
                    currentIndex.selection?.selected.any(
                      (element) => element.hashCode == tool.hashCode,
                    ) ??
                    false;
                String tooltip = tool.name.trim();
                if (tooltip.isEmpty) {
                  tooltip = tool.getLocalizedName(context);
                }
                final status = handler.getStatus(context.read<DocumentBloc>());
                final theme = Theme.of(context);
                final color = switch (status) {
                  ToolStatus.normal => null,
                  ToolStatus.disabled => theme.disabledColor,
                  ToolStatus.selected => theme.colorScheme.secondary,
                };
                var handlerIcon = handler.getIcon(bloc);
                final toolWidget = Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: OptionButton(
                    tooltip: tooltip,
                    onLongPressed: selected || highlighted
                        ? null
                        : () => context
                              .read<CurrentIndexCubit>()
                              .insertSelection(tool, true),
                    onSecondaryPressed: () =>
                        context.read<CurrentIndexCubit>().changeSelection(tool),
                    focussed: shortcuts.contains(InputMapping(i)),
                    selected:
                        selected ||
                        currentIndex.toggleableHandlers.containsKey(i),
                    showBottom: selected || tool.isAction(),
                    highlighted: highlighted,
                    bottomIcon: selected || tool.isAction()
                        ? PhosphorIcon(
                            tool.isAction()
                                ? PhosphorIconsLight.playCircle
                                : isMobile
                                ? PhosphorIconsLight.caretUp
                                : switch (settings.toolbarPosition) {
                                    ToolbarPosition.top ||
                                    ToolbarPosition.inline =>
                                      PhosphorIconsLight.caretDown,
                                    ToolbarPosition.bottom =>
                                      PhosphorIconsLight.caretUp,
                                    ToolbarPosition.left =>
                                      PhosphorIconsLight.caretRight,
                                    ToolbarPosition.right =>
                                      PhosphorIconsLight.caretLeft,
                                  },
                          )
                        : null,
                    selectedIcon: _buildIcon(
                      handlerIcon ?? tool.icon(PhosphorIconsStyle.fill),
                      size,
                      color,
                    ),
                    icon: _buildIcon(
                      handlerIcon ?? tool.icon(PhosphorIconsStyle.light),
                      size,
                      color,
                    ),
                    onPressed: () {
                      if (_mouseState == _MouseState.multi) {
                        context.read<CurrentIndexCubit>().insertSelection(
                          tool,
                          true,
                        );
                      } else if (!selected || temp != null) {
                        context.read<CurrentIndexCubit>().resetSelection();
                        context.read<CurrentIndexCubit>().changeTool(
                          context.read<DocumentBloc>(),
                          index: i,
                          handler: handler,
                          context: context,
                        );
                      } else {
                        context.read<CurrentIndexCubit>().changeSelection(
                          tool,
                          true,
                        );
                      }
                    },
                  ),
                );
                return ReorderableGridDelayedDragStartListener(
                  index: i,
                  key: ObjectKey(i),
                  enabled: selected || highlighted,
                  child: toolWidget,
                );
              });
            }),
            onReorder: (oldIndex, newIndex) {
              if (oldIndex == newIndex) {
                context.read<CurrentIndexCubit>().insertSelection(
                  tools[newIndex],
                  true,
                );
                return;
              }
              final bloc = context.read<DocumentBloc>();
              final delete = newIndex > tools.length;
              if (delete) {
                bloc.add(ToolsRemoved([oldIndex]));
                return;
              }
              if (oldIndex < newIndex) {
                newIndex++;
              }
              bloc.add(ToolReordered(oldIndex, newIndex));
            },
          ),
          BlocBuilder<WindowCubit, WindowState>(
            builder: (context, windowState) {
              final children = [
                IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.wrench),
                  tooltip: AppLocalizations.of(context).document,
                  selectedIcon: const PhosphorIcon(PhosphorIconsFill.wrench),
                  isSelected:
                      currentIndex.selection?.selected.any(
                        (element) => element is CurrentIndexCubit,
                      ) ??
                      false,
                  onPressed: () {
                    final cubit = context.read<CurrentIndexCubit>();
                    cubit.changeSelection(cubit);
                  },
                ),
                if (windowState.fullScreen &&
                    tools.every((e) => e is! FullScreenTool))
                  IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.arrowsIn),
                    tooltip: LeapLocalizations.of(context).exitFullScreen,
                    onPressed: () {
                      context.read<WindowCubit>().changeFullScreen(false);
                    },
                  ),
                BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                  builder: (context, currentIndex) {
                    final utilitiesState = currentIndex.utilities;
                    Widget buildButton(
                      bool selected,
                      UtilitiesState Function() update,
                      PhosphorIconData icon,
                      String title,
                    ) => CheckboxMenuButton(
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
                          utilitiesState.lockCollection,
                          () => utilitiesState.copyWith(
                            lockCollection: !utilitiesState.lockCollection,
                          ),
                          PhosphorIconsLight.folder,
                          AppLocalizations.of(context).collection,
                        ),
                        buildButton(
                          utilitiesState.lockLayer,
                          () => utilitiesState.copyWith(
                            lockLayer: !utilitiesState.lockLayer,
                          ),
                          PhosphorIconsLight.folder,
                          AppLocalizations.of(context).layer,
                        ),
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
                      style: const MenuStyle(alignment: Alignment.bottomLeft),
                      builder: defaultMenuButton(
                        icon: const PhosphorIcon(PhosphorIconsLight.lockKey),
                        tooltip: AppLocalizations.of(context).lock,
                      ),
                    );
                  },
                ),
              ];
              if (direction == Axis.horizontal) {
                return Row(children: children);
              }
              return Column(children: children);
            },
          ),
        ],
      ],
    );
  }
}
