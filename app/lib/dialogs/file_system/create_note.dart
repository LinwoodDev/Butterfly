import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateNoteDialog extends StatefulWidget {
  final String suffix;

  const CreateNoteDialog({super.key, this.suffix = '.bfly'});

  @override
  State<CreateNoteDialog> createState() => _CreateNoteDialogState();
}

class _CreateNoteDialogState extends State<CreateNoteDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final colorScheme = ColorScheme.of(context);
    final fileName = convertNameToFile(
      name: _name,
      suffix: widget.suffix,
      getUnnamed: () => loc.untitled,
    );
    return AlertDialog(
      title: Text(loc.newNote),
      scrollable: true,
      constraints: const BoxConstraints(maxWidth: 440),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                filled: true,
                labelText: loc.noteTitle,
              ),
              onChanged: (value) => setState(() => _name = value),
              validator: (value) => value == null || value.trim().isEmpty
                  ? LeapLocalizations.of(context).shouldNotEmpty
                  : null,
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: .start,
                  children: [
                    const PhosphorIcon(PhosphorIconsLight.file),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            loc.fileName,
                            style: TextTheme.of(context).labelMedium,
                          ),
                          Text(
                            fileName,
                            style: TextTheme.of(context).bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loc.fileNameHint,
                            style: TextTheme.of(context).bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(LeapLocalizations.of(context).create),
        ),
      ],
    );
  }
}
