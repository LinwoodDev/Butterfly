import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/dialogs/svg_export.dart';
import 'package:butterfly/models/area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/context_menu.dart';
import '../image_export.dart';
import '../pdf_export.dart';

class AreaContextMenu extends StatelessWidget {
  final ContextCloseFunction close;
  final Offset position;
  final Area area;

  const AreaContextMenu(
      {super.key,
      required this.close,
      required this.position,
      required this.area});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        var bloc = context.read<DocumentBloc>();
        if (state is! DocumentLoadSuccess) return Container();
        return ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 50,
              child: Center(child: Icon(PhosphorIcons.monitorLight, size: 36)),
            ),
            ListTile(
              leading: area.name == state.currentAreaName
                  ? const Icon(PhosphorIcons.signInLight)
                  : const Icon(PhosphorIcons.signOutLight),
              title: Text(
                area.name == state.currentAreaName
                    ? AppLocalizations.of(context)!.exitArea
                    : AppLocalizations.of(context)!.enterArea,
              ),
              onTap: () {
                close();
                if (area.name == state.currentAreaName) {
                  bloc.add(const CurrentAreaChanged.exit());
                } else {
                  bloc.add(CurrentAreaChanged(area.name));
                }
                context.read<CurrentIndexCubit>().reset(state.document);
              },
            ),
            ListTile(
              leading: const Icon(PhosphorIcons.textTLight),
              title: Text(AppLocalizations.of(context)!.name),
              subtitle: Text(area.name),
              onTap: () {
                final nameController = TextEditingController(text: area.name);
                final formKey = GlobalKey<FormState>();
                close();
                showDialog(
                  context: context,
                  builder: (context) => Form(
                    key: formKey,
                    child: AlertDialog(
                      title: Text(AppLocalizations.of(context)!.enterName),
                      content: TextFormField(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return AppLocalizations.of(context)!.shouldNotEmpty;
                          }
                          if (state.document.getAreaByName(value!) != null) {
                            return AppLocalizations.of(context)!.alreadyExists;
                          }
                          return null;
                        },
                        decoration: const InputDecoration(filled: true),
                        controller: nameController,
                        autofocus: true,
                      ),
                      actions: [
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.cancel),
                          onPressed: () => Navigator.pop(context),
                        ),
                        ElevatedButton(
                          child: Text(AppLocalizations.of(context)!.ok),
                          onPressed: () {
                            Navigator.pop(context);
                            bloc.add(
                              AreaChanged(
                                area.name,
                                area.copyWith(name: nameController.text),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(PhosphorIcons.exportLight),
              title: Text(AppLocalizations.of(context)!.export),
              onTap: () {
                close();
                var bloc = context.read<DocumentBloc>();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    scrollable: true,
                    title: Text(AppLocalizations.of(context)!.export),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.image),
                          onTap: () {
                            Navigator.of(context).pop();
                            showDialog(
                                builder: (context) => BlocProvider.value(
                                      value: bloc,
                                      child: ImageExportDialog(
                                        width: area.width.round(),
                                        height: area.height.round(),
                                        x: area.position.dx,
                                        y: area.position.dy,
                                        scale: 1,
                                      ),
                                    ),
                                context: context);
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.svg),
                          onTap: () {
                            Navigator.of(context).pop();
                            showDialog(
                                builder: (context) => BlocProvider.value(
                                    value: bloc,
                                    child: SvgExportDialog(
                                      width: area.width.round(),
                                      height: area.height.round(),
                                      x: area.position.dx,
                                      y: area.position.dy,
                                    )),
                                context: context);
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.pdf),
                          onTap: () {
                            Navigator.of(context).pop();
                            showDialog(
                                builder: (context) => BlocProvider.value(
                                    value: bloc,
                                    child: PdfExportDialog(areas: [area.name])),
                                context: context);
                          },
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text(AppLocalizations.of(context)!.cancel),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(PhosphorIcons.trashLight),
              title: Text(AppLocalizations.of(context)!.delete),
              onTap: () {
                close();
                var bloc = context.read<DocumentBloc>();
                var state = bloc.state;
                if (state is! DocumentLoadSuccess) return;
                bloc.add(AreasRemoved([area.name]));
              },
            )
          ],
        );
      },
    );
  }
}
