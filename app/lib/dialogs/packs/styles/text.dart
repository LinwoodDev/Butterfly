import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/color_field.dart';
import '../../../widgets/exact_slider.dart';

class TextStyleView extends StatefulWidget {
  final text.DefinedSpanProperty value;
  final ValueChanged<text.DefinedSpanProperty> onChanged;
  const TextStyleView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<TextStyleView> createState() => _TextStyleViewState();
}

class _TextStyleViewState extends State<TextStyleView> {
  bool _decorationExpanded = false;

  @override
  void didUpdateWidget(covariant TextStyleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExactSlider(
            header: Text(AppLocalizations.of(context).size),
            value: widget.value.size,
            defaultValue: 12,
            min: 6,
            max: 512,
            onChangeEnd: (size) =>
                widget.onChanged(widget.value.copyWith(size: size))),
        ExactSlider(
            header: Text(AppLocalizations.of(context).spacing),
            value: widget.value.letterSpacing,
            defaultValue: 0,
            min: 0,
            max: 20,
            onChangeEnd: (spacing) => widget.onChanged(
                  widget.value.copyWith(letterSpacing: spacing),
                )),
        const SizedBox(height: 16),
        ListTile(
            title: Text(AppLocalizations.of(context).fontWeight),
            trailing: DropdownButton<FontWeight>(
                value: FontWeight.values[widget.value.fontWeight],
                items: List.generate(FontWeight.values.length, (index) {
                  var current = ((index + 1) * 100).toString();
                  if (index == text.kFontWeightNormal) {
                    current = AppLocalizations.of(context).normal;
                  } else if (index == text.kFontWeightBold) {
                    current = AppLocalizations.of(context).bold;
                  }
                  return DropdownMenuItem(
                      value: FontWeight.values[index], child: Text(current));
                }),
                onChanged: (weight) => widget.onChanged(widget.value.copyWith(
                    fontWeight: weight?.index ?? widget.value.fontWeight)))),
        CheckboxListTile(
            title: Text(AppLocalizations.of(context).italic),
            value: widget.value.italic,
            onChanged: (italic) => widget.onChanged(
                widget.value.copyWith(italic: italic ?? widget.value.italic))),
        StatefulBuilder(
          builder: ((context, setState) => ExpansionPanelList(
                expansionCallback: (panelIndex, isExpanded) =>
                    setState(() => _decorationExpanded = !_decorationExpanded),
                children: [
                  ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: _decorationExpanded,
                      headerBuilder: (context, isExpanded) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context).decoration,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                      body: Column(children: [
                        CheckboxListTile(
                            title:
                                Text(AppLocalizations.of(context).lineThrough),
                            value: widget.value.lineThrough,
                            onChanged: (lineThrough) => widget.onChanged(
                                widget.value.copyWith(
                                    lineThrough: lineThrough ??
                                        widget.value.lineThrough))),
                        CheckboxListTile(
                            title: Text(AppLocalizations.of(context).underline),
                            value: widget.value.underline,
                            onChanged: (underline) => widget.onChanged(
                                widget.value.copyWith(
                                    underline:
                                        underline ?? widget.value.underline))),
                        CheckboxListTile(
                            title: Text(AppLocalizations.of(context).overline),
                            value: widget.value.overline,
                            onChanged: (overline) => widget.onChanged(
                                widget.value.copyWith(
                                    overline:
                                        overline ?? widget.value.overline))),
                        ListTile(
                            title: Text(AppLocalizations.of(context).style),
                            trailing: DropdownButton<TextDecorationStyle>(
                                value: widget.value.decorationStyle,
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
                                onChanged: (decorationStyle) =>
                                    widget.onChanged(widget.value.copyWith(
                                        decorationStyle: decorationStyle ??
                                            widget.value.decorationStyle)))),
                        ColorField(
                            title: Text(AppLocalizations.of(context).color),
                            value: Color(widget.value.decorationColor),
                            onChanged: (color) => widget.onChanged(widget.value
                                .copyWith(decorationColor: color.value))),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ExactSlider(
                              header:
                                  Text(AppLocalizations.of(context).thickness),
                              defaultValue: 1,
                              value: widget.value.decorationThickness,
                              min: 0.1,
                              max: 4,
                              onChangeEnd: (thickness) => widget.onChanged(
                                  widget.value.copyWith(
                                      decorationThickness: thickness))),
                        ),
                      ]))
                ],
              )),
        ),
      ],
    );
  }
}
