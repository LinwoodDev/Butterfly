import 'dart:typed_data';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../helpers/element.dart';

class ComponentsView extends StatefulWidget {
  const ComponentsView({super.key});

  @override
  State<ComponentsView> createState() => _ComponentsViewState();
}

class _ComponentsViewState extends State<ComponentsView> {
  final List<String> selectedPacks = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      buildWhen: (previous, current) => previous.data != current.data,
      builder: (context, state) {
        if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
        return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
          buildWhen: (previous, current) =>
              previous.temporaryHandler != current.temporaryHandler,
          builder: (context, currentIndex) {
            final data = state.data;
            final handler = currentIndex.temporaryHandler;
            final packs = data.getPacks();
            final components = packs
                .where(
                    (e) => selectedPacks.isEmpty || selectedPacks.contains(e))
                .expand((p) {
              final pack = data.getPack(p);
              if (pack == null) {
                return Iterable<
                    (PackAssetLocation, NoteData, ButterflyComponent)>.empty();
              }
              return pack.getComponents().map((e) {
                final component = data.getComponent(e);
                if (component == null) return null;
                return (
                  PackAssetLocation(p, e),
                  pack,
                  component,
                );
              }).nonNulls;
            }).toList();
            return Column(
              children: [
                const SizedBox(height: 8),
                SearchBar(
                  hintText: AppLocalizations.of(context).search,
                  leading: Icon(PhosphorIconsLight.magnifyingGlass),
                  trailing: [
                    MenuAnchor(
                      builder: defaultMenuButton(),
                      menuChildren: packs
                          .map((e) => CheckboxMenuButton(
                                value: selectedPacks.contains(e),
                                child: Text(e),
                                onChanged: (value) => setState(() {
                                  if (value ?? true) {
                                    selectedPacks.add(e);
                                  } else {
                                    selectedPacks.remove(e);
                                  }
                                }),
                              ))
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
                        return _ComponentCard(
                          component: e.$3,
                          pack: e.$2,
                          selected: handler is StampHandler &&
                              handler.data.component == e.$1,
                          location: e.$1,
                          key: ValueKey(e.$1),
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

class _ComponentCard extends StatelessWidget {
  final ButterflyComponent component;
  final NoteData? pack;
  final PackAssetLocation location;
  final bool selected;

  const _ComponentCard({
    required this.component,
    required this.pack,
    required this.location,
    required this.selected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context
            .read<CurrentIndexCubit>()
            .changeTemporaryHandler(context, StampTool(component: location)),
        child: Container(
            height: 150,
            width: 150,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 4,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<Uint8List?>(
                    future: component.thumbnail == null || pack == null
                        ? null
                        : getDataFromSource(pack!, component.thumbnail!),
                    builder: (context, snapshot) {
                      const fallbackWidget = AspectRatio(
                        aspectRatio: 1,
                        child: PhosphorIcon(PhosphorIconsLight.selection),
                      );
                      if (!snapshot.hasData) return fallbackWidget;
                      return Image.memory(
                        snapshot.data!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            fallbackWidget,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  component.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ),
    );
  }
}
