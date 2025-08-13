import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/transform.dart';
import '../../dialogs/delete.dart';
import '../../widgets/editable_list_tile.dart';

class WaypointsView extends StatefulWidget {
  const WaypointsView({super.key});

  @override
  State<WaypointsView> createState() => _WaypointsViewState();
}

class _WaypointsViewState extends State<WaypointsView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransformCubit, CameraTransform>(
      builder: (context, transform) {
        return BlocBuilder<DocumentBloc, DocumentState>(
          buildWhen: (previous, current) =>
              previous.page?.waypoints != current.page?.waypoints,
          builder: (context, state) => Column(
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
                      if (state is! DocumentLoadSuccess) {
                        return const SizedBox.shrink();
                      }
                      Waypoint origin = state.page.getOriginWaypoint();
                      final waypoints = state.page.waypoints
                          .where(
                            (e) =>
                                e.name != Waypoint.defaultOrigin.name &&
                                (e.name?.toLowerCase().contains(
                                      _searchController.text.toLowerCase(),
                                    ) ??
                                    true),
                          )
                          .toList();
                      return Stack(
                        children: [
                          ListView(
                            children: [
                              ContextRegion(
                                tooltip: AppLocalizations.of(context).actions,
                                builder: (context, button, controller) {
                                  return ListTile(
                                    title: Text(
                                      AppLocalizations.of(context).origin,
                                    ),
                                    selected:
                                        transform.position.toPoint() ==
                                        origin.position,
                                    onTap: () {
                                      context
                                          .read<TransformCubit>()
                                          .teleportToWaypoint(origin);
                                      context.read<DocumentBloc>().bake();
                                    },
                                    trailing: button,
                                  );
                                },
                                menuChildren: [
                                  MenuItemButton(
                                    leadingIcon: const PhosphorIcon(
                                      PhosphorIconsLight.mapPin,
                                    ),
                                    onPressed: () async {
                                      final bloc = context.read<DocumentBloc>();
                                      showDialog<void>(
                                        builder: (context) =>
                                            BlocProvider.value(
                                              value: bloc,
                                              child: WaypointCreateDialog(
                                                waypoint: origin,
                                              ),
                                            ),
                                        context: context,
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(context).replace,
                                    ),
                                  ),
                                  if (origin != Waypoint.defaultOrigin)
                                    MenuItemButton(
                                      leadingIcon: const PhosphorIcon(
                                        PhosphorIconsLight.clockClockwise,
                                      ),
                                      onPressed: () async {
                                        final bloc = context
                                            .read<DocumentBloc>();
                                        showDialog<void>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(
                                              LeapLocalizations.of(
                                                context,
                                              ).reset,
                                            ),
                                            content: Text(
                                              AppLocalizations.of(
                                                context,
                                              ).reallyReset,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text(
                                                  MaterialLocalizations.of(
                                                    context,
                                                  ).cancelButtonLabel,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  bloc.add(
                                                    WaypointChanged(
                                                      origin.name,
                                                      Waypoint.defaultOrigin,
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                  final state = bloc.state;
                                                  if (state
                                                      is! DocumentLoadSuccess) {
                                                    return;
                                                  }
                                                  state
                                                      .currentIndexCubit
                                                      .state
                                                      .transformCubit
                                                      .teleportToWaypoint(
                                                        Waypoint.defaultOrigin,
                                                      );
                                                  bloc.bake();
                                                },
                                                child: Text(
                                                  LeapLocalizations.of(
                                                    context,
                                                  ).reset,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Text(
                                        LeapLocalizations.of(context).reset,
                                      ),
                                    ),
                                ],
                              ),
                              const Divider(),
                              ReorderableListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: waypoints.length,
                                onReorder: (oldIndex, newIndex) =>
                                    context.read<DocumentBloc>().add(
                                      WaypointReordered(
                                        waypoints[oldIndex].name,
                                        newIndex,
                                      ),
                                    ),
                                itemBuilder: (BuildContext context, int index) {
                                  final waypoint = waypoints[index];
                                  return EditableListTile(
                                    key: ValueKey(waypoint.name ?? ''),
                                    initialValue: waypoint.name,
                                    onTap: () {
                                      context
                                          .read<TransformCubit>()
                                          .teleportToWaypoint(waypoint);
                                      context.read<DocumentBloc>().bake();
                                    },
                                    onSaved: (value) =>
                                        context.read<DocumentBloc>().add(
                                          WaypointChanged(
                                            waypoint.name,
                                            waypoint.copyWith(name: value),
                                          ),
                                        ),
                                    selected:
                                        transform.position.toPoint() ==
                                        waypoint.position,
                                    actions: [
                                      MenuItemButton(
                                        leadingIcon: const PhosphorIcon(
                                          PhosphorIconsLight.mapPin,
                                        ),
                                        onPressed: () async {
                                          final bloc = context
                                              .read<DocumentBloc>();
                                          showDialog<void>(
                                            builder: (context) =>
                                                BlocProvider.value(
                                                  value: bloc,
                                                  child: WaypointCreateDialog(
                                                    waypoint: waypoint,
                                                  ),
                                                ),
                                            context: context,
                                          );
                                        },
                                        child: Text(
                                          AppLocalizations.of(context).replace,
                                        ),
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
                                            context.read<DocumentBloc>().add(
                                              WaypointRemoved(waypoint.name),
                                            );
                                          }
                                        },
                                        child: Text(
                                          AppLocalizations.of(context).delete,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton.extended(
                                backgroundColor: ColorScheme.of(
                                  context,
                                ).secondary,
                                foregroundColor: ColorScheme.of(
                                  context,
                                ).onSecondary,
                                label: Text(AppLocalizations.of(context).add),
                                icon: const PhosphorIcon(
                                  PhosphorIconsLight.plus,
                                ),
                                onPressed: () {
                                  final bloc = context.read<DocumentBloc>();
                                  showDialog<String>(
                                    builder: (context) => BlocProvider.value(
                                      value: bloc,
                                      child: const WaypointCreateDialog(),
                                    ),
                                    context: context,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class WaypointCreateDialog extends StatefulWidget {
  final Waypoint? waypoint;
  const WaypointCreateDialog({super.key, this.waypoint});

  @override
  State<WaypointCreateDialog> createState() => _WaypointCreateDialogState();
}

class _WaypointCreateDialogState extends State<WaypointCreateDialog> {
  bool _replacing = false;
  bool _saveScale = false;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _replacing = widget.waypoint != null;
    _saveScale = _replacing ? widget.waypoint!.scale != null : false;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _replacing
            ? AppLocalizations.of(context).replace
            : LeapLocalizations.of(context).create,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_replacing) ...[
            TextField(
              controller: _nameController,
              autofocus: true,
              decoration: InputDecoration(
                filled: true,
                labelText: LeapLocalizations.of(context).name,
              ),
            ),
            const SizedBox(height: 10),
          ],
          CheckboxListTile(
            title: Text(AppLocalizations.of(context).scale),
            value: _saveScale,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) =>
                setState(() => _saveScale = value ?? _saveScale),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: () {
            final bloc = context.read<DocumentBloc>();
            final state = bloc.state;
            if (state is! DocumentLoadSuccess) return;
            final transform =
                state.currentIndexCubit.state.transformCubit.state;
            final String? name = _replacing
                ? widget.waypoint!.name
                : _nameController.text;

            bloc.add(
              WaypointChanged(
                name,
                Waypoint(
                  name,
                  transform.position.toPoint(),
                  _saveScale ? transform.size : null,
                ),
              ),
            );
            Navigator.of(context).pop();
          },
          child: Text(LeapLocalizations.of(context).create),
        ),
      ],
    );
  }
}
