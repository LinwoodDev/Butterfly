import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Future<String?> showPasswordDialog(
  BuildContext context, {
  required String title,
  required String passwordLabel,
  bool confirm = false,
  String? warning,
}) => showDialog<String>(
  context: context,
  builder: (context) => _PasswordDialog(
    title: title,
    passwordLabel: passwordLabel,
    confirm: confirm,
    warning: warning,
  ),
);

class _PasswordDialog extends StatefulWidget {
  final String title;
  final String passwordLabel;
  final bool confirm;
  final String? warning;

  const _PasswordDialog({
    required this.title,
    required this.passwordLabel,
    required this.confirm,
    required this.warning,
  });

  @override
  State<_PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<_PasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmation = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.pop(context, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.warning != null) ...[
              Row(
                children: [
                  const PhosphorIcon(PhosphorIconsLight.warning),
                  const SizedBox(width: 8),
                  Flexible(child: Text(widget.warning!)),
                ],
              ),
              const SizedBox(height: 16),
            ],
            TextFormField(
              controller: _passwordController,
              autofocus: true,
              obscureText: !_showPassword,
              autofillHints: const [AutofillHints.password],
              textInputAction: widget.confirm
                  ? TextInputAction.next
                  : TextInputAction.done,
              onFieldSubmitted: widget.confirm ? null : (_) => _submit(),
              decoration: InputDecoration(
                labelText: widget.passwordLabel,
                filled: true,
                suffixIcon: IconButton(
                  icon: PhosphorIcon(
                    _showPassword
                        ? PhosphorIconsLight.eyeSlash
                        : PhosphorIconsLight.eye,
                  ),
                  tooltip: _showPassword
                      ? localizations.hide
                      : localizations.show,
                  onPressed: () =>
                      setState(() => _showPassword = !_showPassword),
                ),
              ),
              validator: (value) => value?.isEmpty ?? true
                  ? LeapLocalizations.of(context).shouldNotEmpty
                  : null,
            ),
            if (widget.confirm) ...[
              const SizedBox(height: 8),
              TextFormField(
                controller: _confirmationController,
                obscureText: !_showConfirmation,
                autofillHints: const [AutofillHints.password],
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  labelText: localizations.confirmPassword,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: PhosphorIcon(
                      _showConfirmation
                          ? PhosphorIconsLight.eyeSlash
                          : PhosphorIconsLight.eye,
                    ),
                    tooltip: _showConfirmation
                        ? localizations.hide
                        : localizations.show,
                    onPressed: () =>
                        setState(() => _showConfirmation = !_showConfirmation),
                  ),
                ),
                validator: (value) => value != _passwordController.text
                    ? localizations.passwordMismatch
                    : null,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
        ),
      ],
    );
  }
}
