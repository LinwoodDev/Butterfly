import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/editor_controller.dart';
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
        final packs = {
          for (final item in allComponents)
            item.namespace: getPackDisplayName(item.pack, item.namespace),
        };
        final components = allComponents
            .where(
              (e) =>
                  selectedPacks.isEmpty || selectedPacks.contains(e.namespace),
            )
            .toList();
        return BlocBuilder<ToolCubit, ToolRuntimeState>(
          buildWhen: (previous, current) =>
              previous.temporaryHandler != current.temporaryHandler,
          builder: (context, toolState) {
            final handler = toolState.temporaryHandler;
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
                      menuChildren: packs.entries
                          .map(
                            (e) => CheckboxMenuButton(
                              value: selectedPacks.contains(e.key),
                              child: Text(e.value),
                              onChanged: (value) => setState(() {
                                if (value ?? true) {
                                  selectedPacks.add(e.key);
                                } else {
                                  selectedPacks.remove(e.key);
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
                              .read<EditorController>()
                              .changeTemporaryHandler(
                                context,
                                StampTool(component: named),
                                temporaryState:
                                    TemporaryState.removeAfterRelease,
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
