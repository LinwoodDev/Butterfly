import 'dart:isolate';
import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/helpers/point_helper.dart';
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

Future<List<SearchResult>> _searchIsolate(DocumentPage page, String query) =>
    Isolate.run(() => page.search(RegExp(query, caseSensitive: false)));

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<SearchResult>> _searchResults = Future.value([]);
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

  void _search(DocumentPage page, String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = Future.value([]);
      } else {
        _searchResults = _searchIsolate(page, query);
      }
    });
  }

  IconGetter _getIcon(Object item) {
    if (item is PadElement) {
      return item.icon;
    }
    if (item is Waypoint) {
      return PhosphorIcons.mapPin;
    }
    if (item is Area) {
      return PhosphorIcons.selection;
    }
    return PhosphorIcons.question;
  }

  String _getLocalizedName(Object item, BuildContext context) {
    if (item is PadElement) {
      return item.getLocalizedName(context);
    }
    if (item is Waypoint) {
      return AppLocalizations.of(context).waypoint;
    }
    if (item is Area) {
      return AppLocalizations.of(context).area;
    }
    return '';
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
                            onChanged: (value) {
                              final state = context.read<DocumentBloc>().state;
                              if (state is DocumentLoaded) {
                                _search(state.page, value);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.x),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: FutureBuilder<List<SearchResult>>(
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
                            final results = snapshot.data ?? [];
                            return ListView.builder(
                              itemCount: results.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final result = results[index];
                                return ListTile(
                                  leading: PhosphorIcon(_getIcon(result.item)(
                                      PhosphorIconsStyle.light)),
                                  title: Text(
                                      _getLocalizedName(result.item, context)),
                                  subtitle: Text(result.name),
                                  onTap: () {
                                    final state =
                                        context.read<DocumentBloc>().state;
                                    if (state is DocumentLoaded) {
                                      state.transformCubit.setPosition(
                                          result.location.toOffset());
                                      state.currentIndexCubit
                                          .bake(state.data, state.page);
                                      Navigator.pop(context);
                                    }
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
