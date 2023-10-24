import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
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

  void _onChange(RemoteStorage? value) {
    setState(() {
      _currentRemote = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        builder: (context, settings) {
      if (settings.remotes.isEmpty || kIsWeb) {
        return IconButton(
          onPressed: () => widget.onChanged(null),
          icon: const PhosphorIcon(PhosphorIconsLight.arrowClockwise),
          tooltip: AppLocalizations.of(context).refresh,
        );
      }
      return MenuAnchor(
        builder: defaultMenuButton(
          icon: _currentRemote == null
              ? const PhosphorIcon(PhosphorIconsLight.house)
              : _currentRemote!.icon.isEmpty
                  ? const PhosphorIcon(PhosphorIconsLight.cloud)
                  : Image.memory(_currentRemote!.icon, width: 24),
        ),
        menuChildren: [
          MenuItemButton(
            child: Text(AppLocalizations.of(context).local),
            onPressed: () => _onChange(null),
          ),
          const Divider(),
          ...settings.remotes.map((remote) {
            return MenuItemButton(
              onPressed: () => _onChange(remote),
              leadingIcon: remote.icon.isNotEmpty
                  ? Image.memory(remote.icon, width: 24)
                  : null,
              child: Text(remote.identifier, overflow: TextOverflow.clip),
            );
          }),
        ],
      );
    });
  }
}
