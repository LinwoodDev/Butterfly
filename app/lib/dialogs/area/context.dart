import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly/dialogs/svg_export.dart';
import 'package:butterfly/helpers/point_helper.dart';
import 'package:butterfly/helpers/rect_helper.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../image_export.dart';
import '../packs/asset.dart';
import '../pdf_export.dart';

ContextMenuBuilder buildAreaContextMenu(
    DocumentBloc bloc, DocumentLoadSuccess state, Area area) {
  return (context) => [
        ContextMenuItem(
          icon: const PhosphorIcon(PhosphorIconsLight.textT),
          label: AppLocalizations.of(context).name,
          onPressed: () async {
            Navigator.of(context).pop();
            final name = await showDialog<String>(
                context: context,
                builder: (context) => NameDialog(
                      value: area.name,
                      validator: defaultNameValidator(
                        context,
                        state.page.getAreaNames().toList(),
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
        ContextMenuItem(
          icon: area.name == state.currentAreaName
              ? const PhosphorIcon(PhosphorIconsLight.signIn)
              : const PhosphorIcon(PhosphorIconsLight.signOut),
          label: area.name == state.currentAreaName
              ? AppLocalizations.of(context).exitArea
              : AppLocalizations.of(context).enterArea,
          onPressed: () {
            Navigator.of(context).pop();
            if (area.name == state.currentAreaName) {
              bloc.add(const CurrentAreaChanged.exit());
            } else {
              bloc.add(CurrentAreaChanged(area.name));
            }
          },
        ),
        ContextMenuItem(
          icon: const PhosphorIcon(PhosphorIconsLight.export),
          label: AppLocalizations.of(context).export,
          onPressed: () {
            Navigator.of(context).pop();
            showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                scrollable: true,
                title: Text(AppLocalizations.of(context).export),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MenuItemButton(
                      child: Text(AppLocalizations.of(context).image),
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog<void>(
                            builder: (context) => BlocProvider.value(
                                  value: bloc,
                                  child: ImageExportDialog(
                                    width: area.width,
                                    height: area.height,
                                    x: area.position.x,
                                    y: area.position.y,
                                    scale: 1,
                                  ),
                                ),
                            context: context);
                      },
                    ),
                    MenuItemButton(
                      child: Text(AppLocalizations.of(context).svg),
                      onPressed: () {
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
                    MenuItemButton(
                      child: Text(AppLocalizations.of(context).pdf),
                      onPressed: () {
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
        ContextMenuItem(
          icon: const PhosphorIcon(PhosphorIconsLight.trash),
          label: AppLocalizations.of(context).delete,
          onPressed: () {
            final bloc = context.read<DocumentBloc>();
            final state = bloc.state;
            if (state is! DocumentLoadSuccess) return;
            Navigator.of(context).pop();
            bloc.add(AreasRemoved([area.name]));
          },
        ),
        ContextMenuItem(
          icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
          label: AppLocalizations.of(context).addToPack,
          onPressed: () async {
            final settingsCubit = context.read<SettingsCubit>();
            final bloc = context.read<DocumentBloc>();
            final elements = state.renderers
                .where((e) => e.area == area)
                .map((e) => e.transform(
                    position: -area.position.toOffset(), relative: true))
                .map((e) => e?.element)
                .whereNotNull()
                .toList();
            Navigator.of(context).pop();
            addToPack(context, bloc, settingsCubit, elements, area.rect);
          },
        ),
      ];
}
