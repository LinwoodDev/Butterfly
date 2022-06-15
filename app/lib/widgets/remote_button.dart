import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
    if (kIsWeb) {
      return Container();
    }
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        builder: (context, settings) {
      if (settings.remotes.isEmpty) {
        return Container();
      }
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 200,
                maxWidth: 300,
              ),
              child: DropdownButtonFormField<String>(
                onChanged: (String? value) {
                  _currentRemote = value ?? widget.currentRemote;
                },
                value: _currentRemote,
                selectedItemBuilder: (BuildContext context) {
                  return [];
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.remote,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: '',
                    child: Text(AppLocalizations.of(context)!.local),
                  ),
                  ...settings.remotes.map((remote) {
                    return DropdownMenuItem(
                      value: remote.identifier,
                      child: Text(remote.identifier),
                    );
                  }),
                ],
              ),
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
    });
  }
}
