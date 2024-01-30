import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            previous.cameraViewport != current.cameraViewport,
        builder: (context, currentIndex) {
          final viewport = currentIndex.cameraViewport;
          final viewportRect = viewport.toRect(true);
          return BlocBuilder<DocumentBloc, DocumentState>(
              buildWhen: (previous, current) =>
                  previous.page?.areas != current.page?.areas ||
                  previous.currentArea != current.currentArea,
              builder: (context, state) {
                if (state is! DocumentLoadSuccess) {
                  return const SizedBox.shrink();
                }
                return Column(
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
                    if (state.currentArea != null) ...[
                      ListTile(
                          leading:
                              const PhosphorIcon(PhosphorIconsLight.signOut),
                          onTap: () {
                            context
                                .read<DocumentBloc>()
                                .add(const CurrentAreaChanged(''));
                          },
                          title: Text(AppLocalizations.of(context).exitArea)),
                    ],
                    const Divider(),
                    Expanded(
                      child: ListenableBuilder(
                          listenable: _searchController,
                          builder: (context, child) {
                            final areas = state.page.areas
                                .where((area) => area.name
                                    .toLowerCase()
                                    .contains(
                                        _searchController.text.toLowerCase()))
                                .toList();
                            return ListView.builder(
                                itemCount: areas.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final area = areas[index];
                                  return EditableListTile(
                                    initialValue: area.name,
                                    onTap: () {
                                      final screen = context
                                          .read<CurrentIndexCubit>()
                                          .state
                                          .cameraViewport
                                          .toSize();
                                      context
                                          .read<TransformCubit>()
                                          .teleportToArea(area, screen);
                                      context.read<DocumentBloc>().bake();
                                    },
                                    onSaved: (value) => context
                                        .read<DocumentBloc>()
                                        .add(AreaChanged(area.name,
                                            area.copyWith(name: value))),
                                    selected: state.currentArea == null
                                        ? area.rect.overlaps(viewportRect)
                                        : state.currentArea?.name == area.name,
                                    actions: [
                                      MenuItemButton(
                                        leadingIcon: const PhosphorIcon(
                                            PhosphorIconsLight.signIn),
                                        onPressed: () {
                                          context.read<DocumentBloc>().add(
                                              CurrentAreaChanged(area.name));
                                        },
                                        child: Text(AppLocalizations.of(context)
                                            .enterArea),
                                      ),
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
                                                .add(AreasRemoved([area.name]));
                                          }
                                        },
                                        child: Text(AppLocalizations.of(context)
                                            .delete),
                                      )
                                    ],
                                  );
                                });
                          }),
                    ),
                  ],
                );
              });
        });
  }
}
