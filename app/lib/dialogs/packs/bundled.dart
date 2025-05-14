import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/import/confirmation.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BundledPacksDialog extends StatefulWidget {
  final VoidCallback? onRefresh;

  const BundledPacksDialog({super.key, this.onRefresh});

  @override
  State<BundledPacksDialog> createState() => _BundledPacksDialogState();
}

class _BundledPacksDialogState extends State<BundledPacksDialog> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).bundledPacks),
      leading: IconButton.outlined(
        onPressed: () => Navigator.of(context).pop(),
        icon: const PhosphorIcon(PhosphorIconsLight.x),
      ),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const PhosphorIcon(
                        PhosphorIconsLight.info,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          AppLocalizations.of(
                            context,
                          ).information,
                          style: TextTheme.of(
                            context,
                          ).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(AppLocalizations.of(context).bundledPacksDescription),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: BlocBuilder<DocumentBloc, DocumentState>(
                buildWhen: (previous, current) => ListEquality().equals(
                    previous.data?.getBundledPacks().toList() ?? [],
                    current.data?.getBundledPacks().toList() ?? []),
                builder: (context, state) {
                  final packs = state.data?.getBundledPacks().toList() ?? [];
                  if (packs.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        AppLocalizations.of(context).noPacks,
                        style: TextTheme.of(context).bodyMedium,
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: packs.length,
                    itemBuilder: (context, index) {
                      final name = packs[index];
                      final pack = state.data?.getBundledPack(name);
                      return ListTile(
                        title: Text(name),
                        subtitle: Text(pack?.getMetadata()?.description ?? ''),
                        onTap: () async {
                          final packSystem = context
                              .read<ButterflyFileSystem>()
                              .buildDefaultPackSystem();
                          final metadata = pack?.getMetadata();
                          if (pack == null || metadata == null) return;
                          final result = await showDialog(
                            context: context,
                            builder: (context) => PackImportConfirmationDialog(
                              pack: metadata,
                            ),
                          );
                          if (result != true) return;
                          await packSystem.createFileWithName(
                            pack,
                            name: name,
                            suffix: '.bfly',
                          );
                          widget.onRefresh?.call();
                        },
                        trailing: IconButton(
                          icon: const Icon(PhosphorIconsLight.trash),
                          onPressed: () {
                            context.read<DocumentBloc>().add(PackRemoved(name));
                          },
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
