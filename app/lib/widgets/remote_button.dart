import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RemoteButton extends StatefulWidget {
  final String currentRemote;
  final ValueChanged<RemoteStorage?> onChanged;

  const RemoteButton(
      {super.key, this.currentRemote = '', required this.onChanged});

  @override
  State<RemoteButton> createState() => _RemoteButtonState();
}

class _RemoteButtonState extends State<RemoteButton> {
  late RemoteStorage? _currentRemote;

  @override
  void initState() {
    _currentRemote =
        context.read<SettingsCubit>().state.getRemote(widget.currentRemote);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        builder: (context, settings) {
      if (settings.remotes.isEmpty || kIsWeb) {
        return IconButton(
            onPressed: () => widget.onChanged(null),
            icon: const Icon(PhosphorIcons.houseLight));
      }
      return PopupMenuButton<RemoteStorage?>(
        initialValue: _currentRemote,
        position: PopupMenuPosition.under,
        constraints: const BoxConstraints(maxWidth: 500),
        icon: _currentRemote == null
            ? const Icon(PhosphorIcons.houseLight)
            : _currentRemote!.icon.isEmpty
                ? const Icon(PhosphorIcons.cloudLight)
                : Image.memory(_currentRemote!.icon, width: 24),
        onSelected: (remote) {
          setState(() {
            _currentRemote = remote;
          });
          widget.onChanged(remote);
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: null,
            child: Text(AppLocalizations.of(context)!.local),
            onTap: () {
              setState(() {
                _currentRemote = null;
              });
              widget.onChanged(null);
            },
          ),
          const PopupMenuDivider(),
          ...settings.remotes.map((remote) {
            return PopupMenuItem(
              value: remote,
              child: Row(
                children: [
                  if (remote.icon.isNotEmpty) ...[
                    Image.memory(remote.icon, width: 24),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                      child:
                          Text(remote.identifier, overflow: TextOverflow.clip)),
                ],
              ),
            );
          }),
        ],
      );
    });
  }
}
