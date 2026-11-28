import 'package:butterfly/api/swamp.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';

Future<SwampAccessToken?> showSwampJoinTokenDialog(
  BuildContext context, {
  String? savedToken,
}) => showDialog<SwampAccessToken>(
  context: context,
  builder: (context) => _SwampJoinTokenDialog(savedToken: savedToken),
);

class _SwampJoinTokenDialog extends StatefulWidget {
  final String? savedToken;

  const _SwampJoinTokenDialog({required this.savedToken});

  @override
  State<_SwampJoinTokenDialog> createState() => _SwampJoinTokenDialogState();
}

class _SwampJoinTokenDialogState extends State<_SwampJoinTokenDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _controller = TextEditingController(text: widget.savedToken);
  late bool _remember = widget.savedToken != null;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.pop(context, (value: _controller.text, remember: _remember));
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(localizations.swampTokenRequired),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: .min,
          children: [
            TextFormField(
              controller: _controller,
              autofocus: true,
              obscureText: true,
              textInputAction: .go,
              onFieldSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: localizations.swampAccessToken,
                filled: true,
              ),
              validator: (value) => (value?.isEmpty ?? true)
                  ? LeapLocalizations.of(context).shouldNotEmpty
                  : null,
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(localizations.swampRememberToken),
              value: _remember,
              onChanged: (value) => setState(() => _remember = value ?? false),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(onPressed: _submit, child: Text(localizations.connect)),
      ],
    );
  }
}
