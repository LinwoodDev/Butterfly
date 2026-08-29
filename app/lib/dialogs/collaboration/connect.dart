import 'package:butterfly/api/open.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ConnectCollaborationDialog extends StatefulWidget {
  const ConnectCollaborationDialog({super.key});

  @override
  State<ConnectCollaborationDialog> createState() =>
      ConnectCollaborationDialogState();
}

class ConnectCollaborationDialogState
    extends State<ConnectCollaborationDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _connect() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final uri = Uri.parse(_urlController.text.trim());
    final url = parseConnectUri(uri);
    Navigator.of(context).pop();
    GoRouter.of(context).pushNamed('connect', queryParameters: {'url': url});
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).collaboration),
      headerActions: [
        IconButton(
          icon: const Icon(PhosphorIconsLight.sealQuestion),
          onPressed: () {
            openHelp(['collaboration']);
          },
          tooltip: AppLocalizations.of(context).help,
        ),
      ],
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
      content: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: _urlController,
              autofocus: true,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.go,
              onFieldSubmitted: (_) => _connect(),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).url,
                filled: true,
              ),
              validator: (value) {
                final raw = value?.trim() ?? '';
                if (raw.isEmpty) {
                  return LeapLocalizations.of(context).shouldNotEmpty;
                }
                final uri = Uri.tryParse(raw);
                if (uri == null || parseConnectUri(uri).isEmpty) {
                  return AppLocalizations.of(context).urlNotValid;
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: _connect,
          child: Text(AppLocalizations.of(context).connect),
        ),
      ],
    );
  }
}
