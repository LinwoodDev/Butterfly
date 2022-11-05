import 'package:butterfly/models/pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreatePackDialog extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  CreatePackDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.createPack),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name, filled: true),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.description,
              border: const OutlineInputBorder(),
            ),
            minLines: 3,
            maxLines: 5,
            controller: _descriptionController,
          ),
        ],
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
            description: _descriptionController.text,
          )),
          child: Text(AppLocalizations.of(context)!.create),
        ),
      ],
    );
  }
}
