import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:keybinder/keybinder.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchIntent extends Intent {
  const SearchIntent();
}

const searchShortcut = ShortcutDefinition(
  id: 'search',
  intent: SearchIntent(),
  defaultActivator: SingleActivator(LogicalKeyboardKey.keyK, control: true),
);

Future<List<SearchResult>> _searchIsolate(
  NoteData noteData,
  String currentPage,
  DocumentPage page,
  String query,
) => compute(
  (e) => e.$1
      .search(RegExp(RegExp.escape(e.$2), caseSensitive: false), e.$3, e.$4)
      .take(20)
      .toList(),
  (noteData, query, currentPage, page),
);

class SearchButton extends StatefulWidget {
  final SearchController controller;
  final Widget Function(BuildContext context, Widget searchButton)?
  anchorBuilder;
  final OutlinedBorder? viewShape;
  final bool? isFullScreen;

  const SearchButton({
    super.key,
    required this.controller,
    this.anchorBuilder,
    this.viewShape,
    this.isFullScreen,
  });

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  ({String query, DocumentLoaded state, Future<List<SearchResult>> results})?
  _search;

  Future<List<SearchResult>> _getResults(DocumentLoaded state, String query) {
    final search = _search;
    if (search != null &&
        search.query == query &&
        identical(search.state, state)) {
      return search.results;
    }
    final results = Future<List<SearchResult>>.delayed(
      const Duration(milliseconds: 150),
      () {
        if (!mounted || widget.controller.text.trim() != query) {
          return <SearchResult>[];
        }
        return _searchIsolate(
          state.data.setInfo(state.info),
          state.pageName,
          state.page,
          query,
        );
      },
    );
    _search = (query: query, state: state, results: results);
    return results;
  }

  void _openResult(SearchResult result) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (!widget.controller.isOpen || state is! DocumentLoaded) return;
    widget.controller.closeView(null);

