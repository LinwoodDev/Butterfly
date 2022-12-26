import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/settings.dart';
import '../../models/element.dart';

class PackComponentDialog extends StatefulWidget {
  final MapEntry<bool, ButterflyPack>? pack;
  final int index;
  final ButterflyComponent? component;
  final List<PadElement>? elements;

  const PackComponentDialog({
    super.key,
    this.component,
    this.pack,
    this.index = -1,
    this.elements,
  });

  @override
  State<PackComponentDialog> createState() => _PackComponentDialogState();
}

class _PackComponentDialogState extends State<PackComponentDialog> {
  late final SettingsCubit _settingsCubit;
  late final PackFileSystem _fileSystem;
  String? _pack;
  late ButterflyComponent _component;
  late final Future<List<ButterflyPack>> _packFuture;
  List<ButterflyPack> _documentPacks = [];

  @override
  void initState() {
    super.initState();
    if (widget.pack != null) {
      _pack =
          '${widget.pack!.key ? 'local' : 'document'}:${widget.pack!.value.name}';
    }

    _settingsCubit = context.read<SettingsCubit>();
    _fileSystem = PackFileSystem.fromPlatform(
        remote: _settingsCubit.state.getDefaultRemote());
    _component = widget.component?.copyWith(
            elements: widget.elements ?? widget.component?.elements ?? []) ??
        ButterflyComponent(name: '', elements: widget.elements ?? []);
    final state = context.read<DocumentBloc>().state;
    if (state is DocumentLoadSuccess) _documentPacks = state.document.packs;
    _packFuture = _fileSystem.getPacks();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.component == null
            ? AppLocalizations.of(context)!.addComponent
            : AppLocalizations.of(context)!.editComponent,
      ),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.pack == null) ...[
            FutureBuilder<List<ButterflyPack>>(
              future: _packFuture,
              builder: (context, snapshot) => DropdownButtonFormField<String>(
                value: _pack,
                items: <String>[
                  ..._documentPacks.map((e) => 'document:${e.name}'),
                  ...snapshot.data?.map((e) => 'local:${e.name}').toList() ??
                      [],
                ]
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Row(
                          children: [
                            Icon(e.startsWith('local')
                                ? PhosphorIcons.appWindowLight
                                : PhosphorIcons.fileLight),
                            const SizedBox(width: 8),
                            Text(e.substring(e.indexOf(':') + 1)),
                          ],
                        )))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _pack = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.pack,
                  filled: true,
                  icon: const Icon(PhosphorIcons.packageLight),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          TextField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.name,
              icon: const Icon(Icons.title_outlined),
              filled: true,
            ),
            onChanged: (value) => _component = _component.copyWith(name: value),
            onSubmitted: (value) => _submit(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(
            widget.component == null
                ? AppLocalizations.of(context)!.add
                : AppLocalizations.of(context)!.save,
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    final bloc = context.read<DocumentBloc>();
    if (_component.name.isEmpty) return;

    Navigator.of(context).pop();

    final local = _pack?.startsWith('local') ?? false;
    final packName = _pack?.substring(_pack!.indexOf(':') + 1);
    if (packName == null) return;
    ButterflyPack? pack;
    if (local) {
      pack = await _fileSystem.getPack(packName);
    } else {
      pack = _documentPacks.firstWhere((element) => element.name == packName);
    }
    if (pack == null) return;

    if (widget.index >= 0) {
      pack = pack.copyWith(
        components: [
          ...pack.components.sublist(0, widget.index),
          _component,
          ...pack.components.sublist(widget.index + 1),
        ],
      );
    } else {
      pack = pack.copyWith(
        components: [...pack.components, _component],
      );
    }

    if (local) {
      await _fileSystem.updatePack(pack);
    } else {
      bloc.add(DocumentPackUpdated(pack.name, pack));
    }
  }
}
