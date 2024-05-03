import 'dart:isolate';
import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

Future<List<SearchResult>> _searchIsolate(NoteData noteData, String currentPage,
        DocumentPage page, String query) =>
    Isolate.run(() => noteData
        .search(RegExp(query, caseSensitive: false), currentPage, page)
        .toList());

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  Future<Iterable<SearchResult>> _searchResults = Future.value([]);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  void _search(
      NoteData data, String query, String currentPage, DocumentPage page) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = Future.value([]);
      } else {
        _searchResults = _searchIsolate(data, currentPage, page, query);
      }
    });
  }

  IconGetter _getIcon(SearchResult item) {
    return item.map(
      element: (item) => item.element.icon,
      waypoint: (_) => PhosphorIcons.mapPin,
      area: (_) => PhosphorIcons.selection,
      page: (_) => PhosphorIcons.book,
      tool: (_) => PhosphorIcons.hammer,
    );
  }

  String _getLocalizedName(SearchResult item, BuildContext context) {
    return item.map(
      element: (item) => item.element.getLocalizedName(context),
      waypoint: (_) => AppLocalizations.of(context).waypoint,
      area: (_) => AppLocalizations.of(context).area,
      page: (_) => AppLocalizations.of(context).page,
      tool: (_) => AppLocalizations.of(context).tool,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: min(constraints.maxWidth, 600),
            child: Material(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                          child: SearchBar(
                            controller: _searchController,
                            focusNode: _focusNode,
                            leading: const PhosphorIcon(
                                PhosphorIconsLight.magnifyingGlass),
                            onChanged: (value) {
                              final state = context.read<DocumentBloc>().state;
                              if (state is DocumentLoaded) {
                                _search(state.data, value, state.pageName,
                                    state.page);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.outlined(
                          icon: const PhosphorIcon(PhosphorIconsLight.x),
                          onPressed: () => Navigator.pop(context),
                          tooltip: AppLocalizations.of(context).close,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: FutureBuilder<Iterable<SearchResult>>(
                          future: _searchResults,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              );
                            }
                            final results = snapshot.data?.toList() ?? [];
                            return ListView.builder(
                              itemCount: results.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final result = results[index];
                                return ListTile(
                                  leading: PhosphorIcon(_getIcon(result)(
                                      PhosphorIconsStyle.light)),
                                  title:
                                      Text(_getLocalizedName(result, context)),
                                  subtitle: Text(result.getDisplay()),
                                  onTap: () {
                                    final bloc = context.read<DocumentBloc>();
                                    final state = bloc.state;
                                    if (state is! DocumentLoaded) return;
                                    final cubit = state.currentIndexCubit;
                                    final position = result.getPosition();
                                    final page = result.getPage();
                                    if (page != null) {
                                      bloc.add(PageChanged(page));
                                    }
                                    if (position != null) {
                                      state.transformCubit
                                          .teleport(position.toOffset());
                                    }
                                    cubit.bake(
                                        state.data, state.page, state.info);
                                    if (result is ToolResult) {
                                      cubit.resetSelection();
                                      cubit.changeTool(
                                        context.read<DocumentBloc>(),
                                        index: result.index,
                                        context: context,
                                      );
                                    }
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
