import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../export/general.dart';
import '../packs/asset.dart';
import '../export/pdf.dart';

ContextMenuBuilder buildAreaContextMenu(DocumentBloc bloc,
        DocumentLoadSuccess state, Area area, SettingsCubit settingsCubit) =>
    (context) => [
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
              bloc.add(CurrentAreaChanged(
                  area.name == state.currentAreaName ? '' : area.name));
            },
          ),
          ContextMenuItem(
            icon: const PhosphorIcon(PhosphorIconsLight.trash),
            label: AppLocalizations.of(context).delete,
            onPressed: () {
              Navigator.of(context).pop();
              bloc.add(AreasRemoved([area.name]));
            },
          ),
          ...buildGeneralAreaContextMenu(
            bloc,
            area,
            settingsCubit,
            state.renderers
                .where((e) => e.area == area)
                .map((e) => e.transform(
                    position: -area.position.toOffset(), relative: true))
                .map((e) => e?.element)
                .whereNotNull()
                .toList(),
          )(context)
        ];

ContextMenuBuilder buildGeneralAreaContextMenu(DocumentBloc bloc, Area area,
        SettingsCubit settingsCubit, List<PadElement> elements) =>
    (context) => [
          ContextMenuGroup(
            icon: const PhosphorIcon(PhosphorIconsLight.export),
            label: AppLocalizations.of(context).export,
            children: [
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.fileSvg),
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog<void>(
                      builder: (context) => BlocProvider.value(
                          value: bloc,
                          child: GeneralExportDialog(
                            options: SVGExportOptions(
                              width: area.width,
                              height: area.height,
                              x: area.position.x,
                              y: area.position.y,
                            ),
                          )),
                      context: context);
                },
                child: Text(AppLocalizations.of(context).svg),
              ),
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.fileImage),
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog<void>(
                      builder: (context) => BlocProvider.value(
                            value: bloc,
                            child: GeneralExportDialog(
                              options: ImageExportOptions(
                                width: area.width,
                                height: area.height,
                                x: area.position.x,
                                y: area.position.y,
                                scale: 1,
                              ),
                            ),
                          ),
                      context: context);
                },
                child: Text(AppLocalizations.of(context).image),
              ),
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.filePdf),
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
                child: Text(AppLocalizations.of(context).pdf),
              ),
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.printer),
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog<void>(
                      builder: (context) => BlocProvider.value(
                            value: bloc,
                            child: PdfExportDialog(
                              areas: [AreaPreset(area: area, name: area.name)],
                              print: true,
                            ),
                          ),
                      context: context);
                },
                child: Text(AppLocalizations.of(context).print),
              ),
            ],
          ),
          ContextMenuItem(
            icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
            label: AppLocalizations.of(context).addToPack,
            onPressed: () async {
              Navigator.of(context).pop();
              addToPack(context, bloc, settingsCubit, elements, area.rect);
            },
          ),
        ];
