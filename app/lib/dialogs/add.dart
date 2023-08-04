import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/color_helper.dart';
import 'package:butterfly/visualizer/painter.dart';
import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../api/open.dart';
import '../bloc/document_bloc.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    void addPainter(Painter painter) {
      final bloc = context.read<DocumentBloc>();
      final state = bloc.state;
      if (state is! DocumentLoaded) return;
      final background = state.page.background.defaultColor;
      final defaultPainter = updatePainterDefaultColor(painter, background);
      bloc.add(PainterCreated(defaultPainter));
      Navigator.of(context).pop();
    }

    Widget buildPainter(Painter Function() e) {
      final painter = e();
      return BoxTile(
        title: Text(
          painter.getLocalizedName(context),
          textAlign: TextAlign.center,
        ),
        icon: PhosphorIcon(painter.icon(PhosphorIconsStyle.light)),
        onTap: () => addPainter(painter),
      );
    }

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppLocalizations.of(context).add),
          IconButton(
            onPressed: () => openHelp(['painters']),
            icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
          ),
        ],
      ),
      scrollable: true,
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context).cancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      content: SizedBox(
        width: 900,
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).import,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                children: ImportType.values
                    .where((e) => e.isAvailable())
                    .map(
                      (e) => BoxTile(
                        size: 128,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              e.getLocalizedName(context),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () =>
                                  addPainter(Painter.asset(importType: e)),
                              icon: const PhosphorIcon(
                                  PhosphorIconsLight.pushPin),
                            ),
                          ],
                        ),
                        icon: PhosphorIcon(e.icon(PhosphorIconsStyle.light)),
                        onTap: () async {
                          await showImportAssetWizard(e, context);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context).painters,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Painter.hand,
                  Painter.move,
                  Painter.pen,
                  Painter.stamp,
                  Painter.laser,
                  Painter.pathEraser,
                  Painter.label,
                  Painter.eraser,
                  Painter.layer,
                  Painter.area,
                  Painter.presentation,
                  () => Painter.spacer(axis: Axis2D.vertical),
                  () => Painter.spacer(axis: Axis2D.horizontal),
                ].map(buildPainter).toList(),
              ),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context).shape,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  PathShape.circle,
                  PathShape.rectangle,
                  PathShape.line,
                ].map((e) {
                  final shape = e();
                  return BoxTile(
                    title: Text(
                      shape.getLocalizedName(context),
                      textAlign: TextAlign.center,
                    ),
                    icon: Icon(shape.icon(PhosphorIconsStyle.light)),
                    onTap: () => addPainter(
                        ShapePainter(property: ShapeProperty(shape: shape))),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context).actions,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Painter.undo,
                  Painter.redo,
                  Painter.fullSceen,
                ].map(buildPainter).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
