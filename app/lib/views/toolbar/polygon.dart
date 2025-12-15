import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/views/toolbar/color.dart';
import 'package:butterfly/views/toolbar/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PolygonToolbarView extends StatelessWidget
    implements PreferredSizeWidget {
  final PolygonTool tool;
  final ValueChanged<PolygonTool> onToolChanged;
  final bool editing;
  final VoidCallback? onFinishShape, onSubmit, onDelete, onToggleEdit;

  const PolygonToolbarView({
    super.key,
    required this.tool,
    required this.onToolChanged,
    required this.onFinishShape,
    required this.onSubmit,
    required this.onDelete,
    required this.onToggleEdit,
    required this.editing,
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
        IconButton(
          tooltip: AppLocalizations.of(context).edit,
          icon: Icon(PhosphorIconsLight.pencil),
          selectedIcon: const Icon(PhosphorIconsFill.pencil),
          isSelected: editing,
          onPressed: onToggleEdit,
        ),
        IconButton(
          tooltip: AppLocalizations.of(context).delete,
          icon: const Icon(PhosphorIconsLight.trash),
          onPressed: onDelete,
        ),
        IconButton(
          tooltip: AppLocalizations.of(context).finishShape,
          icon: const Icon(PhosphorIconsLight.lineSegment),
          onPressed: onFinishShape,
        ),
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
  Size get preferredSize => kToolbarSmall;
}
