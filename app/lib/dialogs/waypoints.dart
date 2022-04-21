import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/waypoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WaypointsDialog extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  WaypointsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: Scaffold(
                appBar: AppBar(
                  title: Text(AppLocalizations.of(context)!.waypoints),
                  leading: IconButton(
                    icon: const Icon(PhosphorIcons.xLight),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () => _showCreateDialog(context),
                  label: Text(AppLocalizations.of(context)!.create),
                  icon: const Icon(PhosphorIcons.plusLight),
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(PhosphorIcons.magnifyingGlassLight),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        controller: _searchController,
                        autofocus: true,
                      ),
                    ),
                    const Divider(),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: ValueListenableBuilder(
                        valueListenable: _searchController,
                        builder: (context, value, child) => BlocBuilder<
                                DocumentBloc, DocumentState>(
                            buildWhen: (previous, current) =>
                                (previous as DocumentLoadSuccess)
                                    .document
                                    .waypoints !=
                                (current as DocumentLoadSuccess)
                                    .document
                                    .waypoints,
                            builder: (context, state) {
                              void bake() {
                                var bloc = context.read<DocumentBloc>();
                                var transformCubit =
                                    context.read<TransformCubit>();
                                var state = bloc.state;
                                if (state is! DocumentLoadSuccess) return;
                                var baked = state.cameraViewport;
                                bloc.add(ImageBaked(baked.toSize(), baked.scale,
                                    transformCubit.state));
                              }

                              if (state is! DocumentLoadSuccess) {
                                return Container();
                              }
                              var waypoints = state.document.waypoints
                                  .where((element) => element.name
                                      .contains(_searchController.text))
                                  .toList();
                              var currentArea = state.currentArea;
                              return ListView(children: [
                                ListTile(
                                    onTap: () {
                                      context
                                          .read<TransformCubit>()
                                          .moveToWaypoint(Waypoint.origin);
                                      bake();
                                      Navigator.of(context).pop(true);
                                    },
                                    title: Text(
                                        AppLocalizations.of(context)!.origin)),
                                if (currentArea != null)
                                  ListTile(
                                      onTap: () {
                                        context
                                            .read<TransformCubit>()
                                            .setPosition(-currentArea.position);
                                        bake();
                                        Navigator.of(context).pop(true);
                                      },
                                      title: Text(AppLocalizations.of(context)!
                                          .currentArea)),
                                const Divider(),
                                ...List.generate(
                                    waypoints.length,
                                    (index) => Dismissible(
                                          key: ObjectKey(waypoints[index]),
                                          background:
                                              Container(color: Colors.red),
                                          onDismissed: (direction) {
                                            context
                                                .read<DocumentBloc>()
                                                .add(WaypointRemoved(index));
                                          },
                                          child: ListTile(
                                              onTap: () {
                                                context
                                                    .read<TransformCubit>()
                                                    .moveToWaypoint(
                                                        waypoints[index]);
                                                bake();
                                                Navigator.of(context).pop(true);
                                              },
                                              title:
                                                  Text(waypoints[index].name)),
                                        ))
                              ]);
                            }),
                      ),
                    )),
                  ],
                ))));
  }

  void _showCreateDialog(BuildContext context) {
    var saveScale = true;
    var nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(builder: (ctx, setState) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.create),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: AppLocalizations.of(context)!.name),
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)!.scale),
                      value: saveScale,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) =>
                          setState(() => saveScale = value ?? saveScale))
                ]),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(AppLocalizations.of(context)!.cancel)),
                  TextButton(
                      onPressed: () {
                        context.read<DocumentBloc>().add(WaypointCreated(
                            Waypoint(
                                nameController.text,
                                context.read<TransformCubit>().state.position,
                                saveScale
                                    ? context.read<TransformCubit>().state.size
                                    : null)));
                        Navigator.of(ctx).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.create)),
                ],
              );
            }));
  }
}
