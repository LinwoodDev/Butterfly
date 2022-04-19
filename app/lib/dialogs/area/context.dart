import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../image_export.dart';

class AreaContextMenu extends StatelessWidget {
  final VoidCallback close;
  final Offset position;
  final Area area;

  const AreaContextMenu(
      {Key? key,
      required this.close,
      required this.position,
      required this.area})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        var bloc = context.read<DocumentBloc>();
        if (state is! DocumentLoadSuccess) return Container();
        var index = state.document.areas.indexOf(area);
        return ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 50,
              child: Center(child: Icon(PhosphorIcons.squareLight, size: 36)),
            ),
            ListTile(
              leading: index == state.currentAreaIndex
                  ? const Icon(PhosphorIcons.signInLight)
                  : const Icon(PhosphorIcons.signOutLight),
              title: Text(
                index == state.currentAreaIndex
                    ? AppLocalizations.of(context)!.exitArea
                    : AppLocalizations.of(context)!.enterArea,
              ),
              onTap: () {
                close();
                if (index == state.currentAreaIndex) {
                  bloc.add(const CurrentAreaChanged.exit());
                } else {
                  bloc.add(CurrentAreaChanged(index));
                }
                bloc.add(const IndexRefreshed());
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
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.ok),
                          onPressed: () {
                            Navigator.pop(context);
                            bloc.add(
                              AreaChanged(
                                index,
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
              leading: const Icon(PhosphorIcons.trashLight),
              title: Text(AppLocalizations.of(context)!.delete),
              onTap: () {
                close();
                var bloc = context.read<DocumentBloc>();
                var state = bloc.state;
                if (state is! DocumentLoadSuccess) return;
                bloc.add(AreaRemoved(index));
              },
            )
          ],
        );
      },
    );
  }
}
