import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/models/property.dart';
import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly/widgets/color_field.dart';
import 'package:butterfly/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/document_bloc.dart';
import '../../models/element.dart';
import '../../selections/selection.dart';
import '../../widgets/context_menu.dart';

class ShapeElementDialog extends StatelessWidget {
  final int index;
  final ContextCloseFunction close;
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
                    child: Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              minWidth: 400, maxHeight: 600, maxWidth: 600),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Header(
                                title:
                                    Text(AppLocalizations.of(context)!.shape)),
                            Flexible(
                              child: SingleChildScrollView(
                                child: ShapeView(
                                  shape: shape,
                                  onChanged: (value) {
                                    shape = value;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: Text(
                                      AppLocalizations.of(context)!.cancel),
                                  onPressed: () => Navigator.of(ctx).pop(),
                                ),
                                TextButton(
                                  child: Text(AppLocalizations.of(context)!.ok),
                                  onPressed: () => Navigator.of(ctx).pop(shape),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
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
