import 'package:butterfly/models/pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PackDialog extends StatefulWidget {
  final ButterflyPack? pack;

  const PackDialog({super.key, this.pack});

  @override
  State<PackDialog> createState() => _PackDialogState();
}

class _PackDialogState extends State<PackDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _authorController;
  late final TextEditingController _descriptionController;
  late final List<ButterflyComponent> _components;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.pack?.name);
    _authorController = TextEditingController(text: widget.pack?.author);
    _descriptionController =
        TextEditingController(text: widget.pack?.description);
    _components = List.from(widget.pack?.components ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.pack == null
          ? AppLocalizations.of(context)!.createPack
          : AppLocalizations.of(context)!.editPack),
      content: SizedBox(
        width: 400,
        height: 400,
        child: DefaultTabController(
          length: widget.pack == null ? 1 : 2,
          child: Column(
            children: [
              if (widget.pack != null)
                TabBar(
                    tabs: <dynamic>[
                  [
                    PhosphorIcons.gearLight,
                    AppLocalizations.of(context)!.general
                  ],
                  [
                    PhosphorIcons.puzzlePieceLight,
                    AppLocalizations.of(context)!.components
                  ]
                ]
                        .map((e) => Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(e[0]),
                                  const SizedBox(width: 8),
                                  Text(e[1]),
                                ],
                              ),
                            ))
                        .toList()),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.name,
                            icon: const Icon(Icons.title_outlined),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _authorController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.author,
                            icon: const Icon(Icons.person_outline),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.description,
                            icon: const Icon(Icons.description_outlined),
                            border: const OutlineInputBorder(),
                          ),
                          minLines: 3,
                          maxLines: 5,
                          controller: _descriptionController,
                        ),
                      ],
                    ),
                    if (widget.pack != null)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: (widget.pack?.components ?? [])
                            .asMap()
                            .entries
                            .where((e) => _components.contains(e.value))
                            .map(
                              (e) => Dismissible(
                                key: ValueKey(e.key),
                                onDismissed: (direction) {
                                  setState(() {
                                    _components.remove(e.value);
                                  });
                                },
                                child: ListTile(
                                  title: Text(e.value.name),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(ButterflyPack(
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            name: _nameController.text,
            author: _authorController.text,
            description: _descriptionController.text,
            components: _components,
          )),
          child: Text(widget.pack == null
              ? AppLocalizations.of(context)!.create
              : AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