    if (result is ToolResult) {
      if (result.index < 0 || result.index >= state.info.tools.length) return;
      final controller = bloc.editorController;
      controller.toolCubit.resetSelection();
      controller.toolCubit.changeTool(
        controller,
        bloc,
        index: result.index,
        context: context,
      );
      return;
    }
    final page = result.getPage();
    if (page != null) {
      bloc.add(
        PageChanged(
          page,
          position: result.getPosition(),
          zoom: result is WaypointResult ? result.waypoint.scale : null,
        ),
      );
    }
  }

  Future<void> _submit(DocumentBloc bloc) async {
    final query = widget.controller.text.trim();
    final state = bloc.state;
    if (query.isEmpty || state is! DocumentLoaded) return;
    final List<SearchResult> results;
    try {
      results = await _getResults(state, query);
    } catch (_) {
      return;
    }
    if (!mounted ||
        !widget.controller.isOpen ||
        widget.controller.text.trim() != query ||
        results.isEmpty) {
      return;
    }
    _openResult(results.first);
  }

  PhosphorIconData _getIcon(SearchResult item) => switch (item) {
    ElementResult e => e.element.icon(),
    WaypointResult _ => PhosphorIconsLight.mapPin,
    AreaResult _ => PhosphorIconsLight.selection,
    PageResult _ => PhosphorIconsLight.book,
    ToolResult e => e.tool.icon(),
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
      NoteData.getPageNameFromRealName(e.name).isEmpty
          ? AppLocalizations.of(context).untitled
          : NoteData.getPageNameFromRealName(e.name),
    ElementResult e => e.text,
    AreaResult e => e.area.name,
    WaypointResult e => e.waypoint.name ?? '',
    ToolResult e => e.tool.getDisplay(context),
  };

  Widget _buildResult(BuildContext context, SearchResult result, String query) {
    final colors = ColorScheme.of(context);
    final page = result.getPage();
    final pageName = page == null ? '' : NoteData.getPageNameFromRealName(page);
    final kind = _getLocalizedName(result, context);
    final subtitle = page == null || result is PageResult
        ? kind
        : '$kind · ${pageName.isEmpty ? AppLocalizations.of(context).untitled : pageName}';
    final text = _getDisplay(result, context).replaceAll(RegExp(r'\s+'), ' ');
    final pattern = RegExp(RegExp.escape(query), caseSensitive: false);
    final firstMatch = pattern.firstMatch(text);
    final start = firstMatch == null || firstMatch.start < 48
        ? 0
        : firstMatch.start - 32;
    final finish = start + 200 < text.length ? start + 200 : text.length;
    final excerpt =
        '${start > 0 ? '…' : ''}${text.substring(start, finish)}${finish < text.length ? '…' : ''}';
    final spans = <TextSpan>[];
    var end = 0;
    for (final match in pattern.allMatches(excerpt)) {
      spans.add(TextSpan(text: excerpt.substring(end, match.start)));
      spans.add(
        TextSpan(
          text: excerpt.substring(match.start, match.end),
          style: TextStyle(fontWeight: FontWeight.bold, color: colors.primary),
        ),
      );
      end = match.end;
    }
    spans.add(TextSpan(text: excerpt.substring(end)));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: PhosphorIcon(
            _getIcon(result),
            size: 20,
            color: colors.onPrimaryContainer,
          ),
        ),
        title: Text.rich(
          TextSpan(children: spans),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: PhosphorIcon(
          PhosphorIconsLight.arrowUpRight,
          size: 18,
          color: colors.onSurfaceVariant,
        ),
        onTap: () => _openResult(result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final loc = AppLocalizations.of(context);
    return SearchAnchor(
      searchController: widget.controller,
      viewShape: widget.viewShape,
      isFullScreen: widget.isFullScreen,
      viewHintText: loc.searchDocument,
      viewConstraints: const BoxConstraints(
        minWidth: 400,
        maxWidth: 560,
        maxHeight: 480,
      ),
      shrinkWrap: true,
      textInputAction: TextInputAction.search,
      viewOnOpen: () {
        _search = null;
      },
      viewOnSubmitted: (_) => _submit(bloc),
      builder: (BuildContext context, SearchController controller) {
        final searchButton = Actions(
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
            tooltip: loc.search,
            onPressed: controller.openView,
          ),
        );
        return widget.anchorBuilder?.call(context, searchButton) ??
            searchButton;
      },
      suggestionsBuilder: (context, controller) {
        final query = controller.text.trim();
        final state = bloc.state;
        if (query.isEmpty) {
          _search = null;
          return [
            _SearchMessage(
              icon: PhosphorIconsLight.magnifyingGlass,
              title: loc.searchDocument,
              message: loc.searchDocumentHelp,
            ),
          ];
        }
        if (state is! DocumentLoaded) return const <Widget>[];
        return [
          FutureBuilder<List<SearchResult>>(
            future: _getResults(state, query),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 12),
                      Text(loc.loading),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return _SearchMessage(
                  icon: PhosphorIconsLight.warningCircle,
                  title: loc.searchFailed,
                  message: loc.searchFailedHelp,
                );
              }
              final results = snapshot.data ?? const <SearchResult>[];
              if (results.isEmpty) {
                return _SearchMessage(
                  icon: PhosphorIconsLight.magnifyingGlass,
                  title: loc.searchNoResults,
                  message: loc.searchNoResultsHelp,
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: results
                      .map((result) => _buildResult(context, result, query))
                      .toList(),
                ),
              );
            },
          ),
        ];
      },
    );
  }
}

class _SearchMessage extends StatelessWidget {
  final PhosphorIconData icon;
  final String title;
  final String message;

  const _SearchMessage({
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    final text = TextTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhosphorIcon(icon, size: 32, color: colors.onSurfaceVariant),
          const SizedBox(height: 12),
          Text(title, style: text.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(
            message,
            style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
