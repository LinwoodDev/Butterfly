import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly_api/butterfly_api.dart';
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
                  title: Text(AppLocalizations.of(context).areas),
                  leading: IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.x),
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
                            prefixIcon: PhosphorIcon(
                                PhosphorIconsLight.magnifyingGlass),
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
                                        title: Text(AppLocalizations.of(context)
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
                                          trailing: _AreaPopupMenu(area: area),
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

class _AreaPopupMenu extends StatelessWidget {
  const _AreaPopupMenu({
    required this.area,
  });

  final Area area;

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: Theme.of(context).iconTheme,
      child: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
              value: 0,
              padding: EdgeInsets.zero,
              child: ListTile(
                  leading: const PhosphorIcon(PhosphorIconsLight.textT),
                  title: Text(AppLocalizations.of(context).rename),
                  onTap: () async {
                    final TextEditingController nameController =
                        TextEditingController(text: area.name);
                    final bloc = context.read<DocumentBloc>();
                    final state = bloc.state;
                    if (state is! DocumentLoaded) return;
                    Navigator.of(context).pop();
                    final name = await showDialog<String>(
                      context: context,
                      builder: (context) => NameDialog(
                        value: area.name,
                        validator: defaultNameValidator(
                            context, state.document.getAreaNames().toList()),
                      ),
                    );
                    if (name == null) return;
                    bloc.add(AreaChanged(
                        area.name, area.copyWith(name: nameController.text)));
                  })),
        ],
      ),
    );
  }
}
