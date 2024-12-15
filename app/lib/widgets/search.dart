import 'dart:isolate';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Future<List<SearchResult>> _searchIsolate(NoteData noteData, String currentPage,
        DocumentPage page, String query) =>
    Isolate.run(() => noteData
        .search(RegExp(query, caseSensitive: false), currentPage, page)
        .toList());

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  IconGetter _getIcon(SearchResult item) => switch (item) {
        ElementResult e => e.element.icon,
        WaypointResult _ => PhosphorIcons.mapPin,
        AreaResult _ => PhosphorIcons.selection,
        PageResult _ => PhosphorIcons.book,
        ToolResult e => e.tool.icon,
      };

  String _getLocalizedName(SearchResult item, BuildContext context) =>
      switch (item) {
        ElementResult e => e.element.getLocalizedName(context),
        WaypointResult _ => AppLocalizations.of(context).waypoint,
        AreaResult _ => AppLocalizations.of(context).area,
        PageResult _ => AppLocalizations.of(context).page,
        ToolResult _ => AppLocalizations.of(context).tool,
      };

  String _getDisplay(SearchResult item, BuildContext context) => switch (item) {
        PageResult e => e.name,
        ElementResult e => e.text,
        AreaResult e => e.area.name,
        WaypointResult e => e.waypoint.name,
        ToolResult e => e.tool.getDisplay(context),
      };

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    return SearchAnchor(
        builder: (BuildContext context, SearchController controller) =>
            IconButton(
              icon: const Icon(PhosphorIconsLight.magnifyingGlass),
              tooltip: AppLocalizations.of(context).search,
              onPressed: () {
                controller.openView();
              },
            ),
        suggestionsBuilder: (context, controller) async {
          final state = bloc.state;
          List<SearchResult> results = [];
          if (state is DocumentLoaded) {
            results = await _searchIsolate(
                state.data, state.pageName, state.page, controller.text);
          }
          return results.map(
            (result) {
              return ListTile(
                leading:
                    PhosphorIcon(_getIcon(result)(PhosphorIconsStyle.light)),
                title: Text(_getLocalizedName(result, context)),
                subtitle: Text(_getDisplay(result, context)),
                onTap: () {
                  final state = bloc.state;
                  if (state is! DocumentLoaded) return;
                  final cubit = state.currentIndexCubit;
                  final position = result.getPosition();
                  final page = result.getPage();
                  if (page != null) {
                    bloc.add(PageChanged(page));
                  }
                  if (position != null) {
                    state.transformCubit.teleport(position.toOffset());
                  }
                  cubit.bake(state);
                  if (result is ToolResult) {
                    cubit.resetSelection();
                    cubit.changeTool(
                      bloc,
                      index: result.index,
                      context: context,
                    );
                  }
                  Navigator.pop(context);
                },
              );
            },
          );
        });
  }
}
