import 'package:butterfly/api/save.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Future<String?> showFileNamePatternDialog(
  BuildContext context, {
  required String initialValue,
  required String label,
  bool allowEmpty = true,
}) {
  final formKey = GlobalKey<FormState>();
  var value = initialValue;
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(label),
      scrollable: true,
      constraints: const BoxConstraints(maxWidth: 420),
      content: Form(
        key: formKey,
        child: FileNamePatternField(
          initialValue: initialValue,
          label: label,
          autofocus: true,
          allowEmpty: allowEmpty,
          onChanged: (newValue) => value = newValue,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: () {
            if (!(formKey.currentState?.validate() ?? false)) return;
            Navigator.of(context).pop(value.trim());
          },
          child: Text(MaterialLocalizations.of(context).saveButtonLabel),
        ),
      ],
    ),
  );
}

class FileNamePatternField extends StatefulWidget {
  const FileNamePatternField({
    super.key,
    required this.initialValue,
    required this.label,
    required this.onChanged,
    this.autofocus = false,
    this.allowEmpty = true,
  });

  final String initialValue;
  final String label;
  final ValueChanged<String> onChanged;
  final bool autofocus;
  final bool allowEmpty;

  @override
  State<FileNamePatternField> createState() => _FileNamePatternFieldState();
}

class _FileNamePatternFieldState extends State<FileNamePatternField> {
  late String _value = widget.initialValue;

  String? _validate(String? value) {
    final pattern = value?.trim() ?? '';
    if (pattern.isEmpty) {
      return widget.allowEmpty
          ? null
          : LeapLocalizations.of(context).invalidName;
    }
    try {
      final resolved = resolveTemplateFileName(
        pattern,
        DateTime(2000, 12, 31, 23, 59, 58),
      );
      return defaultFileNameValidator(context)(null)(resolved);
    } on FormatException {
      return LeapLocalizations.of(context).invalidName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final preview = previewTemplateFileName(_value);
    final exampleDate = DateTime.now();
    final dateExample = resolveTemplateFileName('{date}', exampleDate);
    final timeExample = resolveTemplateFileName('{time}', exampleDate);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: widget.initialValue,
          autofocus: widget.autofocus,
          onChanged: (value) {
            setState(() => _value = value);
            widget.onChanged(value);
          },
          validator: _validate,
          decoration: InputDecoration(labelText: widget.label, filled: true),
        ),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PhosphorIcon(
                  PhosphorIconsLight.info,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.templateFileNameDescription(
                          templateDateFormatExample,
                          templateTimeFormatExample,
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _PlaceholderExample(
                        placeholder: templateDateFormatExample,
                        result: dateExample,
                      ),
                      const SizedBox(height: 6),
                      _PlaceholderExample(
                        placeholder: templateTimeFormatExample,
                        result: timeExample,
                      ),
                      if (preview != null) ...[
                        const Divider(height: 20),
                        Text(
                          '${localizations.preview}: $preview',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaceholderExample extends StatelessWidget {
  const _PlaceholderExample({required this.placeholder, required this.result});

  final String placeholder;
  final String result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Text(
          '$placeholder  →  $result',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontFamily: 'monospace',
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
