import 'package:butterfly/models/pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.pack?.name);
    _authorController = TextEditingController(text: widget.pack?.author);
    _descriptionController =
        TextEditingController(text: widget.pack?.description);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.pack == null
          ? AppLocalizations.of(context)!.createPack
          : AppLocalizations.of(context)!.editPack),
      content: SizedBox(
        width: 300,
        child: Column(
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
                labelText: AppLocalizations.of(context)!.description,
                icon: const Icon(Icons.description_outlined),
                border: const OutlineInputBorder(),
              ),
              minLines: 3,
              maxLines: 5,
              controller: _descriptionController,
            ),
          ],
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
            components: widget.pack?.components ?? [],
          )),
          child: Text(widget.pack == null
              ? AppLocalizations.of(context)!.create
              : AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
