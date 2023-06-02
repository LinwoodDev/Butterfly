import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/helpers/offset_helper.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../cubits/transform.dart';
import '../dialogs/delete.dart';

class WaypointsView extends StatelessWidget {
  const WaypointsView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
    const origin = Waypoint.origin;
    return BlocBuilder<TransformCubit, CameraTransform>(
        builder: (context, transform) {
      return StreamBuilder<NoteData>(
          stream: state.data.onChange,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox.shrink();
            var waypoints = state.page.waypoints;
            return Stack(
              children: [
                ListView(children: [
                  ListTile(
                    title: Text(AppLocalizations.of(context).origin),
                    selected: transform.position.toPoint() == origin.position,
                    onTap: () {
                      context.read<TransformCubit>().moveToWaypoint(origin);
                      context.read<DocumentBloc>().bake();
                    },
                  ),
                  const Divider(),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: waypoints.length,
                      itemBuilder: (BuildContext context, int index) {
                        final waypoint = waypoints[index];
                        return ListTile(
                          title: Text(waypoint.name),
                          onTap: () {
                            context
                                .read<TransformCubit>()
                                .moveToWaypoint(waypoint);
                            context.read<DocumentBloc>().bake();
                          },
                          selected: -transform.position.toPoint() ==
                              waypoint.position,
                          trailing: MenuAnchor(
                            builder: defaultMenuButton(),
                            menuChildren: [
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                    PhosphorIconsLight.trash),
                                onPressed: () async {
                                  final result = await showDialog<bool>(
                                      context: context,
                                      builder: (context) =>
                                          const DeleteDialog());
                                  if (result != true) return;
                                  if (context.mounted) {
                                    context
                                        .read<DocumentBloc>()
                                        .add(WaypointRemoved(index));
                                  }
                                },
                                child:
                                    Text(AppLocalizations.of(context).delete),
                              )
                            ],
                          ),
                        );
                      }),
                ]),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton.extended(
                        label: Text(AppLocalizations.of(context).add),
                        icon: const PhosphorIcon(PhosphorIconsLight.plus),
                        onPressed: () {
                          final bloc = context.read<DocumentBloc>();
                          showDialog<String>(
                              builder: (context) => BlocProvider.value(
                                  value: bloc,
                                  child: const WaypointCreateDialog()),
                              context: context);
                        }),
                  ),
                )
              ],
            );
          });
    });
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
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).create),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          controller: _nameController,
          autofocus: true,
          decoration: InputDecoration(
              filled: true, labelText: AppLocalizations.of(context).name),
        ),
        const SizedBox(height: 10),
        CheckboxListTile(
            title: Text(AppLocalizations.of(context).scale),
            value: _saveScale,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) =>
                setState(() => _saveScale = value ?? _saveScale))
      ]),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).cancel)),
        ElevatedButton(
            onPressed: () {
              final bloc = context.read<DocumentBloc>();
              final state = bloc.state;
              if (state is! DocumentLoadSuccess) return;
              final transform =
                  state.currentIndexCubit.state.transformCubit.state;

              bloc.add(WaypointCreated(Waypoint(
                  _nameController.text,
                  -transform.position.toPoint(),
                  _saveScale ? transform.size : null)));
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).create)),
      ],
    );
  }
}
