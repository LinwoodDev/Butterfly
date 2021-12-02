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
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                        title: Text(AppLocalizations.of(context)!.waypoints),
                        leading: const Icon(PhosphorIcons.mapPinLight)),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: _showCreateDialog,
                      label: Text(AppLocalizations.of(context)!.create),
                      icon: const Icon(PhosphorIcons.plusLight),
                    ),
                    body: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: BlocBuilder<DocumentBloc, DocumentState>(
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
                              var waypoints = state.document.waypoints;
                              return Column(children: [
                                ListTile(
                                    onTap: () {
                                      widget.cameraCubit
                                          .moveToWaypoint(Waypoint.origin);
                                      Navigator.of(context).pop();
                                    },
                                    title: Text(
                                        AppLocalizations.of(context)!.origin)),
                                const Divider(),
                                ...List.generate(
                                    waypoints.length,
                                    (index) => Dismissible(
                                          key: ObjectKey(waypoints[index]),
                                          background:
                                              Container(color: Colors.red),
                                          onDismissed: (direction) {
                                            widget.bloc
                                                .add(WaypointRemoved(index));
                                          },
                                          child: ListTile(
                                              onTap: () {
                                                widget.cameraCubit
                                                    .moveToWaypoint(
                                                        waypoints[index]);
                                                Navigator.of(context).pop();
                                              },
                                              title:
                                                  Text(waypoints[index].name)),
                                        ))
                              ]);
                            }))))));
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
                      child: Text(AppLocalizations.of(context)!.no)),
                  TextButton(
                      onPressed: () {
                        widget.bloc.add(WaypointCreated(Waypoint(
                            nameController.text,
                            widget.cameraCubit.state.position,
                            saveScale ? widget.cameraCubit.state.size : null)));
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.yes)),
                ],
              );
            }));
  }
}

class WaypointSearch extends SearchDelegate {
  final DocumentBloc bloc;
  WaypointSearch(this.bloc);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(PhosphorIcons.xLight), onPressed: () {})
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const Icon(PhosphorIcons.magnifyingGlassLight);
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  List<Waypoint> get waypoints {
    var state = bloc.state;
    if (state is! DocumentLoadSuccess) return const [];
    return state.document.waypoints;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestedWords =
        waypoints.where((element) => element.name.startsWith(query)).map((e) {
      var word = e.name;
      var nextWord = word.substring(query.length);
      var spaceIndex = nextWord.indexOf(' ');
      if (spaceIndex < 0) {
        spaceIndex = nextWord.length;
      }
      return word.substring(0, query.length) + nextWord;
    }).toList();
    return ListView.builder(
        itemCount: suggestedWords.length,
        itemBuilder: (context, index) =>
            ListTile(title: Text(suggestedWords[index])));
  }
}
