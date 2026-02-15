import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/packs/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:collection/collection.dart';

class ToolbarsView extends StatefulWidget {
  const ToolbarsView({super.key});

  @override
  State<ToolbarsView> createState() => _ToolbarsViewState();
}

class _ToolbarsViewState extends State<ToolbarsView> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> selectedPacks = [];
  late final PackFileSystem _packSystem;
  Future<List<PackItem<Toolbar>>>? _toolbarsFuture;

  @override
  void initState() {
    super.initState();
    _packSystem = context.read<ButterflyFileSystem>().buildDefaultPackSystem();
    _toolbarsFuture = _getToolbars();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _reloadToolbars() async {
    _toolbarsFuture = _getToolbars();
    setState(() {});
  }

  Future<List<PackItem<Toolbar>>> _getToolbars() async {
    final files = await _packSystem.getFiles();
    final packToolbars = <PackItem<Toolbar>>[];
    for (final file in files) {
      final pack = file.data!;
      final toolbars = pack
          .getNamedToolbars()
          .map((e) => e.toPack(pack, file.pathWithoutLeadingSlash))
          .nonNulls
          .toList();
      packToolbars.addAll(toolbars);
    }
    return packToolbars;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PackItem<Toolbar>>>(
      future: _toolbarsFuture,
      builder: (context, snapshot) {
        final allToolbars = snapshot.data ?? [];
        final packs = allToolbars.map((e) => e.namespace).toSet().toList();
        final toolbars = allToolbars
            .where(
              (e) =>
                  selectedPacks.isEmpty || selectedPacks.contains(e.namespace),
            )
            .toList();
        final searchText = _searchController.text.toLowerCase();
        final filteredToolbars = toolbars
            .where((e) => e.key.toLowerCase().contains(searchText))
            .toList();

        return BlocBuilder<DocumentBloc, DocumentState>(
          builder: (context, state) {
            if (state is! DocumentLoaded) return const SizedBox.shrink();
            final currentTools = state.info.tools;
            final currentToolbar = allToolbars.firstWhereOrNull(
              (e) => const ListEquality().equals(
                e.item.tools.map((e) => e.id).toList(),
                currentTools.map((e) => e.id).toList(),
              ),
            );
            final isCustom = currentToolbar == null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                SearchBar(
                  hintText: AppLocalizations.of(context).search,
                  leading: Icon(PhosphorIconsLight.magnifyingGlass),
                  controller: _searchController,
                  trailing: [
                    MenuAnchor(
                      builder: defaultMenuButton(),
                      menuChildren: packs
                          .map(
                            (e) => CheckboxMenuButton(
                              value: selectedPacks.contains(e),
                              child: Text(e),
                              onChanged: (value) => setState(() {
                                if (value ?? true) {
                                  selectedPacks.add(e);
                                } else {
                                  selectedPacks.remove(e);
                                }
                              }),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredToolbars.length + (isCustom ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (isCustom && index == 0) {
                      return ListTile(
                        title: Text(AppLocalizations.of(context).custom),
                        subtitle: Text(
                          AppLocalizations.of(context).clickToSave,
                        ),
                        leading: const Icon(PhosphorIconsLight.wrench),
                        selected: true,
                        onTap: () async {
                          final settingsCubit = context.read<SettingsCubit>();
                          final bloc = context.read<DocumentBloc>();
                          final result = await showDialog<PackAssetLocation>(
                            context: context,
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(value: settingsCubit),
                                BlocProvider.value(value: bloc),
                              ],
                              child: const AssetDialog(),
                            ),
                          );
                          if (result == null) return;
                          var pack = await _packSystem.getFile(
                            result.namespace,
                          );
                          if (pack == null) return;
                          final toolbar = Toolbar(
                            tools: bloc.state.info?.tools ?? [],
                          );
                          pack = pack.setToolbar(result.key, toolbar);
                          await _packSystem.updateFile(result.namespace, pack);
                          await _reloadToolbars();
                        },
                      );
                    }
                    final item = filteredToolbars[index - (isCustom ? 1 : 0)];
                    final isSelected = item == currentToolbar;
                    return ListTile(
                      title: Text(item.key),
                      subtitle: Text(item.pack.name ?? item.namespace),
                      selected: isSelected,
                      onTap: () {
                        context.read<DocumentBloc>().add(
                          ToolsReplaced(item.item.tools),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
