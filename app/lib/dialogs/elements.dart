import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/packs/asset.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/visualizer/event.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lw_sysinfo/lw_sysinfo.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../renderers/renderer.dart';
import '../bloc/document_bloc.dart';
import '../services/import.dart';

ContextMenuBuilder buildElementsContextMenu(
    DocumentBloc bloc,
    DocumentLoadSuccess state,
    SettingsCubit settingsCubit,
    ImportService importService,
    ClipboardManager clipboardManager,
    Offset position,
    List<Renderer<PadElement>> renderers,
    Rect rect) {
  final cubit = state.currentIndexCubit;
  return (context) => [
        if (renderers.isEmpty) ...[
          ContextMenuItem(
            onPressed: () {
              Navigator.of(context).pop(true);
              final clipboard = clipboardManager.getContent();
              if (clipboard == null) return;
              try {
                importService.import(
                    AssetFileType.values.byName(clipboard.type),
                    clipboard.data,
                    state.data,
                    position:
                        state.transformCubit.state.localToGlobal(position));
              } catch (_) {}
            },
            icon: const PhosphorIcon(PhosphorIconsLight.clipboard),
            label: AppLocalizations.of(context).paste,
          ),
        ] else ...[
          ContextMenuItem(
            onPressed: () {
              Navigator.of(context).pop(true);
              cubit.fetchHandler<SelectHandler>()?.copySelection(context, true);
            },
            icon: const PhosphorIcon(PhosphorIconsLight.scissors),
            label: AppLocalizations.of(context).cut,
          ),
          ContextMenuItem(
            onPressed: () {
              Navigator.of(context).pop(true);
              cubit
                  .fetchHandler<SelectHandler>()
                  ?.copySelection(context, false);
            },
            icon: const PhosphorIcon(PhosphorIconsLight.copy),
            label: AppLocalizations.of(context).copy,
          ),
          ContextMenuItem(
            icon: const PhosphorIcon(PhosphorIconsLight.copy),
            onPressed: () {
              Navigator.of(context).pop(true);
              cubit.fetchHandler<SelectHandler>()?.transform(
                  bloc,
                  renderers
                      .map((e) => Renderer.fromInstance(e.element))
                      .toList(),
                  null,
                  true);
            },
            label: AppLocalizations.of(context).duplicate,
          ),
          ContextMenuItem(
            onPressed: () {
              Navigator.of(context).pop(true);
              bloc.add(
                  ElementsRemoved(renderers.map((r) => r.element).toList()));
            },
            icon: const PhosphorIcon(PhosphorIconsLight.trash),
            label: AppLocalizations.of(context).delete,
          ),
          ContextMenuGroup(
            icon: const Icon(PhosphorIconsLight.layout),
            children: Arrangement.values
                .map((e) => MenuItemButton(
                      leadingIcon: Icon(e.icon(PhosphorIconsStyle.light)),
                      child: Text(e.getLocalizedName(context)),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        bloc.add(ElementsArranged(
                            renderers.map((r) => r.element).toList(), e));
                      },
                    ))
                .toList(),
            label: AppLocalizations.of(context).arrange,
          ),
          ContextMenuItem(
            onPressed: () {
              Navigator.of(context).pop(true);
              if (renderers.isEmpty) return;
              cubit.changeSelection(renderers.first);
              renderers.sublist(1).forEach((r) => cubit.insertSelection(r));
            },
            icon: const PhosphorIcon(PhosphorIconsLight.faders),
            label: AppLocalizations.of(context).properties,
          ),
          ContextMenuItem(
            icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
            label: AppLocalizations.of(context).addToPack,
            onPressed: () async {
              Navigator.of(context).pop();
              addToPack(
                context,
                bloc,
                settingsCubit,
                renderers.map((e) => e.element).toList(),
                rect,
              );
            },
          ),
        ],
      ];
}
