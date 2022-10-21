import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/header.dart';

class AreasDialog extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  AreasDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: Column(
              children: [
                Header(
                  title: Text(AppLocalizations.of(context)!.areas),
                  leading: IconButton(
                    icon: const Icon(PhosphorIcons.xLight),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            filled: true,
                            prefixIcon:
                                Icon(PhosphorIcons.magnifyingGlassLight),
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
                                  if (state.currentArea != null) ...[
                                    ListTile(
                                        onTap: () {
                                          context.read<DocumentBloc>().add(
                                              const CurrentAreaChanged.exit());
                                          Navigator.of(context).pop();
                                        },
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .exitArea)),
                                    const Divider(),
                                  ],
                                  ...List.generate(areas.length, (index) {
                                    final area = areas[index];
                                    return Dismissible(
                                      key: ObjectKey(area),
                                      background: Container(color: Colors.red),
                                      onDismissed: (direction) {
                                        context
                                            .read<DocumentBloc>()
                                            .add(AreasRemoved([area.name]));
                                      },
                                      child: ListTile(
                                          onTap: () {
                                            context.read<DocumentBloc>().add(
                                                CurrentAreaChanged(area.name));
                                            Navigator.of(context).pop();
                                          },
                                          selected: area.name ==
                                              state.currentAreaName,
                                          trailing: IconTheme(
                                            data: Theme.of(context).iconTheme,
                                            child: PopupMenuButton(
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                    value: 0,
                                                    padding: EdgeInsets.zero,
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
                                                              nameController =
                                                              TextEditingController(
                                                                  text: areas[
                                                                          index]
                                                                      .name);
                                                          var bloc = context.read<
                                                              DocumentBloc>();
                                                          Navigator.of(context)
                                                              .pop();
                                                          var formKey =
                                                              GlobalKey<
                                                                  FormState>();
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      Form(
                                                                        key:
                                                                            formKey,
                                                                        child:
                                                                            AlertDialog(
                                                                          title:
                                                                              Text(AppLocalizations.of(context)!.rename),
                                                                          content:
                                                                              TextFormField(
                                                                            validator:
                                                                                (value) {
                                                                              if (value?.isEmpty ?? true) {
                                                                                return AppLocalizations.of(context)!.shouldNotEmpty;
                                                                              }
                                                                              if (state.document.getAreaByName(value!) != null) {
                                                                                return AppLocalizations.of(context)!.alreadyExists;
                                                                              }
                                                                              return null;
                                                                            },
                                                                            decoration:
                                                                                const InputDecoration(filled: true),
                                                                            controller:
                                                                                nameController,
                                                                            autofocus:
                                                                                true,
                                                                          ),
                                                                          actions: [
                                                                            TextButton(
                                                                              child: Text(AppLocalizations.of(context)!.cancel),
                                                                              onPressed: () => Navigator.of(context).pop(),
                                                                            ),
                                                                            ElevatedButton(
                                                                              child: Text(AppLocalizations.of(context)!.ok),
                                                                              onPressed: () {
                                                                                if (!(formKey.currentState?.validate() ?? false)) return;
                                                                                Navigator.of(context).pop();
                                                                                bloc.add(AreaChanged(area.name, areas[index].copyWith(name: nameController.text)));
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ));
                                                        })),
                                              ],
                                            ),
                                          ),
                                          title: Text(areas[index].name)),
                                    );
                                  })
                                ]);
                              }),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            )));
  }
}
