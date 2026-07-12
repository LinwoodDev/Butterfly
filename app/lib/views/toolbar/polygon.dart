import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
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
  final DocumentBloc bloc;
  final VoidCallback? onFinishShape, onSubmit, onDelete;

  const PolygonToolbarView({
    super.key,
    required this.bloc,
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
      color: tool.property.paint.previewColor,
      onChanged: (value) => onToolChanged.call(
        tool.copyWith(
          property: tool.property.copyWith(
            paint: ElementPaint.solid(
              color: value,
              blur: tool.property.paint.blur,
            ),
          ),
        ),
      ),
      onEyeDropper: (context) {
        bloc.editorController.toolCubit.changeTemporaryHandler(
          context,
          bloc.editorController,
          EyeDropperTool(),
          bloc: bloc,
          temporaryState: TemporaryState.removeAfterRelease,
        );
      },
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
