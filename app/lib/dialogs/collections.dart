import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/dialogs/delete.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CollectionsDialog extends StatefulWidget {
  const CollectionsDialog({super.key});

  @override
  State<CollectionsDialog> createState() => _CollectionsDialogState();
}

class _CollectionsDialogState extends State<CollectionsDialog> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < LeapBreakpoints.compact;
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).collections),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            fit: isMobile ? FlexFit.tight : FlexFit.loose,
            child: BlocBuilder<DocumentBloc, DocumentState>(
              buildWhen: (previous, current) =>
                  previous.page?.content != current.page?.content ||
                  previous.currentCollection != current.currentCollection,
              builder: (context, state) {
                final collections = {
                  '',
                  ...?state.page?.content.map((e) => e.collection),
                  state.currentCollection,
                }.nonNulls.toList();
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: collections.length,
                  separatorBuilder: (context, index) =>
                      index == 0 ? const Divider() : const SizedBox(),
                  itemBuilder: (context, index) {
                    final collection = collections[index];
                    return ListTile(
                      title: Text(
                        collection.isEmpty
                            ? AppLocalizations.of(context).defaultCollection
                            : collection,
                      ),
                      selected: collection == state.currentCollection,
                      onTap: () {
                        context.read<DocumentBloc>().add(
                          CurrentCollectionChanged(collection),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      final bloc = context.read<DocumentBloc>();
                      final current = bloc.state.currentCollection ?? '';
                      final name = await showDialog<String>(
                        context: context,
                        builder: (context) => NameDialog(
                          value: current,
                          button: AppLocalizations.of(context).select,
                        ),
                      );
                      if (name == null) return;
                      bloc.add(CurrentCollectionChanged(name));
                    },
                    icon: const PhosphorIcon(PhosphorIconsLight.cursor),
                    tooltip: AppLocalizations.of(
                      context,
                    ).selectCustomCollection,
                  ),
                  const SizedBox(height: 32, child: VerticalDivider()),
                  IconButton(
                    onPressed: () async {
                      final bloc = context.read<DocumentBloc>();
                      Navigator.pop(context);
                      final cubit = bloc.state.currentIndexCubit;
                      if (cubit == null) return;
                      final handler =
                          cubit.fetchHandler<SelectHandler>() ??
                          await cubit.changeTemporaryHandler(
                            context,
                            SelectTool(),
                            bloc: bloc,
                            temporaryState: TemporaryState.removeAfterClick,
                          );
                      if (handler is! SelectHandler) return;
                      handler.selectAll(
                        bloc,
                        (e) =>
                            e.element.collection ==
                            bloc.state.currentCollection,
                      );
                    },
                    tooltip: AppLocalizations.of(context).select,
                    icon: const PhosphorIcon(PhosphorIconsLight.selection),
                  ),
                  IconButton(
                    onPressed: () async {
                      final bloc = context.read<DocumentBloc>();
                      final current = bloc.state.currentCollection ?? '';
                      final name = await showDialog<String>(
                        context: context,
                        builder: (context) => NameDialog(
                          value: current,
                          button: AppLocalizations.of(context).rename,
                        ),
                      );
                      if (name == null) return;
                      bloc.add(CollectionRenamed(current, name));
                    },
                    icon: const PhosphorIcon(PhosphorIconsLight.textT),
                    tooltip: AppLocalizations.of(context).rename,
                  ),
                  IconButton(
                    onPressed: () async {
                      final bloc = context.read<DocumentBloc>();
                      final current = bloc.state.currentCollection ?? '';
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) => const DeleteDialog(),
                      );
                      if (result != true) return;
                      bloc.add(CollectionElementsRemoved(current));
                      if (context.mounted) Navigator.pop(context);
                    },
                    tooltip: AppLocalizations.of(context).deleteElements,
                    icon: const PhosphorIcon(PhosphorIconsLight.trash),
                  ),
                  IconButton(
                    onPressed: () async {
                      final bloc = context.read<DocumentBloc>();
                      final state = bloc.state;
                      if (state is! DocumentLoadSuccess) return;
                      final current = bloc.state.currentCollection ?? '';
                      final name = await showDialog<String>(
                        context: context,
                        builder: (context) => NameDialog(value: current),
                      );
                      if (name == null) return;
                      bloc.add(
                        ElementsLayerConverted(
                          state
                              .getLayer()
                              .content
                              .where((e) => e.collection == current)
                              .map((e) => e.id)
                              .nonNulls
                              .toList(),
                          name,
                        ),
                      );
                      if (context.mounted) Navigator.pop(context);
                    },
                    tooltip: AppLocalizations.of(context).convertToLayer,
                    icon: const PhosphorIcon(PhosphorIconsLight.stack),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      ),
    );
  }
}
