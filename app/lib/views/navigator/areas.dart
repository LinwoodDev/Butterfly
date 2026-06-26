import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/area/context.dart';
import 'package:butterfly/dialogs/area/init.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/page.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/transform.dart';
import '../../dialogs/delete.dart';
import '../../widgets/multi_select.dart';
import '../../widgets/editable_list_tile.dart';

class AreasView extends StatefulWidget {
  const AreasView({super.key});

  @override
  State<AreasView> createState() => _AreasViewState();
}

class _AreasViewState extends State<AreasView> {
  String _currentGroup = '';
  final TextEditingController _searchController = TextEditingController();

  List<Area> _getAreasInGroup(List<Area> areas) {
    return areas.where((area) => area.group == _currentGroup).toList();
  }

  List<String> _getSubgroups(List<Area> areas) {
    final groups = areas
        .map((area) => area.group)
        .where((group) => group.startsWith(_currentGroup))
        .map((group) => group.substring(_currentGroup.length))
        .where((sub) => sub.isNotEmpty && !sub.contains('/'))
        .toSet()
        .toList();
    groups.sort();
    return groups;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _createArea(AreaConfig config) async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final width = config.width;
    final height = config.height;
    final name = config.name;
    if (name.isEmpty) return;
    Offset position;
    if (config.positionMode == AreaPositionMode.currentCenter) {
      final center = context
          .read<CurrentIndexCubit>()
          .state
          .cameraViewport
          .toRect()
          .center;
      position = center - Offset(width / 2, height / 2);
    } else {
      position = Offset.zero;
    }

    bloc
      ..add(
        AreasCreated([
          Area(
            name: name,
            width: width,
            height: height,
            position: position.toPoint(),
            isInitial: config.areaAsInitial,
          ),
        ]),
      )
      ..add(CurrentAreaChanged(name));
  }

  Widget buildAreaTile(
    DocumentBloc bloc,
    CameraViewport viewport,
    DocumentLoadSuccess state,
    Rect viewportRect,
    Area? current,
    Area area, {
    required MultiSelectController<String> controller,
    List<String> folderPath = const [],
  }) {
    final selected = current?.name == area.name;
    final isSelectionMode = controller.selectionMode;
    final isSelected = isSelectionMode
        ? controller.selectedIds.contains(area.name)
        : selected;

    return EditableListTile(
      initialValue: area.shortName,
      key: ValueKey(area.name),
      leading: isSelectionMode
          ? Checkbox(
              value: isSelected,
              onChanged: (value) => controller.toggle(area.name),
            )
          : IconButton(
              icon: PhosphorIcon(
                selected
                    ? PhosphorIconsLight.signOut
                    : PhosphorIconsLight.signIn,
              ),
              onPressed: () {
                if (selected) {
                  bloc.add(CurrentAreaChanged(''));
                  return;
                }
                context.read<TransformCubit>().teleportToArea(
                  area,
                  viewport.toSize(),
                  viewport.resolution,
                );
                bloc.add(CurrentAreaChanged(area.name));
              },
              tooltip: selected
                  ? AppLocalizations.of(context).exitArea
                  : AppLocalizations.of(context).enterArea,
            ),
      onTap: () {
        if (isSelectionMode) {
          controller.toggle(area.name);
          return;
        }
        context.read<TransformCubit>().teleportToArea(
          area,
          viewport.toSize(),
          viewport.resolution,
        );
        bloc.add(CurrentAreaChanged(area.name));
      },
      onLongPress: () {
        if (!isSelectionMode) {
          controller.enableSelectionMode();
          controller.select(area.name);
        }
      },
      onSaved: (value) {
        final trimmed = value.trim();
        if (trimmed.isEmpty) return;
        final nextName = trimmed.contains('/')
            ? trimmed
            : folderPath.isEmpty
            ? trimmed
            : '${folderPath.join('/')}/$trimmed';
        context.read<DocumentBloc>().add(
          AreaChanged(area.name, area.copyWith(name: nextName)),
        );
      },
      selected: current == null && !isSelectionMode
          ? area.rect.overlaps(viewportRect)
          : isSelected,
      actions: isSelectionMode
          ? null
          : [
              ...buildAreaContextMenu(
                bloc,
                state,
                area,
                context.read<SettingsCubit>(),
                pop: false,
                includeRenameAndEnterArea: false,
              )(context).map((e) => buildMenuItem(context, e, false, false)),
            ],
    );
  }

