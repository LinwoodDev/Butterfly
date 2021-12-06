import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/waypoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WaypointsDialog extends StatefulWidget {
  final DocumentBloc bloc;
  final TransformCubit cameraCubit;

  const WaypointsDialog(
      {Key? key, required this.bloc, required this.cameraCubit})
      : super(key: key);

  @override
  _WaypointsDialogState createState() => _WaypointsDialogState();
}

class _WaypointsDialogState extends State<WaypointsDialog> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: widget.bloc),
          BlocProvider.value(value: widget.cameraCubit)
        ],
        child: Dialog(
            child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 600, maxHeight: 800),
                child: Scaffold(
                    appBar: AppBar(
                        title: Text(AppLocalizations.of(context)!.waypoints),
                        leading: const Icon(PhosphorIcons.mapPinLight)),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: _showCreateDialog,
                      label: Text(AppLocalizations.of(context)!.create),
                      icon: const Icon(PhosphorIcons.plusLight),
                    ),
                    body: Column(
                      children: [
                        Material(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  prefixIcon:
                                      Icon(PhosphorIcons.magnifyingGlassLight),
                                ),
                                controller: _searchController,
                              ),
                            )),
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
                                  if (state is! DocumentLoadSuccess) {
                                    return Container();
                                  }
                                  var waypoints = state.document.waypoints
                                      .where((element) => element.name
                                          .contains(_searchController.text))
                                      .toList();
                                  return ListView(children: [
                                    ListTile(
                                        onTap: () {
                                          widget.cameraCubit
                                              .moveToWaypoint(Waypoint.origin);
                                          Navigator.of(context).pop();
                                        },
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .origin)),
                                    const Divider(),
                                    ...List.generate(
                                        waypoints.length,
                                        (index) => Dismissible(
                                              key: ObjectKey(waypoints[index]),
                                              background:
                                                  Container(color: Colors.red),
                                              onDismissed: (direction) {
                                                widget.bloc.add(
                                                    WaypointRemoved(index));
                                              },
                                              child: ListTile(
                                                  onTap: () {
                                                    widget.cameraCubit
                                                        .moveToWaypoint(
                                                            waypoints[index]);
                                                    Navigator.of(context).pop();
                                                  },
                                                  title: Text(
                                                      waypoints[index].name)),
                                            ))
                                  ]);
                                }),
                          ),
                        )),
                      ],
                    )))));
  }

  void _showCreateDialog() {
    var saveScale = true;
    var nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.create),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
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
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(AppLocalizations.of(context)!.cancel)),
                  TextButton(
                      onPressed: () {
                        widget.bloc.add(WaypointCreated(Waypoint(
                            nameController.text,
                            widget.cameraCubit.state.position,
                            saveScale ? widget.cameraCubit.state.size : null)));
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.create)),
                ],
              );
            }));
  }
}
