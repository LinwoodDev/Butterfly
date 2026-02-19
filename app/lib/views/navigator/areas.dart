import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/area/context.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/transform.dart';
import '../../dialogs/delete.dart';
import '../../widgets/editable_list_tile.dart';

class AreasView extends StatefulWidget {
  const AreasView({super.key});

  @override
  State<AreasView> createState() => _AreasViewState();
}

class _AreasViewState extends State<AreasView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
            Rect? getRect(int dx, int dy) {
              if (current == null) return null;
              final rect = current.rect;
              return rect.translate(
                dx.toDouble() * rect.width,
                dy.toDouble() * rect.height,
              );
            }

            Area? overlap(Rect? rect, [bool? exact]) {
              if (rect == null) return null;
              return state.page.areas.firstWhereOrNull((area) {
                // Test for equality with precision error tolerance
                final current = area.rect;
                if (exact ?? currentIndex.areaNavigatorExact) {
                  return (current.top - rect.top).abs() <
                          precisionErrorTolerance &&
                      (current.left - rect.left).abs() <
                          precisionErrorTolerance &&
                      (current.width - rect.width).abs() <
                          precisionErrorTolerance &&
                      (current.height - rect.height).abs() <
                          precisionErrorTolerance;
                }
                return current.overlaps(rect.deflate(precisionErrorTolerance));
              });
            }

            bool enableButton(int dx, int dy) =>
                currentIndex.areaNavigatorCreate ||
                overlap(getRect(dx, dy)) != null;
            bool selectedButton(int dx, int dy) =>
                overlap(getRect(dx, dy), true) != null;

            Future<void> move(int dx, int dy) async {
              final rect = getRect(dx, dy);
              if (rect == null) return;
              var area = overlap(rect);
              if (area != null) {
                context.read<DocumentBloc>().add(CurrentAreaChanged(area.name));
                return;
              }
              if (!currentIndex.areaNavigatorCreate) return;
              final name = await createAreaName(
                context,
                state.page,
                currentIndex.areaNavigatorAsk,
              );
              if (name == null) return;
              final newArea = Area(
                position: rect.topLeft.toPoint(),
                height: rect.height,
                width: rect.width,
                name: name,
              );
              bloc
                ..add(AreasCreated([newArea]))
                ..add(CurrentAreaChanged(name));
            }

            if (state.page.areas.isEmpty) {
              return const _AreasInitializationView();
            }

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
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: ListenableBuilder(
                      listenable: _searchController,
                      builder: (context, child) {
                        final areas = state.page.areas
                            .where(
                              (area) => area.name.toLowerCase().contains(
                                _searchController.text.toLowerCase(),
                              ),
                            )
                            .toList();
                        return ReorderableListView.builder(
                          itemCount: areas.length,
                          onReorder: (oldIndex, newIndex) =>
                              context.read<DocumentBloc>().add(
                                AreaReordered(areas[oldIndex].name, newIndex),
                              ),
                          itemBuilder: (BuildContext context, int index) {
                            final area = areas[index];
                            final selected = current?.name == area.name;
                            return EditableListTile(
                              initialValue: area.name,
                              key: ValueKey(area.name),
                              leading: IconButton(
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
                                context.read<TransformCubit>().teleportToArea(
                                  area,
                                  viewport.toSize(),
                                  viewport.resolution,
                                );
                                bloc.add(CurrentAreaChanged(area.name));
                              },
                              onSaved: (value) =>
                                  context.read<DocumentBloc>().add(
                                    AreaChanged(
                                      area.name,
                                      area.copyWith(name: value),
                                    ),
                                  ),
                              selected: current == null
                                  ? area.rect.overlaps(viewportRect)
                                  : current.name == area.name,
                              actions: [
                                ...buildGeneralAreaContextMenu(
                                  bloc,
                                  area,
                                  context.read<SettingsCubit>(),
                                  state.renderers
                                      .where((e) => e.area == area)
                                      .map(
                                        (e) => e.transform(
                                          position: -area.position.toOffset(),
                                          relative: true,
                                        ),
                                      )
                                      .map((e) => e?.element)
                                      .nonNulls
                                      .toList(),
                                  pop: false,
                                )(context).map(
                                  (e) =>
                                      buildMenuItem(context, e, false, false),
                                ),
                                MenuItemButton(
                                  leadingIcon: const PhosphorIcon(
                                    PhosphorIconsLight.trash,
                                  ),
                                  onPressed: () async {
                                    final result = await showDialog<bool>(
                                      context: context,
                                      builder: (context) =>
                                          const DeleteDialog(),
                                    );
                                    if (result != true) return;
                                    if (context.mounted) {
                                      bloc.add(AreasRemoved([area.name]));
                                    }
                                  },
                                  child: Text(
                                    AppLocalizations.of(context).delete,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                if (current != null)
                  BottomAppBar(
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              isSelected: currentIndex.areaNavigatorCreate,
                              onPressed: () => context
                                  .read<CurrentIndexCubit>()
                                  .setAreaNavigatorCreate(
                                    !currentIndex.areaNavigatorCreate,
                                  ),
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.plusCircle,
                              ),
                              tooltip: LeapLocalizations.of(context).create,
                            ),
                            IconButton(
                              isSelected: currentIndex.areaNavigatorExact,
                              onPressed: () => context
                                  .read<CurrentIndexCubit>()
                                  .setAreaNavigatorExact(
                                    !currentIndex.areaNavigatorExact,
                                  ),
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.square,
                              ),
                              tooltip: AppLocalizations.of(context).exact,
                            ),
                            IconButton(
                              isSelected: currentIndex.areaNavigatorAsk,
                              onPressed: () => context
                                  .read<CurrentIndexCubit>()
                                  .setAreaNavigatorAsk(
                                    !currentIndex.areaNavigatorAsk,
                                  ),
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.textT,
                              ),
                              tooltip: AppLocalizations.of(context).askForName,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const PhosphorIcon(
                                    PhosphorIconsLight.arrowsOutCardinal,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(AppLocalizations.of(context).move),
                                ],
                              ),
                            ),
                            Wrap(
                              spacing: 8,
                              children:
                                  [
                                        (
                                          (-1, 0),
                                          AppLocalizations.of(context).left,
                                          PhosphorIcons.arrowLeft,
                                        ),
                                        (
                                          (0, -1),
                                          AppLocalizations.of(context).top,
                                          PhosphorIcons.arrowUp,
                                        ),
                                        (
                                          (0, 1),
                                          AppLocalizations.of(context).bottom,
                                          PhosphorIcons.arrowDown,
                                        ),
                                        (
                                          (1, 0),
                                          AppLocalizations.of(context).right,
                                          PhosphorIcons.arrowRight,
                                        ),
                                      ]
                                      .map(
                                        (data) => IconButton.filledTonal(
                                          icon: PhosphorIcon(
                                            data.$3(PhosphorIconsStyle.light),
                                          ),
                                          tooltip: data.$2,
                                          onPressed:
                                              enableButton(
                                                data.$1.$1,
                                                data.$1.$2,
                                              )
                                              ? () =>
                                                    move(data.$1.$1, data.$1.$2)
                                              : null,
                                          selectedIcon: PhosphorIcon(
                                            data.$3(PhosphorIconsStyle.light),
                                          ),
                                          isSelected: selectedButton(
                                            data.$1.$1,
                                            data.$1.$2,
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ],
                        ),
                      ],
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

class _AreasInitializationView extends StatefulWidget {
  const _AreasInitializationView();

  @override
  State<_AreasInitializationView> createState() =>
      _AreasInitializationViewState();
}

class _AreasInitializationViewState extends State<_AreasInitializationView> {
  late final TextEditingController _widthController;
  late final TextEditingController _heightController;
  late AreaSizePreset _selectedPreset;
  _AreaPositionMode _positionMode = _AreaPositionMode.currentCenter;

  @override
  void initState() {
    super.initState();
    final preset = AreaSizePreset.values.first;
    _selectedPreset = preset;
    _widthController = TextEditingController(text: preset.width.toString());
    _heightController = TextEditingController(text: preset.height.toString());
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  double? _parseNumber(String value) =>
      double.tryParse(value.trim().replaceAll(',', '.'));

  void _applyPreset(AreaSizePreset preset) {
    _selectedPreset = preset;
    _widthController.text = preset.width.toString();
    _heightController.text = preset.height.toString();
  }

  void _flipSize() {
    final width = _widthController.text;
    _widthController.text = _heightController.text;
    _heightController.text = width;
  }

  Future<void> _createArea() async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;

    final width = _parseNumber(_widthController.text);
    final height = _parseNumber(_heightController.text);
    if (width == null || height == null || width <= 0 || height <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).error)),
      );
      return;
    }

    final name = await createAreaName(context, state.page, false);
    if (name == null) return;

    Offset position;
    if (_positionMode == _AreaPositionMode.currentCenter) {
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
          ),
        ]),
      )
      ..add(CurrentAreaChanged(name));
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.createAreas,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                DropdownMenuFormField<AreaSizePreset>(
                  initialSelection: _selectedPreset,
                  dropdownMenuEntries: AreaSizePreset.values
                      .map(
                        (preset) => DropdownMenuEntry<AreaSizePreset>(
                          value: preset,
                          label:
                              '${preset.label} (${preset.width.toInt()}×${preset.height.toInt()})',
                        ),
                      )
                      .toList(),
                  label: Text(locale.presets),
                  onSelected: (preset) {
                    if (preset == null) return;
                    setState(() => _applyPreset(preset));
                  },
                ),
                const SizedBox(height: 8),
                Divider(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _widthController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(labelText: locale.width),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filledTonal(
                      onPressed: _flipSize,
                      tooltip: locale.rotate,
                      icon: const Icon(PhosphorIconsLight.swap),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _heightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(labelText: locale.height),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  locale.position,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                SegmentedButton<_AreaPositionMode>(
                  segments: [
                    ButtonSegment<_AreaPositionMode>(
                      value: _AreaPositionMode.origin,
                      label: Text(locale.origin),
                    ),
                    ButtonSegment<_AreaPositionMode>(
                      value: _AreaPositionMode.currentCenter,
                      label: Text(locale.center),
                    ),
                  ],
                  selected: {_positionMode},
                  onSelectionChanged: (selection) {
                    if (selection.isEmpty) return;
                    setState(() => _positionMode = selection.first);
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: _createArea,
                    icon: const PhosphorIcon(PhosphorIconsLight.plus),
                    label: Text(LeapLocalizations.of(context).create),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

enum _AreaPositionMode { origin, currentCenter }