  Widget buildAreaFolder(String name, String path) {
    return ListTile(
      title: Text(name),
      leading: const PhosphorIcon(PhosphorIconsLight.folder),
      onTap: () {
        setState(() {
          _currentGroup = path;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
      buildWhen: (previous, current) =>
          previous.cameraViewport != current.cameraViewport ||
          previous.areaNavigatorCreate != current.areaNavigatorCreate ||
          previous.areaNavigatorExact != current.areaNavigatorExact ||
          previous.areaNavigatorAsk != current.areaNavigatorAsk,
      builder: (context, currentIndex) {
        final viewport = currentIndex.cameraViewport;
        final viewportRect = viewport.toRect();
        return BlocBuilder<DocumentBloc, DocumentState>(
          buildWhen: (previous, current) =>
              previous.page?.areas != current.page?.areas ||
              previous.currentArea != current.currentArea,
          builder: (context, state) {
            if (state is! DocumentLoadSuccess) {
              return const SizedBox.shrink();
            }
            final current = state.currentArea;

            final currentIndexCubit = context.read<CurrentIndexCubit>();

            bool enableButton(int dx, int dy) {
              if (current == null) return false;
              return currentIndex.areaNavigatorCreate ||
                  currentIndexCubit.getRelativeArea(current, dx, dy) != null;
            }

            bool selectedButton(int dx, int dy) {
              if (current == null) return false;
              return currentIndexCubit.getRelativeArea(current, dx, dy, true) !=
                  null;
            }

            Future<void> navigateToRelativeArea(int dx, int dy) async {
              await currentIndexCubit.navigateToRelativeArea(
                dx,
                dy,
                createAreaName: () => createAreaName(
                  context,
                  state.page,
                  currentIndex.areaNavigatorAsk,
                ),
              );
            }

            if (state.page.areas.isEmpty) {
              return AreasInitializationView(
                onCreate: _createArea,
                insideDocument: true,
                initialName: state.page.createAreaName(context),
              );
            }

            final allSubgroups = _getSubgroups(state.page.areas);
            final areasInGroup = _getAreasInGroup(state.page.areas);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBar(
                    controller: _searchController,
                    hintText: AppLocalizations.of(context).search,
                    leading: const PhosphorIcon(
                      PhosphorIconsLight.magnifyingGlass,
                    ),
                  ),
                ),
                const Divider(),
                if (_currentGroup.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: const PhosphorIcon(
                            PhosphorIconsLight.arrowLeft,
                          ),
                          onPressed: () {
                            setState(() {
                              final lastSlash = _currentGroup.lastIndexOf('/');
                              if (lastSlash == -1) {
                                _currentGroup = '';
                              } else {
                                _currentGroup = _currentGroup.substring(
                                  0,
                                  lastSlash,
                                );
                              }
                            });
                          },
                          tooltip: AppLocalizations.of(context).back,
                        ),
                        Text(
                          _currentGroup,
                          style: TextTheme.of(context).titleMedium,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: MultiSelectRegion<String>(
                      toolbarBuilder: (context, controller) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: OverflowBar(
                          spacing: 8,
                          children: [
                            ActionChip(
                              label: Text(AppLocalizations.of(context).delete),
                              avatar: const PhosphorIcon(
                                PhosphorIconsLight.trash,
                              ),
                              onPressed: () async {
                                if (controller.selectedIds.isEmpty) return;
                                final result = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => const DeleteDialog(),
                                );
                                if (result != true) return;
                                if (!context.mounted) return;
                                context.read<DocumentBloc>().add(
                                  AreasRemoved(controller.selectedIds.toList()),
                                );
                                controller.clear();
                              },
                            ),
                          ],
                        ),
                      ),
                      builder: (context, controller, child) =>
                          ListenableBuilder(
                            listenable: _searchController,
                            builder: (context, child) {
                              final search = _searchController.text
                                  .toLowerCase();
                              final areas = areasInGroup
                                  .where(
                                    (area) => area.name.toLowerCase().contains(
                                      search,
                                    ),
                                  )
                                  .toList();
                              final subgroups = allSubgroups
                                  .where(
                                    (group) =>
                                        group.toLowerCase().contains(search),
                                  )
                                  .toList();
                              if (areas.isEmpty && subgroups.isEmpty) {
                                return Center(
                                  child: Text(
                                    AppLocalizations.of(context).none,
                                  ),
                                );
                              }
                              return ListView(
                                primary: true,
                                children: [
                                  ...subgroups.map(
                                    (group) => buildAreaFolder(
                                      group,
                                      '$_currentGroup$group',
                                    ),
                                  ),
                                  ...areas.map(
                                    (area) => buildAreaTile(
                                      bloc,
                                      viewport,
                                      state,
                                      viewportRect,
                                      current,
                                      area,
                                      controller: controller,
                                      folderPath: _currentGroup.isEmpty
                                          ? []
                                          : _currentGroup.split('/'),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                    ),
                  ),
                ),
                if (current != null)
                  Card.filled(
                    child: SizedBox(
                      height: 64,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: MenuAnchor(
                                menuChildren: [
                                  CheckboxMenuButton(
                                    value: currentIndex.areaNavigatorCreate,
                                    onChanged: (value) => context
                                        .read<CurrentIndexCubit>()
                                        .setAreaNavigatorCreate(value ?? false),
                                    child: Text(
                                      LeapLocalizations.of(context).create,
                                    ),
                                  ),
                                  CheckboxMenuButton(
                                    value: currentIndex.areaNavigatorExact,
                                    onChanged: (value) => context
                                        .read<CurrentIndexCubit>()
                                        .setAreaNavigatorExact(value ?? false),
                                    child: Text(
                                      AppLocalizations.of(context).exact,
                                    ),
                                  ),
                                  CheckboxMenuButton(
                                    value: currentIndex.areaNavigatorAsk,
                                    onChanged: (value) => context
                                        .read<CurrentIndexCubit>()
                                        .setAreaNavigatorAsk(value ?? false),
                                    child: Text(
                                      AppLocalizations.of(context).askForName,
                                    ),
                                  ),
                                ],
                                builder: (context, controller, child) =>
                                    InkWell(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      onTap: controller.toggle,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          spacing: 8,
                                          children: [
                                            PhosphorIcon(
                                              PhosphorIconsLight.compass,
                                              color: controller.isOpen
                                                  ? ColorScheme.of(
                                                      context,
                                                    ).primary
                                                  : null,
                                            ),
                                            Text(
                                              AppLocalizations.of(
                                                context,
                                              ).navigator,
                                              style: TextTheme.of(context)
                                                  .titleMedium
                                                  ?.copyWith(
                                                    color: controller.isOpen
                                                        ? ColorScheme.of(
                                                            context,
                                                          ).primary
                                                        : null,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            Row(
                              children: [
                                _AreaDirectionButton(
                                  icon: PhosphorIcons.arrowLeft,
                                  tooltip: AppLocalizations.of(context).left,
                                  enabled: enableButton(-1, 0),
                                  selected: selectedButton(-1, 0),
                                  onPressed: () =>
                                      navigateToRelativeArea(-1, 0),
                                ),
                                const SizedBox(width: 2),
                                _AreaDirectionButton(
                                  icon: PhosphorIcons.arrowUp,
                                  tooltip: AppLocalizations.of(context).top,
                                  enabled: enableButton(0, -1),
                                  selected: selectedButton(0, -1),
                                  onPressed: () =>
                                      navigateToRelativeArea(0, -1),
                                ),
                                const SizedBox(width: 2),
                                _AreaDirectionButton(
                                  icon: PhosphorIcons.arrowDown,
                                  tooltip: AppLocalizations.of(context).bottom,
                                  enabled: enableButton(0, 1),
                                  selected: selectedButton(0, 1),
                                  onPressed: () => navigateToRelativeArea(0, 1),
                                ),
                                const SizedBox(width: 2),
                                _AreaDirectionButton(
                                  icon: PhosphorIcons.arrowRight,
                                  tooltip: AppLocalizations.of(context).right,
                                  enabled: enableButton(1, 0),
                                  selected: selectedButton(1, 0),
                                  onPressed: () => navigateToRelativeArea(1, 0),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class _AreaDirectionButton extends StatelessWidget {
  final IconData Function(PhosphorIconsStyle) icon;
  final String tooltip;
  final bool enabled;
  final bool selected;
  final VoidCallback onPressed;

  const _AreaDirectionButton({
    required this.icon,
    required this.tooltip,
    required this.enabled,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      icon: PhosphorIcon(icon(PhosphorIconsStyle.light)),
      tooltip: tooltip,
      onPressed: enabled ? onPressed : null,
      selectedIcon: PhosphorIcon(icon(PhosphorIconsStyle.light)),
      isSelected: selected,
    );
  }
}
