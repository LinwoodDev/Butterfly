import 'dart:typed_data';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../helpers/element_helper.dart';

class ComponentsView extends StatefulWidget {
  const ComponentsView({super.key});

  @override
  State<ComponentsView> createState() => _ComponentsViewState();
}

class _ComponentsViewState extends State<ComponentsView> {
  String? currentPack;

  @override
  void initState() {
    super.initState();
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return;
    currentPack = state.data.getPacks().firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      buildWhen: (previous, current) => previous.data != current.data,
      builder: (context, state) {
        if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
        return StreamBuilder<NoteData>(
            stream: state.data.onChange,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              final data = snapshot.data!;
              final pack =
                  currentPack == null ? null : data.getPack(currentPack!);
              return Column(
                children: [
                  const SizedBox(height: 8),
                  DropdownMenu(
                    dropdownMenuEntries: data
                        .getPacks()
                        .map((e) => DropdownMenuEntry(
                              value: e,
                              label: e,
                            ))
                        .toList(),
                    onSelected: (value) => setState(() => currentPack = value),
                    initialSelection: currentPack,
                    label: Text(AppLocalizations.of(context).pack),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: Wrap(
                        children: pack
                                ?.getComponents()
                                .map((e) {
                                  final component = pack.getComponent(e);
                                  if (component == null) return null;
                                  return (e, component);
                                })
                                .whereNotNull()
                                .map((e) {
                                  return _ComponentCard(
                                    component: e.$2,
                                    pack: pack,
                                    location: PackAssetLocation(
                                      currentPack!,
                                      e.$1,
                                    ),
                                    key: ValueKey(e.$1),
                                  );
                                })
                                .toList() ??
                            [],
                      ),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}

class _ComponentCard extends StatelessWidget {
  final ButterflyComponent component;
  final NoteData? pack;
  final PackAssetLocation location;

  const _ComponentCard({
    required this.component,
    required this.pack,
    required this.location,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.read<CurrentIndexCubit>().changeTemporaryHandler(
            context.read<DocumentBloc>(), StampPainter(component: location)),
        child: Container(
            height: 150,
            width: 150,
            padding: const EdgeInsets.all(8),
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
