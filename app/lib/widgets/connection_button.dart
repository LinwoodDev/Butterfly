import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/visualizer/connection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ConnectionButton extends StatefulWidget {
  final String? currentRemote;
  final ValueChanged<ExternalStorage?> onChanged;

  const ConnectionButton({
    super.key,
    this.currentRemote,
    required this.onChanged,
  });

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton> {
  ExternalStorage? _currentConnection;

  @override
  void initState() {
    super.initState();
    _updateConnection();
  }

  void _updateConnection() => _currentConnection = (widget.currentRemote == null
      ? null
      : context.read<SettingsCubit>().state.getRemote(widget.currentRemote));

  @override
  void didUpdateWidget(covariant ConnectionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentRemote != widget.currentRemote) {
      setState(_updateConnection);
    }
  }

  void _onChange(ExternalStorage? value) {
    setState(() {
      _currentConnection = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      builder: (context, settings) {
        if (settings.connections.isEmpty || kIsWeb) {
          return IconButton(
            onPressed: () => widget.onChanged(_currentConnection),
            icon: const PhosphorIcon(PhosphorIconsLight.arrowClockwise),
            tooltip: AppLocalizations.of(context).refresh,
          );
        }
        final selected = TextStyle(color: ColorScheme.of(context).primary);
        return MenuAnchor(
          builder: defaultMenuButton(
            tooltip: AppLocalizations.of(context).connection,
            icon: _currentConnection == null
                ? const PhosphorIcon(PhosphorIconsLight.house)
                : _currentConnection!.icon?.isEmpty ?? true
                ? PhosphorIcon(
                    _currentConnection!.typeIcon(PhosphorIconsStyle.light),
                  )
                : Image.memory(_currentConnection!.icon!, width: 24),
          ),
          menuChildren: [
            MenuItemButton(
              child: Text(
                AppLocalizations.of(context).local,
                style: _currentConnection == null ? selected : null,
              ),
              onPressed: () => _onChange(null),
            ),
            const Divider(),
            ...settings.connections.map(
              (remote) => MenuItemButton(
                onPressed: () => _onChange(remote),
                leadingIcon: remote.icon?.isEmpty ?? true
                    ? PhosphorIcon(remote.typeIcon(PhosphorIconsStyle.light))
                    : Image.memory(remote.icon!, width: 24),
                child: Text(
                  remote.identifier,
                  overflow: TextOverflow.clip,
                  style: _currentConnection?.identifier == remote.identifier
                      ? selected
                      : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
