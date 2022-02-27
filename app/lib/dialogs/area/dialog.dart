import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AreasDialog extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  AreasDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: Scaffold(
                appBar: AppBar(
                  title: Text(AppLocalizations.of(context)!.areas),
                  leading: IconButton(
                    icon: const Icon(PhosphorIcons.xLight),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                backgroundColor: Colors.transparent,
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
                        builder: (context, value, child) =>
                            BlocBuilder<DocumentBloc, DocumentState>(
                                buildWhen: (previous, current) =>
                                    (previous as DocumentLoadSuccess)
                                        .document
                                        .areas !=
                                    (current as DocumentLoadSuccess)
                                        .document
                                        .areas,
                                builder: (context, state) {
                                  if (state is! DocumentLoadSuccess) {
                                    return Container();
                                  }
                                  var areas = state.document.areas
                                      .where((element) => element.name
                                          .contains(_searchController.text))
                                      .toList();
                                  return ListView(children: [
                                    ListTile(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .exitArea)),
                                    const Divider(),
                                    ...List.generate(
                                        areas.length,
                                        (index) => Dismissible(
                                              key: ObjectKey(areas[index]),
                                              background:
                                                  Container(color: Colors.red),
                                              onDismissed: (direction) {
                                                context
                                                    .read<DocumentBloc>()
                                                    .add(AreaRemoved(index));
                                              },
                                              child: ListTile(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  trailing: PopupMenuButton(
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                          value: 0,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: ListTile(
                                                              leading: const Icon(
                                                                  PhosphorIcons
                                                                      .textTLight),
                                                              title: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .rename),
                                                              onTap: () {
                                                                final TextEditingController
                                                                    _nameController =
                                                                    TextEditingController(
                                                                        text: areas[index]
                                                                            .name);
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            AlertDialog(
                                                                              title: Text(AppLocalizations.of(context)!.rename),
                                                                              content: TextField(
                                                                                controller: _nameController,
                                                                                autofocus: true,
                                                                              ),
                                                                              actions: [
                                                                                TextButton(
                                                                                  child: Text(AppLocalizations.of(context)!.cancel),
                                                                                  onPressed: () => Navigator.of(context).pop(),
                                                                                ),
                                                                                TextButton(
                                                                                  child: Text(AppLocalizations.of(context)!.ok),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                    context.read<DocumentBloc>().add(AreaChanged(index, areas[index].copyWith(name: _nameController.text)));
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ));
                                                              })),
                                                    ],
                                                  ),
                                                  title:
                                                      Text(areas[index].name)),
                                            ))
                                  ]);
                                }),
                      ),
                    )),
                  ],
                ))));
  }
}
