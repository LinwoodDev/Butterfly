import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/dialogs/painters/shape.dart';
import 'package:butterfly/models/property.dart';
import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly/widgets/color_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/document_bloc.dart';
import '../../models/element.dart';

class ShapeElementDialog extends StatelessWidget {
  final int index;
  final VoidCallback close;
  final Offset position;

  const ShapeElementDialog(
      {super.key,
      required this.index,
      required this.close,
      required this.position});

  @override
  Widget build(BuildContext context) {
    return GeneralElementDialog<ShapeElement>(
      index: index,
      close: close,
      position: position,
      builder: (context, renderer, onChanged) => [
        ColorField(
          title: Text(AppLocalizations.of(context)!.color),
          value: Color(renderer.element.property.color),
          onOpen: () => close(),
          onChanged: (color) {
            onChanged(renderer.element.copyWith(
                property:
                    renderer.element.property.copyWith(color: color.value)));
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.shape),
          leading: Icon(renderer.element.property.shape.getIcon()),
          onTap: () async {
            close();
            final shape = await showDialog<PathShape>(
              context: context,
              builder: (ctx) => StatefulBuilder(
                builder: (_, setState) {
                  var shape = renderer.element.property.shape;
                  return BlocProvider.value(
                    value: context.read<DocumentBloc>(),
                    child: AlertDialog(
                      scrollable: true,
                      title: Text(AppLocalizations.of(context)!.shape),
                      content: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 400),
                        child: ShapeView(
                          shape: shape,
                          onChanged: (value) {
                            shape = value;
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.cancel),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.ok),
                          onPressed: () => Navigator.of(ctx).pop(shape),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
            if (shape != null) {
              onChanged(renderer.element.copyWith(
                  property: renderer.element.property.copyWith(shape: shape)));
            }
          },
        ),
      ],
    );
  }
}
