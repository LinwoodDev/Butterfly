import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../export/general.dart';
import '../packs/asset.dart';
import '../export/pdf.dart';

ContextMenuBuilder buildAreaContextMenu(
  DocumentBloc bloc,
  DocumentLoadSuccess state,
  Area area,
  SettingsCubit settingsCubit,
) => (context) {
  final cubit = state.currentIndexCubit;
  return [
    ContextMenuItem(
      icon: const PhosphorIcon(PhosphorIconsLight.textT),
      label: AppLocalizations.of(context).rename,
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
            button: AppLocalizations.of(context).rename,
          ),
        );
        if (name == null) return;
        bloc.add(AreaChanged(area.name, area.copyWith(name: name)));
      },
    ),
    ContextMenuItem(
      icon: area.name == state.currentAreaName
          ? const PhosphorIcon(PhosphorIconsLight.signOut)
          : const PhosphorIcon(PhosphorIconsLight.signIn),
      label: area.name == state.currentAreaName
          ? AppLocalizations.of(context).exitArea
          : AppLocalizations.of(context).enterArea,
      onPressed: () {
        Navigator.of(context).pop();
        bloc.add(
          CurrentAreaChanged(
            area.name == state.currentAreaName ? '' : area.name,
          ),
        );
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
    ContextMenuItem(
      onPressed: () {
        Navigator.of(context).pop(true);
        cubit.changeSelection(area);
      },
      icon: const PhosphorIcon(PhosphorIconsLight.faders),
      label: AppLocalizations.of(context).properties,
    ),
    ...buildGeneralAreaContextMenu(
      bloc,
      area,
      settingsCubit,
      state.renderers
          .where((e) => e.area == area)
          .map(
            (e) => e.transform(
              position: -area.position.toOffset(),
              relative: true,
            ),
          )
          .map((e) => e?.element)
          .nonNulls
          .toList(),
    )(context),
  ];
};

ContextMenuBuilder buildGeneralAreaContextMenu(
  DocumentBloc bloc,
  Area area,
  SettingsCubit settingsCubit,
  List<PadElement> elements, {
  bool pop = true,
}) =>
    (context) => [
      ContextMenuItem(
        onPressed: () async {
          if (pop) Navigator.of(context).pop(true);
          final result = await showDialog<String>(
            builder: (context) =>
                NameDialog(button: AppLocalizations.of(context).update),
            context: context,
          );
          if (result == null) return;
          bloc.add(
            ElementsCollectionChanged(
              elements.map((e) => e.id).nonNulls.toList(),
              result,
            ),
          );
        },
        icon: const PhosphorIcon(PhosphorIconsLight.folder),
        label: AppLocalizations.of(context).changeCollection,
      ),
      ContextMenuItem(
        onPressed: () async {
          if (pop) Navigator.of(context).pop(true);
          final result = await showDialog<String>(
            builder: (context) => NameDialog(),
            context: context,
          );
          if (result == null) return;
          bloc.add(
            ElementsLayerConverted(
              elements.map((e) => e.id).nonNulls.toList(),
              result,
            ),
          );
        },
        icon: const PhosphorIcon(PhosphorIconsLight.stack),
        label: AppLocalizations.of(context).convertToLayer,
      ),
      ContextMenuGroup(
        icon: const PhosphorIcon(PhosphorIconsLight.export),
        label: AppLocalizations.of(context).export,
        children: [
          MenuItemButton(
            leadingIcon: const PhosphorIcon(
              PhosphorIconsLight.fileSvg,
              textDirection: TextDirection.ltr,
            ),
            onPressed: () {
              if (pop) Navigator.of(context).pop();
              showDialog<void>(
                builder: (context) => BlocProvider.value(
                  value: bloc,
                  child: GeneralExportDialog(
                    options: SvgExportOptions(
                      width: area.width,
                      height: area.height,
                      x: area.position.x,
                      y: area.position.y,
                    ),
                  ),
                ),
                context: context,
              );
            },
            child: Text(AppLocalizations.of(context).svg),
          ),
          MenuItemButton(
            leadingIcon: const PhosphorIcon(
              PhosphorIconsLight.fileImage,
              textDirection: TextDirection.ltr,
            ),
            onPressed: () {
              if (pop) Navigator.of(context).pop();
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
                context: context,
              );
            },
            child: Text(AppLocalizations.of(context).image),
          ),
          MenuItemButton(
            leadingIcon: const PhosphorIcon(
              PhosphorIconsLight.filePdf,
              textDirection: TextDirection.ltr,
            ),
            onPressed: () {
              if (pop) Navigator.of(context).pop();
              showDialog<void>(
                builder: (context) => BlocProvider.value(
                  value: bloc,
                  child: PdfExportDialog(
                    areas: [AreaPreset(area: area, name: area.name)],
                  ),
                ),
                context: context,
              );
            },
            child: Text(AppLocalizations.of(context).pdf),
          ),
        ],
      ),
      ContextMenuItem(
        icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
        label: AppLocalizations.of(context).addToPack,
        onPressed: () async {
          if (pop) Navigator.of(context).pop();
          addToPack(context, bloc, settingsCubit, elements, area.rect);
        },
      ),
    ];
