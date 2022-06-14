import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RemoteButton extends StatefulWidget {
  final String currentRemote;
  final ValueChanged<String> onChanged;

  const RemoteButton(
      {super.key, this.currentRemote = '', required this.onChanged});

  @override
  State<RemoteButton> createState() => _RemoteButtonState();
}

class _RemoteButtonState extends State<RemoteButton> {
  late String _currentRemote;

  @override
  void initState() {
    _currentRemote = widget.currentRemote;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 100,
            maxWidth: 200,
          ),
          child: DropdownButton<String>(
            onChanged: (String? value) {
              _currentRemote = value ?? widget.currentRemote;
            },
            value: _currentRemote,
            selectedItemBuilder: (BuildContext context) {
              return [
                DropdownMenuItem(
                  child: Text(widget.currentRemote),
                ),
              ];
            },
            items: [
              DropdownMenuItem(
                value: '',
                child: Text(AppLocalizations.of(context)!.local),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: AppLocalizations.of(context)!.configureRemotes,
          icon: const Icon(PhosphorIcons.gearLight),
          onPressed: () {
            Navigator.of(context).pop();
            GoRouter.of(context).push('/settings/remotes');
          },
        ),
      ],
    );
  }
}
