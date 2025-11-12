import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/dialogs/packs/components.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ComponentsView extends StatefulWidget {
  const ComponentsView({super.key});

  @override
  State<ComponentsView> createState() => _ComponentsViewState();
}

class _ComponentsViewState extends State<ComponentsView> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> selectedPacks = [];
  late final PackFileSystem _packSystem;
  Future<List<PackItem<ButterflyComponent>>>? _componentsFuture;

  @override
  void initState() {
    super.initState();
    _packSystem = context.read<ButterflyFileSystem>().buildDefaultPackSystem();
    _componentsFuture = _getComponents();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  Future<List<PackItem<ButterflyComponent>>> _getComponents() async {
    final files = await _packSystem.getFiles();
    final packComponents = <PackItem<ButterflyComponent>>[];
    for (final file in files) {
      final pack = file.data!;
      final components = pack
          .getNamedComponents()
          .map((e) => e.toPack(pack, file.pathWithoutLeadingSlash))
          .nonNulls
          .toList();
      packComponents.addAll(components);
    }
    return packComponents;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PackItem<ButterflyComponent>>>(
      future: _componentsFuture,
      builder: (context, snapshot) {
        final allComponents = snapshot.data ?? [];
        final packs = allComponents.map((e) => e.namespace).toSet().toList();
        final components = allComponents
            .where(
              (e) =>
                  selectedPacks.isEmpty || selectedPacks.contains(e.namespace),
            )
            .toList();
        return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
          buildWhen: (previous, current) =>
              previous.temporaryHandler != current.temporaryHandler,
          builder: (context, currentIndex) {
            final handler = currentIndex.temporaryHandler;
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
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: Wrap(
                      children: components.nonNulls.map((e) {
                        final named = e.toNamed();
                        return ComponentCard(
                          component: e.item,
                          name: e.key,
                          selected:
                              handler is StampHandler &&
                              handler.data.component == named,
                          key: ValueKey((e.namespace, e.key)),
                          onTap: () => context
                              .read<CurrentIndexCubit>()
                              .changeTemporaryHandler(
                                context,
                                StampTool(component: named),
                              ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
