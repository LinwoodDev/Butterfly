import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly/dialogs/svg_export.dart';
import 'package:butterfly/helpers/point_helper.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../image_export.dart';
import '../packs/asset.dart';
import '../pdf_export.dart';

class AreaContextMenu extends StatelessWidget {
  final Offset position;
  final Area area;

  const AreaContextMenu(
      {super.key, required this.position, required this.area});

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
                    ? AppLocalizations.of(context).exitArea
                    : AppLocalizations.of(context).enterArea,
              ),
              onTap: () {
                Navigator.of(context).pop();
                if (area.name == state.currentAreaName) {
                  bloc.add(const CurrentAreaChanged.exit());
                } else {
                  bloc.add(CurrentAreaChanged(area.name));
                }
                context.read<CurrentIndexCubit>().reset(bloc);
              },
            ),
            ListTile(
              leading: const Icon(PhosphorIcons.textTLight),
              title: Text(AppLocalizations.of(context).name),
              subtitle: Text(area.name),
              onTap: () async {
                Navigator.of(context).pop();
                final name = await showDialog<String>(
                    context: context,
                    builder: (context) => NameDialog(
                          validator: defaultNameValidator(
                            context,
                            area.name,
                            state.document.getAreaNames().toList(),
                          ),
                        ));
                if (name == null) return;
                bloc.add(
                  AreaChanged(
                    area.name,
                    area.copyWith(name: name),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(PhosphorIcons.exportLight),
              title: Text(AppLocalizations.of(context).export),
              onTap: () {
                final bloc = context.read<DocumentBloc>();
                Navigator.of(context).pop();
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    scrollable: true,
                    title: Text(AppLocalizations.of(context).export),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(AppLocalizations.of(context).image),
                          onTap: () {
                            Navigator.of(context).pop();
                            showDialog<void>(
                                builder: (context) => BlocProvider.value(
                                      value: bloc,
                                      child: ImageExportDialog(
                                        width: area.width.round(),
                                        height: area.height.round(),
                                        x: area.position.x,
                                        y: area.position.y,
                                        scale: 1,
                                      ),
                                    ),
                                context: context);
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context).svg),
                          onTap: () {
                            Navigator.of(context).pop();
                            showDialog<void>(
                                builder: (context) => BlocProvider.value(
                                    value: bloc,
                                    child: SvgExportDialog(
                                      width: area.width.round(),
                                      height: area.height.round(),
                                      x: area.position.x,
                                      y: area.position.y,
                                    )),
                                context: context);
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context).pdf),
                          onTap: () {
                            Navigator.of(context).pop();
                            showDialog<void>(
                                builder: (context) => BlocProvider.value(
                                    value: bloc,
                                    child: PdfExportDialog(areas: [
                                      AreaPreset(area: area, name: area.name)
                                    ])),
                                context: context);
                          },
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text(AppLocalizations.of(context).cancel),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(PhosphorIcons.trashLight),
              title: Text(AppLocalizations.of(context).delete),
              onTap: () {
                final bloc = context.read<DocumentBloc>();
                final state = bloc.state;
                if (state is! DocumentLoadSuccess) return;
                Navigator.of(context).pop();
                bloc.add(AreasRemoved([area.name]));
              },
            ),
            ListTile(
              leading: const Icon(PhosphorIcons.plusCircleLight),
              title: Text(AppLocalizations.of(context).addToPack),
              onTap: () async {
                final settingsCubit = context.read<SettingsCubit>();
                final bloc = context.read<DocumentBloc>();
                final elements = state.renderers
                    .where((e) => e.area == area)
                    .map((e) => e.transform(
                        position: -area.position.toOffset(), relative: true))
                    .map((e) => e?.element)
                    .whereType<PadElement>()
                    .toList();
                final document = state.document;
                Navigator.of(context).pop();
                final result = await showDialog<PackAssetLocation>(
                  context: context,
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: settingsCubit),
                      BlocProvider.value(value: bloc),
                    ],
                    child: const AssetDialog(),
                  ),
                );
                if (result == null) return;
                final pack = document.getPack(result.pack);
                if (pack == null) return;
                final newPack = pack.copyWith(
                  components: pack.components
                      .where((e) => e.name != result.name)
                      .toList()
                    ..add(
                      ButterflyComponent(
                        name: result.name,
                        elements: elements,
                      ),
                    ),
                );
                bloc.add(DocumentPackUpdated(result.pack, newPack));
              },
            )
          ],
        );
      },
    );
  }
}
