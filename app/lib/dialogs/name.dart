import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NameDialog extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FormFieldValidator<String> Function(String?)? validator;
  final String? value;

  NameDialog({
    super.key,
    this.validator,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: value);
    void submit() {
      if (_formKey.currentState!.validate()) {
        Navigator.of(context).pop(nameController.text);
      }
    }

    return Form(
      key: _formKey,
      child: AlertDialog(
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context).cancel)),
          ElevatedButton(
              onPressed: submit,
              child: Text(AppLocalizations.of(context).create)),
        ],
        title: Text(AppLocalizations.of(context).enterName),
        content: TextFormField(
          decoration: InputDecoration(
            filled: true,
            hintText: AppLocalizations.of(context).name,
          ),
          autofocus: true,
          controller: nameController,
          validator: validator?.call(value),
          onFieldSubmitted: (value) => submit(),
        ),
      ),
    );
  }
}

FormFieldValidator<String> Function(String?) defaultNameValidator(
    BuildContext context,
    [List<String> existingNames = const []]) {
  return (currentName) => (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context).shouldNotEmpty;
        }
        if (value == currentName) return null;
        if (existingNames.contains(value)) {
          return AppLocalizations.of(context).alreadyExists;
        }
        return null;
      };
}

const fileNameRegex = r'^[a-zA-Z0-9_\-\.]+$';
// fileNameRegex with slashes but only if they are not at the beginning and minimum one letter is before them
const fileNameRegexWithSlashes = r'^[a-z0-9]+(?:\/[a-z0-9]+)*(?:\.[a-z0-9]+)?$';

FormFieldValidator<String> Function(String?) defaultFileNameValidator(
    BuildContext context,
    [List<String> existingNames = const [],
    bool allowSlashes = true]) {
  final nameValidator = defaultNameValidator(context, existingNames);
  return (currentName) => (value) {
        final nameError = nameValidator(currentName)(value);
        if (nameError != null) return nameError;
        if (allowSlashes) {
          if (!RegExp(fileNameRegexWithSlashes).hasMatch(value!)) {
            return AppLocalizations.of(context).invalidName;
          }
        } else {
          if (!RegExp(fileNameRegex).hasMatch(value!)) {
            return AppLocalizations.of(context).invalidName;
          }
        }
        return null;
      };
}
