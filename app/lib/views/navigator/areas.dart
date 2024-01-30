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
  const AreasView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
        buildWhen: (previous, current) =>
            previous.cameraViewport != current.cameraViewport,
        builder: (context, currentIndex) {
          final viewport = currentIndex.cameraViewport;
          final viewportRect = viewport.toRect(true);
          print(viewportRect.width);
          return BlocBuilder<DocumentBloc, DocumentState>(
              buildWhen: (previous, current) =>
                  previous.page?.areas != current.page?.areas,
              builder: (context, state) {
                if (state is! DocumentLoadSuccess) {
                  return const SizedBox.shrink();
                }
                var areas = state.page.areas;
                return Stack(
                  children: [
                    ListView.builder(
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
                                .add(AreaChanged(
                                    area.name, area.copyWith(name: value))),
                            selected: area.rect.overlaps(viewportRect),
                            actions: [
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
                                child:
                                    Text(AppLocalizations.of(context).delete),
                              )
                            ],
                          );
                        }),
                  ],
                );
              });
        });
  }
}
