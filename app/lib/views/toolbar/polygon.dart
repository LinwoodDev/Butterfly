import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/views/toolbar/color.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PolygonToolbarView extends StatelessWidget
    implements PreferredSizeWidget {
  final PolygonTool tool;
  final ValueChanged<PolygonTool> onToolChanged;
  final bool hasPoints;
  final VoidCallback? onFinishShape, onSubmit, onDelete;

  const PolygonToolbarView({
    super.key,
    required this.tool,
    required this.onToolChanged,
    required this.onFinishShape,
    required this.onSubmit,
    required this.onDelete,
    required this.hasPoints,
  });

  @override
  Widget build(BuildContext context) {
    return ColorToolbarView(
      color: tool.property.color,
      onChanged: (value) => onToolChanged.call(
        tool.copyWith(property: tool.property.copyWith(color: value)),
      ),
      strokeWidth: tool.property.strokeWidth,
      onStrokeWidthChanged: (value) => onToolChanged.call(
        tool.copyWith(property: tool.property.copyWith(strokeWidth: value)),
      ),
      actions: [
        if (hasPoints)
          IconButton(
            tooltip: AppLocalizations.of(context).delete,
            icon: const Icon(PhosphorIconsLight.trash),
            onPressed: onDelete,
          ),
        if (hasPoints)
          IconButton(
            tooltip: AppLocalizations.of(context).finishShape,
            icon: const Icon(PhosphorIconsLight.polygon),
            onPressed: onFinishShape,
          ),
        if (hasPoints)
          IconButton(
            tooltip: AppLocalizations.of(context).submit,
            icon: const Icon(
              PhosphorIconsLight.check,
              textDirection: TextDirection.ltr,
            ),
            onPressed: onSubmit,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
