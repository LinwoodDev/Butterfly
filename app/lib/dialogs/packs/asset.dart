import 'dart:typed_data';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';
import 'pack.dart';

class AssetDialog extends StatelessWidget {
  final PackAssetLocation? value;

  const AssetDialog({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    String? pack = value?.namespace;
    String name = value?.key ?? '';
    final bloc = context.read<DocumentBloc>();
    return FutureBuilder<List<FileSystemFile<NoteData>>>(
      future: context
          .read<ButterflyFileSystem>()
          .buildDefaultPackSystem()
          .getFiles(),
      builder: (context, snapshot) => BlocBuilder<DocumentBloc, DocumentState>(
        buildWhen: (previous, current) => previous.data != current.data,
        builder: (context, state) {
          if (state is! DocumentLoaded) return const SizedBox();
          final packs = snapshot.data ?? <FileSystemFile<NoteData>>[];
          pack ??= packs.firstOrNull?.path;
          return AlertDialog(
            title: Text(
              value == null
                  ? AppLocalizations.of(context).addAsset
                  : AppLocalizations.of(context).editAsset,
            ),
            scrollable: true,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: DropdownMenu<String>(
                        label: Text(AppLocalizations.of(context).pack),
                        key: UniqueKey(),
                        dropdownMenuEntries: packs.map((e) {
                          return DropdownMenuEntry<String>(
                            value: e.path,
                            label: e.data!.getMetadata()?.name ?? e.path,
                          );
                        }).toList(),
                        onSelected: (value) {
                          pack = value;
                        },
                        initialSelection: pack,
                        expandedInsets: const EdgeInsets.all(0),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                      onPressed: () async {
                        final pack = await showDialog<NoteData>(
                          context: context,
                          builder: (context) => const PackDialog(),
                        );
                        if (pack == null) return;
                        bloc.add(PackAdded(pack));
                      },
                      tooltip: AppLocalizations.of(context).createPack,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: LeapLocalizations.of(context).name,
                    filled: true,
                  ),
                  initialValue: name,
                  onChanged: (value) {
                    name = value;
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  MaterialLocalizations.of(context).cancelButtonLabel,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (pack == null) return;
                  Navigator.of(context).pop(PackAssetLocation(pack!, name));
                },
                child: Text(MaterialLocalizations.of(context).okButtonLabel),
              ),
            ],
          );
        },
      ),
    );
  }
}

Future<void> addToPack(
  BuildContext context,
  DocumentBloc bloc,
  SettingsCubit settingsCubit,
  List<PadElement> elements,
  Rect rect,
) async {
  final packSystem = context
      .read<ButterflyFileSystem>()
      .buildDefaultPackSystem();
  final state = bloc.state;
  if (state is! DocumentLoadSuccess) return;
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
  var pack = await packSystem.getFile(result.namespace);
  if (pack == null) return;
  final screenshot = await state.currentIndexCubit.render(
    state.data,
    state.page,
    state.info,
    ImageExportOptions(
      width: rect.width,
      height: rect.height,
      renderBackground: true,
      x: rect.left,
      y: rect.top,
      quality: kThumbnailWidth / rect.width,
    ),
  );
  Uint8List? thumbnail;
  if (screenshot != null) {
    thumbnail = screenshot.buffer.asUint8List();
  }
  final renderers = elements.map(Renderer.fromInstance).toList();
  await Future.wait(
    renderers.map(
      (e) async => e.setup(
        state.transformCubit,
        state.data,
        state.assetService,
        state.page,
      ),
    ),
  );
  final transformed = <PadElement>[];
  for (final renderer in renderers) {
    final transformedRenderer = renderer.transform(
      position: -rect.center,
      relative: true,
    );
    final activeRenderer = transformedRenderer ?? renderer;
    transformed.add(activeRenderer.element);
    transformedRenderer?.dispose();
    if (!identical(transformedRenderer, renderer)) {
      renderer.dispose();
    }
  }
  pack = pack.setComponent(
    result.key,
    ButterflyComponent(elements: transformed, thumbnail: thumbnail),
  );
  await packSystem.updateFile(result.namespace, pack);
}
