import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:keybinder/keybinder.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchIntent extends Intent {
  const SearchIntent();
}

final searchShortcut = ShortcutDefinition(
  id: 'search',
  intent: const SearchIntent(),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyK,
    control: true,
  ),
);

Future<List<SearchResult>> _searchIsolate(
  NoteData noteData,
  String currentPage,
  DocumentPage page,
  String query,
) => compute(
  (e) => e.$1
      .search(RegExp(e.$2, caseSensitive: false), e.$3, e.$4)
      .take(10)
      .toList(),
  (noteData, query, currentPage, page),
);

class SearchButton extends StatelessWidget {
  final SearchController controller;
  const SearchButton({super.key, required this.controller});

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
    PageResult e =>
      e.name.isEmpty ? AppLocalizations.of(context).untitled : e.name,
    ElementResult e => e.text,
    AreaResult e => e.area.name,
    WaypointResult e => e.waypoint.name ?? '',
    ToolResult e => e.tool.getDisplay(context),
  };

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    return SearchAnchor(
      searchController: controller,
      builder: (BuildContext context, SearchController controller) => Actions(
        actions: {
          SearchIntent: CallbackAction<SearchIntent>(
            onInvoke: (_) {
              controller.openView();
              return null;
            },
          ),
        },
        child: IconButton(
          icon: const Icon(PhosphorIconsLight.magnifyingGlass),
          tooltip: AppLocalizations.of(context).search,
          onPressed: () {
            controller.openView();
          },
        ),
      ),
      suggestionsBuilder: (context, controller) async {
        final state = bloc.state;
        List<SearchResult> results = [];
        if (state is DocumentLoaded) {
          results = await _searchIsolate(
            state.data,
            state.pageName,
            state.page,
            controller.text,
          );
        }
        return results.map((result) {
          return ListTile(
            leading: PhosphorIcon(_getIcon(result)(PhosphorIconsStyle.light)),
            title: Text(_getDisplay(result, context)),
            subtitle: Text(_getLocalizedName(result, context)),
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
                cubit.changeTool(bloc, index: result.index, context: context);
              }
              Navigator.pop(context);
            },
          );
        });
      },
    );
  }
}
