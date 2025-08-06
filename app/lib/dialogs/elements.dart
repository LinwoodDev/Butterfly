import 'package:butterfly/dialogs/area/context.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/services/export.dart';
import 'package:butterfly/visualizer/event.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../renderers/renderer.dart';
import '../bloc/document_bloc.dart';
import '../services/import.dart';

ContextMenuBuilder buildElementsContextMenu(
  DocumentBloc bloc,
  DocumentLoadSuccess state,
  ImportService importService,
  ExportService exportService,
  ClipboardManager clipboardManager,
  Offset position,
  List<Renderer<PadElement>> renderers,
  Rect? rect,
) {
  final cubit = state.currentIndexCubit;
  final settingsCubit = state.settingsCubit;
  final operations =
      Map<
        Renderer<PadElement>,
        Map<RendererOperation, RendererOperationCallback>
      >.fromIterable(renderers, value: (e) => e.getOperations());
  final operationKeys = operations.values.expand((e) => e.keys).toList();
  return (context) {
    final rendererContextMenuItem = renderers.length == 1
        ? renderers.first.getContextMenuItem(bloc, context)
        : null;
    return [
      if (rect == null) ...[
        ContextMenuItem(
          onPressed: () {
            Navigator.of(context).pop(true);
            try {
              importService.importClipboard(
                state.data,
                position: state.transformCubit.state.localToGlobal(position),
              );
            } catch (_) {}
          },
          icon: const PhosphorIcon(PhosphorIconsLight.clipboard),
          label: AppLocalizations.of(context).paste,
        ),
      ] else ...[
        ContextMenuItem(
          onPressed: () {
            Navigator.of(context).pop(true);
            cubit.fetchHandler<SelectHandler>()?.copySelection(
              bloc,
              clipboardManager,
              true,
            );
          },
          icon: const PhosphorIcon(PhosphorIconsLight.scissors),
          label: AppLocalizations.of(context).cut,
        ),
        ContextMenuItem(
          onPressed: () {
            Navigator.of(context).pop(true);
            cubit.fetchHandler<SelectHandler>()?.copySelection(
              bloc,
              clipboardManager,
              false,
            );
          },
          icon: const PhosphorIcon(PhosphorIconsLight.copy),
          label: AppLocalizations.of(context).copy,
        ),
        ContextMenuItem(
          icon: const PhosphorIcon(PhosphorIconsLight.copySimple),
          onPressed: () async {
            Navigator.of(context).pop(true);
            final document = state.data;
            final assetService = state.assetService;
            final page = state.page;
            final transforms = renderers
                .map((e) => Renderer.fromInstance(e.element))
                .toList();
            for (final renderer in transforms) {
              await renderer.setup(
                state.transformCubit,
                document,
                assetService,
                page,
              );
            }
            cubit.fetchHandler<SelectHandler>()?.transform(
              bloc,
              null,
              next: transforms,
              duplicate: true,
            );
          },
          label: AppLocalizations.of(context).duplicate,
        ),
        ContextMenuItem(
          onPressed: () {
            Navigator.of(context).pop(true);
            final state = bloc.state;
            if (state is! DocumentLoadSuccess) return;
            bloc.add(
              ElementsRemoved(
                renderers.map((r) => r.element.id).nonNulls.toList(),
              ),
            );
            bloc.delayedBake();
          },
          icon: const PhosphorIcon(PhosphorIconsLight.trash),
          label: AppLocalizations.of(context).delete,
        ),
        ContextMenuGroup(
          icon: const Icon(PhosphorIconsLight.layout),
          children: Arrangement.values
              .map(
                (e) => MenuItemButton(
                  leadingIcon: Icon(e.icon(PhosphorIconsStyle.light)),
                  child: Text(e.getLocalizedName(context)),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    final state = bloc.state;
                    if (state is! DocumentLoadSuccess) return;
                    bloc.add(
                      ElementsArranged(
                        e,
                        renderers.map((r) => r.element.id).nonNulls.toList(),
                      ),
                    );
                  },
                ),
              )
              .toList(),
          label: AppLocalizations.of(context).arrange,
        ),
        if (operationKeys.isNotEmpty)
          ContextMenuGroup(
            label: AppLocalizations.of(context).operations,
            icon: const PhosphorIcon(PhosphorIconsLight.wrench),
            children: operationKeys
                .map(
                  (e) => MenuItemButton(
                    leadingIcon: PhosphorIcon(e.icon(PhosphorIconsStyle.light)),
                    child: Text(e.getLocalizedName(context)),
                    onPressed: () {
                      operations.values
                          .map((v) => v[e])
                          .nonNulls
                          .forEach((e) => e(bloc, context));
                      if (context.mounted) Navigator.of(context).pop(true);
                    },
                  ),
                )
                .toList(),
          ),
        ?rendererContextMenuItem,
        if (renderers.length == 1 &&
            exportService.isExportable(renderers.first.element))
          ContextMenuItem(
            onPressed: () {
              Navigator.of(context).pop(true);
              exportService.export(renderers.first.element);
            },
            icon: const PhosphorIcon(PhosphorIconsLight.export),
            label: AppLocalizations.of(context).export,
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
        ...buildGeneralAreaContextMenu(
          bloc,
          Area(
            width: rect.width,
            height: rect.height,
            position: rect.topLeft.toPoint(),
          ),
          settingsCubit,
          renderers.map((e) => e.element).toList(),
        )(context),
      ],
    ];
  };
}
