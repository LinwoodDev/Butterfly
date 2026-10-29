import 'dart:typed_data';

import 'package:butterfly/api/connection_icon.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ConnectionIconField extends StatelessWidget {
  final Uint8List? value;
  final IconData fallbackIcon;
  final ValueChanged<Uint8List?> onChanged;

  const ConnectionIconField({
    super.key,
    required this.value,
    required this.onChanged,
    this.fallbackIcon = PhosphorIconsLight.image,
  });

  Future<void> _pickIcon(BuildContext context) async {
    final loc = AppLocalizations.of(context);
    try {
      final (bytes, _, _) = await importFile(context, [AssetFileType.image]);
      if (bytes == null) return;
      final icon = await decodeConnectionIcon(bytes);
      if (!context.mounted) return;
      if (icon != null) {
        onChanged(icon);
        return;
      }
    } catch (_) {
      if (!context.mounted) return;
    }
    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.error),
        content: Text(loc.invalidConnectionIcon),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ListTile(
      title: Text(loc.icon),
      leading: value == null
          ? PhosphorIcon(fallbackIcon)
          : Image.memory(value!, width: 32, height: 32, fit: .contain),
      onTap: () => _pickIcon(context),
      trailing: Row(
        mainAxisSize: .min,
        children: [
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.uploadSimple),
            tooltip: loc.chooseConnectionIcon,
            onPressed: () => _pickIcon(context),
          ),
          if (value != null)
            IconButton(
              icon: const PhosphorIcon(PhosphorIconsLight.x),
              tooltip: loc.remove,
              onPressed: () => onChanged(null),
            ),
        ],
      ),
    );
  }
}
