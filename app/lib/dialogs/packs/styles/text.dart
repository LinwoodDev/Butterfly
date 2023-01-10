import 'package:butterfly/models/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/color_field.dart';
import '../../../widgets/exact_slider.dart';

class TextStyleView extends StatelessWidget {
  final DefinedSpanProperty value;
  final ValueChanged<DefinedSpanProperty> onChanged;
  const TextStyleView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool decorationExpanded = false;
    return Column(
      children: [
        ExactSlider(
            header: Text(AppLocalizations.of(context).size),
            value: value.size,
            defaultValue: 12,
            min: 6,
            max: 512,
            onChangeEnd: (size) => onChanged(value.copyWith(size: size))),
        ExactSlider(
            header: Text(AppLocalizations.of(context).spacing),
            value: value.letterSpacing,
            defaultValue: 0,
            min: 0,
            max: 20,
            onChangeEnd: (spacing) => onChanged(
                  value.copyWith(letterSpacing: spacing),
                )),
        const SizedBox(height: 16),
        ListTile(
            title: Text(AppLocalizations.of(context).fontWeight),
            trailing: DropdownButton<FontWeight>(
                value: FontWeight.values[value.fontWeight],
                items: List.generate(FontWeight.values.length, (index) {
                  var text = ((index + 1) * 100).toString();
                  if (index == 3) {
                    text = AppLocalizations.of(context).normal;
                  } else if (index == 6) {
                    text = AppLocalizations.of(context).bold;
                  }
                  return DropdownMenuItem(
                      value: FontWeight.values[index], child: Text(text));
                }),
                onChanged: (weight) => onChanged(value.copyWith(
                    fontWeight: weight?.index ?? value.fontWeight)))),
        CheckboxListTile(
            title: Text(AppLocalizations.of(context).italic),
            value: value.italic,
            onChanged: (italic) =>
                onChanged(value.copyWith(italic: italic ?? value.italic))),
        StatefulBuilder(
          builder: ((context, setState) => ExpansionPanelList(
                expansionCallback: (panelIndex, isExpanded) =>
                    setState(() => decorationExpanded = !decorationExpanded),
                children: [
                  ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: decorationExpanded,
                      headerBuilder: (context, isExpanded) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context).decoration,
                                  style: Theme.of(context).textTheme.subtitle1),
                            ],
                          ),
                      body: Column(children: [
                        CheckboxListTile(
                            title:
                                Text(AppLocalizations.of(context).lineThrough),
                            value: value.lineThrough,
                            onChanged: (lineThrough) => onChanged(
                                value.copyWith(
                                    lineThrough:
                                        lineThrough ?? value.lineThrough))),
                        CheckboxListTile(
                            title: Text(AppLocalizations.of(context).underline),
                            value: value.underline,
                            onChanged: (underline) => onChanged(value.copyWith(
                                underline: underline ?? value.underline))),
                        CheckboxListTile(
                            title: Text(AppLocalizations.of(context).overline),
                            value: value.overline,
                            onChanged: (overline) => onChanged(value.copyWith(
                                overline: overline ?? value.overline))),
                        ListTile(
                            title: Text(AppLocalizations.of(context).style),
                            trailing: DropdownButton<TextDecorationStyle>(
                                value: value.decorationStyle,
                                items: List.generate(
                                    TextDecorationStyle.values.length, (index) {
                                  String text;
                                  var style = TextDecorationStyle.values[index];
                                  switch (style) {
                                    case TextDecorationStyle.solid:
                                      text = AppLocalizations.of(context).solid;
                                      break;
                                    case TextDecorationStyle.dashed:
                                      text =
                                          AppLocalizations.of(context).dashed;
                                      break;
                                    case TextDecorationStyle.dotted:
                                      text =
                                          AppLocalizations.of(context).dotted;
                                      break;
                                    case TextDecorationStyle.double:
                                      text =
                                          AppLocalizations.of(context).double;
                                      break;
                                    case TextDecorationStyle.wavy:
                                      text = AppLocalizations.of(context).wavy;
                                  }
                                  return DropdownMenuItem(
                                      value: TextDecorationStyle.values[index],
                                      child: Text(text));
                                }),
                                onChanged: (decorationStyle) => onChanged(
                                    value.copyWith(
                                        decorationStyle: decorationStyle ??
                                            value.decorationStyle)))),
                        ColorField(
                            title: Text(AppLocalizations.of(context).color),
                            value: Color(value.decorationColor),
                            onChanged: (color) => onChanged(
                                value.copyWith(decorationColor: color.value))),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ExactSlider(
                              header:
                                  Text(AppLocalizations.of(context).thickness),
                              defaultValue: 1,
                              value: value.decorationThickness,
                              min: 0.1,
                              max: 4,
                              onChangeEnd: (thickness) => onChanged(value
                                  .copyWith(decorationThickness: thickness))),
                        ),
                      ]))
                ],
              )),
        ),
      ],
    );
  }
}
