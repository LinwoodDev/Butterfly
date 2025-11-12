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

class ConnectCollaborationDialogState extends State<ConnectCollaborationDialog>
    with TickerProviderStateMixin {
  final TextEditingController _urlConntroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _urlConntroller.dispose();
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
      content: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            controller: _urlConntroller,
            autofocus: true,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).url,
              filled: true,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            final url = parseConnectUri(Uri.parse(_urlConntroller.text));
            if (url.isEmpty) return;
            GoRouter.of(
              context,
            ).pushNamed('connect', queryParameters: {'url': url});
          },
          child: Text(AppLocalizations.of(context).connect),
        ),
      ],
    );
  }
}
