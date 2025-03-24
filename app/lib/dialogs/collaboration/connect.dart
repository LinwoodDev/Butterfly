import 'package:butterfly/api/open.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';

class ConnectCollaborationDialog extends StatefulWidget {
  const ConnectCollaborationDialog({super.key});

  @override
  State<ConnectCollaborationDialog> createState() =>
      ConnectCollaborationDialogState();
}

class ConnectCollaborationDialogState extends State<ConnectCollaborationDialog>
    with TickerProviderStateMixin {
  final TextEditingController _urlConntroller = TextEditingController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _urlConntroller.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(
        AppLocalizations.of(context).collaboration,
      ),
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
      content: ListView(
        shrinkWrap: true,
        children: [
          TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.fill,
            tabs: [
              Tab(
                text: 'Swamp',
              ),
              Tab(
                text: AppLocalizations.of(context).webSocket,
              ),
            ],
          ),
          const SizedBox(height: 8),
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
            GoRouter.of(context).pushNamed(
              'connect',
              queryParameters: {
                'url': url,
                'type': (switch (_tabController.index) {
                  1 => ConnectionTechnology.webSocket,
                  _ => ConnectionTechnology.swamp,
                })
                    .name,
              },
            );
          },
          child: Text(AppLocalizations.of(context).connect),
        ),
      ],
    );
  }
}
