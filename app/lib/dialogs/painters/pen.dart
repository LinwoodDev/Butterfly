import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/color_pick.dart';
import 'package:butterfly/dialogs/painters/general.dart';
import 'package:butterfly/models/painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/exact_slider.dart';

class PenPainterDialog extends StatelessWidget {
  final int painterIndex;

  const PenPainterDialog({super.key, required this.painterIndex});

  @override
  Widget build(BuildContext context) {
    return GeneralPainterDialog<PenPainter>(
        index: painterIndex,
        title: AppLocalizations.of(context)!.pen,
        icon: PhosphorIcons.penLight,
        help: 'pen',
        builder: (context, painter, setPainter) => [
              ExactSlider(
                  header: Text(AppLocalizations.of(context)!.strokeWidth),
                  value: painter.property.strokeWidth,
                  min: 0,
                  max: 70,
                  defaultValue: 5,
                  onChanged: (value) => setPainter(painter.copyWith(
                      property:
                          painter.property.copyWith(strokeWidth: value)))),
              ExactSlider(
                  header: Text(AppLocalizations.of(context)!.strokeMultiplier),
                  value: painter.property.strokeMultiplier,
                  min: 0,
                  max: 70,
                  defaultValue: 5,
                  onChanged: (value) => setPainter(painter.copyWith(
                      property:
                          painter.property.copyWith(strokeMultiplier: value)))),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      onTap: () async {
                        var color = await showDialog(
                            context: context,
                            builder: (ctx) => BlocProvider.value(
                                  value: context.read<DocumentBloc>(),
                                  child: ColorPickerDialog(
                                      defaultColor:
                                          Color(painter.property.color)),
                                )) as int?;
                        if (color != null) {
                          setPainter(painter.copyWith(
                              property:
                                  painter.property.copyWith(color: color)));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(painter.property.color),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32))),
                        constraints:
                            const BoxConstraints(maxWidth: 100, maxHeight: 100),
                      )),
                ],
              ),
              const SizedBox(height: 15),
              CheckboxListTile(
                  value: painter.zoomDependent,
                  title: Text(AppLocalizations.of(context)!.zoomDependent),
                  onChanged: (value) => setPainter(painter.copyWith(
                      zoomDependent: value ?? painter.zoomDependent))),
              CheckboxListTile(
                  value: painter.property.fill,
                  title: Text(AppLocalizations.of(context)!.fill),
                  onChanged: (value) => setPainter(painter.copyWith(
                      property: painter.property
                          .copyWith(fill: value ?? painter.property.fill))))
            ]);
  }
}
