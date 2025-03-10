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

class WaypointsView extends StatelessWidget {
  const WaypointsView({super.key});

  @override
  Widget build(BuildContext context) {
    const origin = Waypoint.origin;
    return BlocBuilder<TransformCubit, CameraTransform>(
      builder: (context, transform) {
        return BlocBuilder<DocumentBloc, DocumentState>(
          buildWhen: (previous, current) =>
              previous.page?.waypoints != current.page?.waypoints,
          builder: (context, state) {
            if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
            var waypoints = state.page.waypoints;
            return Stack(
              children: [
                ListView(
                  children: [
                    ListTile(
                      title: Text(AppLocalizations.of(context).origin),
                      selected: transform.position.toPoint() == origin.position,
                      onTap: () {
                        context.read<TransformCubit>().teleportToWaypoint(
                              origin,
                            );
                        context.read<DocumentBloc>().bake();
                      },
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
                          key: ValueKey(waypoint.name),
                          initialValue: waypoint.name,
                          onTap: () {
                            context.read<TransformCubit>().teleportToWaypoint(
                                  waypoint,
                                );
                            context.read<DocumentBloc>().bake();
                          },
                          onSaved: (value) => context.read<DocumentBloc>().add(
                                WaypointChanged(
                                  waypoint.name,
                                  waypoint.copyWith(name: value),
                                ),
                              ),
                          selected:
                              transform.position.toPoint() == waypoint.position,
                          actions: [
                            MenuItemButton(
                              leadingIcon: const PhosphorIcon(
                                PhosphorIconsLight.trash,
                              ),
                              onPressed: () async {
                                final result = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => const DeleteDialog(),
                                );
                                if (result != true) return;
                                if (context.mounted) {
                                  context.read<DocumentBloc>().add(
                                        WaypointRemoved(waypoint.name),
                                      );
                                }
                              },
                              child: Text(AppLocalizations.of(context).delete),
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
                      backgroundColor: ColorScheme.of(context).secondary,
                      foregroundColor: ColorScheme.of(context).onSecondary,
                      label: Text(AppLocalizations.of(context).add),
                      icon: const PhosphorIcon(PhosphorIconsLight.plus),
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
        );
      },
    );
  }
}

class WaypointCreateDialog extends StatefulWidget {
  const WaypointCreateDialog({super.key});

  @override
  State<WaypointCreateDialog> createState() => _WaypointCreateDialogState();
}

class _WaypointCreateDialogState extends State<WaypointCreateDialog> {
  bool _saveScale = false;
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(LeapLocalizations.of(context).create),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            autofocus: true,
            decoration: InputDecoration(
              filled: true,
              labelText: LeapLocalizations.of(context).name,
            ),
          ),
          const SizedBox(height: 10),
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

            bloc.add(
              WaypointCreated(
                Waypoint(
                  _nameController.text,
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
