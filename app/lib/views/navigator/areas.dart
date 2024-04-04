import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/transform.dart';
import '../../dialogs/delete.dart';
import '../../widgets/editable_list_tile.dart';

class AreasView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  AreasView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  return Rect.fromLTWH(
                    current.position.x + dx.toDouble() * current.width,
                    current.position.y + dy.toDouble() * current.height,
                    current.width,
                    current.height,
                  );
                }

                Area? overlap(Rect? rect, [bool? exact]) {
                  if (rect == null) return null;
                  return state.page.areas.firstWhereOrNull((area) =>
                      (exact ?? currentIndex.areaNavigatorExact)
                          ? area.rect == rect
                          : area.rect.overlaps(rect));
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
                    context
                        .read<DocumentBloc>()
                        .add(CurrentAreaChanged(area.name));
                    return;
                  }
                  if (!currentIndex.areaNavigatorCreate) return;
                  final name = await createAreaName(
                      context, state.page, currentIndex.areaNavigatorAsk);
                  if (name == null) return;
                  final newArea = Area(
                    position: rect.topLeft.toPoint(),
                    height: rect.height,
                    width: rect.width,
                    name: name,
                  );
                  context.read<DocumentBloc>()
                    ..add(AreasCreated([newArea]))
                    ..add(CurrentAreaChanged(name));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon:
                              PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        controller: _searchController,
                        autofocus: true,
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
                                  .where((area) => area.name
                                      .toLowerCase()
                                      .contains(
                                          _searchController.text.toLowerCase()))
                                  .toList();
                              return ReorderableListView.builder(
                                  itemCount: areas.length,
                                  onReorder: (oldIndex, newIndex) => context
                                      .read<DocumentBloc>()
                                      .add(AreaReordered(
                                          areas[oldIndex].name, newIndex)),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final area = areas[index];
                                    final selected = current?.name == area.name;
                                    return EditableListTile(
                                      initialValue: area.name,
                                      key: ValueKey(area.name),
                                      leading: IconButton(
                                        icon: PhosphorIcon(selected
                                            ? PhosphorIconsLight.signOut
                                            : PhosphorIconsLight.signIn),
                                        onPressed: () {
                                          context.read<DocumentBloc>().add(
                                              CurrentAreaChanged(
                                                  selected ? '' : area.name));
                                        },
                                        tooltip: selected
                                            ? AppLocalizations.of(context)
                                                .exitArea
                                            : AppLocalizations.of(context)
                                                .enterArea,
                                      ),
                                      onTap: () {
                                        final screen = context
                                            .read<CurrentIndexCubit>()
                                            .state
                                            .cameraViewport
                                            .toSize();
                                        context
                                            .read<TransformCubit>()
                                            .teleportToArea(area, screen);
                                        final bloc =
                                            context.read<DocumentBloc>();
                                        if (current != null) {
                                          bloc.add(
                                              CurrentAreaChanged(area.name));
                                        } else {
                                          bloc.bake();
                                        }
                                      },
                                      onSaved: (value) => context
                                          .read<DocumentBloc>()
                                          .add(AreaChanged(area.name,
                                              area.copyWith(name: value))),
                                      selected: current == null
                                          ? area.rect.overlaps(viewportRect)
                                          : current.name == area.name,
                                      actions: [
                                        MenuItemButton(
                                          leadingIcon: const PhosphorIcon(
                                              PhosphorIconsLight.trash),
                                          onPressed: () async {
                                            final result =
                                                await showDialog<bool>(
                                                    context: context,
                                                    builder: (context) =>
                                                        const DeleteDialog());
                                            if (result != true) return;
                                            if (context.mounted) {
                                              context.read<DocumentBloc>().add(
                                                  AreasRemoved([area.name]));
                                            }
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .delete),
                                        )
                                      ],
                                    );
                                  });
                            }),
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
                                          !currentIndex.areaNavigatorCreate),
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.plusCircle),
                                  tooltip: AppLocalizations.of(context).create,
                                ),
                                IconButton(
                                  isSelected: currentIndex.areaNavigatorExact,
                                  onPressed: () => context
                                      .read<CurrentIndexCubit>()
                                      .setAreaNavigatorExact(
                                          !currentIndex.areaNavigatorExact),
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.square),
                                  tooltip: AppLocalizations.of(context).exact,
                                ),
                                IconButton(
                                  isSelected: currentIndex.areaNavigatorAsk,
                                  onPressed: () => context
                                      .read<CurrentIndexCubit>()
                                      .setAreaNavigatorAsk(
                                          !currentIndex.areaNavigatorAsk),
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.textT),
                                  tooltip:
                                      AppLocalizations.of(context).askForName,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const PhosphorIcon(
                                          PhosphorIconsLight.arrowsOutCardinal),
                                      const SizedBox(width: 8),
                                      Text(AppLocalizations.of(context).move),
                                    ],
                                  ),
                                ),
                                Wrap(
                                  spacing: 8,
                                  children: [
                                    (
                                      (-1, 0),
                                      AppLocalizations.of(context).left,
                                      PhosphorIcons.arrowLeft
                                    ),
                                    (
                                      (0, -1),
                                      AppLocalizations.of(context).top,
                                      PhosphorIcons.arrowUp
                                    ),
                                    (
                                      (0, 1),
                                      AppLocalizations.of(context).bottom,
                                      PhosphorIcons.arrowDown
                                    ),
                                    (
                                      (1, 0),
                                      AppLocalizations.of(context).right,
                                      PhosphorIcons.arrowRight
                                    ),
                                  ]
                                      .map(
                                        (data) => IconButton.filledTonal(
                                          icon: PhosphorIcon(data
                                              .$3(PhosphorIconsStyle.light)),
                                          tooltip: data.$2,
                                          onPressed: enableButton(
                                                  data.$1.$1, data.$1.$2)
                                              ? () =>
                                                  move(data.$1.$1, data.$1.$2)
                                              : null,
                                          selectedIcon: PhosphorIcon(data
                                              .$3(PhosphorIconsStyle.light)),
                                          isSelected: selectedButton(
                                              data.$1.$1, data.$1.$2),
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
              });
        });
  }
}
