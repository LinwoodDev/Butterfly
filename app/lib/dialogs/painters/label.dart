import 'package:butterfly/dialogs/painters/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/painter.dart';
import '../../models/property.dart';
import '../../widgets/color_field.dart';
import '../../widgets/exact_slider.dart';

class LabelPainterDialog extends StatelessWidget {
  final int painterIndex;

  const LabelPainterDialog({super.key, required this.painterIndex});

  @override
  Widget build(BuildContext context) {
    return GeneralPainterDialog<LabelPainter>(
        index: painterIndex,
        title: AppLocalizations.of(context)!.label,
        iconBuilder: (_, __) => PhosphorIcons.textTLight,
        help: 'label',
        builder: (context, painter, setPainter) => [
              LabelPropertyView(
                  initialValue: painter.property,
                  onChanged: (property) =>
                      setPainter(painter.copyWith(property: property))),
            ]);
  }
}

typedef LabelPropertyCallback = void Function(LabelProperty);

class LabelPropertyView extends StatefulWidget {
  final LabelProperty initialValue;
  final LabelPropertyCallback onChanged;

  const LabelPropertyView(
      {super.key, required this.initialValue, required this.onChanged});

  @override
  State<LabelPropertyView> createState() => _LabelPropertyViewState();
}

class _LabelPropertyViewState extends State<LabelPropertyView> {
  late LabelProperty _value;
  bool _decorationExpanded = false;

  @override
  void initState() {
    super.initState();
    change(widget.initialValue, false);
  }

  void change(LabelProperty newValue, [bool notify = true]) {
    setState(() {
      _value = newValue;
    });
    if (notify) {
      widget.onChanged(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ExactSlider(
          header: Text(AppLocalizations.of(context)!.size),
          value: _value.size,
          defaultValue: 12,
          min: 6,
          max: 512,
          onChanged: (value) =>
              change(_value.copyWith(size: value), value != _value.size)),
      ExactSlider(
          header: Text(AppLocalizations.of(context)!.spacing),
          value: _value.letterSpacing,
          defaultValue: 0,
          min: 0,
          max: 20,
          onChanged: (value) => change(_value.copyWith(letterSpacing: value),
              value != _value.letterSpacing)),
      ToggleButtons(
          isSelected: [
            _value.horizontalAlignment == HorizontalAlignment.left,
            _value.horizontalAlignment == HorizontalAlignment.center,
            _value.horizontalAlignment == HorizontalAlignment.right,
            _value.horizontalAlignment == HorizontalAlignment.justify,
          ],
          onPressed: (index) {
            var alignments = [
              HorizontalAlignment.left,
              HorizontalAlignment.center,
              HorizontalAlignment.right,
              HorizontalAlignment.justify,
            ];
            change(
                _value.copyWith(horizontalAlignment: alignments[index]), true);
          },
          children: const [
            Icon(PhosphorIcons.textAlignLeftLight),
            Icon(PhosphorIcons.textAlignCenterLight),
            Icon(PhosphorIcons.textAlignRightLight),
            Icon(PhosphorIcons.textAlignJustifyLight),
          ]),
      ToggleButtons(
          isSelected: [
            _value.verticalAlignment == VerticalAlignment.top,
            _value.verticalAlignment == VerticalAlignment.center,
            _value.verticalAlignment == VerticalAlignment.bottom,
          ],
          onPressed: (index) {
            var alignments = [
              VerticalAlignment.top,
              VerticalAlignment.center,
              VerticalAlignment.bottom,
            ];
            change(_value.copyWith(verticalAlignment: alignments[index]), true);
          },
          children: const [
            Icon(PhosphorIcons.alignTopLight),
            Icon(PhosphorIcons.alignCenterVerticalLight),
            Icon(PhosphorIcons.alignBottomLight),
          ]),
      ListTile(
          title: Text(AppLocalizations.of(context)!.fontWeight),
          trailing: DropdownButton<FontWeight>(
              value: FontWeight.values[_value.fontWeight],
              items: List.generate(FontWeight.values.length, (index) {
                var text = ((index + 1) * 100).toString();
                if (index == 3) {
                  text = AppLocalizations.of(context)!.normal;
                } else if (index == 6) {
                  text = AppLocalizations.of(context)!.bold;
                }
                return DropdownMenuItem(
                    value: FontWeight.values[index], child: Text(text));
              }),
              onChanged: (value) => change(_value.copyWith(
                  fontWeight: value?.index ?? _value.fontWeight)))),
      CheckboxListTile(
          title: Text(AppLocalizations.of(context)!.italic),
          value: _value.italic,
          onChanged: (value) =>
              change(_value.copyWith(italic: value ?? _value.italic))),
      ExpansionPanelList(
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
                      Text(AppLocalizations.of(context)!.decoration,
                          style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
              body: Column(children: [
                CheckboxListTile(
                    title: Text(AppLocalizations.of(context)!.lineThrough),
                    value: _value.lineThrough,
                    onChanged: (value) => change(_value.copyWith(
                        lineThrough: value ?? _value.lineThrough))),
                CheckboxListTile(
                    title: Text(AppLocalizations.of(context)!.underline),
                    value: _value.underline,
                    onChanged: (value) => change(
                        _value.copyWith(underline: value ?? _value.underline))),
                CheckboxListTile(
                    title: Text(AppLocalizations.of(context)!.overline),
                    value: _value.overline,
                    onChanged: (value) => change(
                        _value.copyWith(overline: value ?? _value.overline))),
                ListTile(
                    title: Text(AppLocalizations.of(context)!.style),
                    trailing: DropdownButton<TextDecorationStyle>(
                        value: _value.decorationStyle,
                        items: List.generate(TextDecorationStyle.values.length,
                            (index) {
                          String text;
                          var style = TextDecorationStyle.values[index];
                          switch (style) {
                            case TextDecorationStyle.solid:
                              text = AppLocalizations.of(context)!.solid;
                              break;
                            case TextDecorationStyle.dashed:
                              text = AppLocalizations.of(context)!.dashed;
                              break;
                            case TextDecorationStyle.dotted:
                              text = AppLocalizations.of(context)!.dotted;
                              break;
                            case TextDecorationStyle.double:
                              text = AppLocalizations.of(context)!.double;
                              break;
                            case TextDecorationStyle.wavy:
                              text = AppLocalizations.of(context)!.wavy;
                          }
                          return DropdownMenuItem(
                              value: TextDecorationStyle.values[index],
                              child: Text(text));
                        }),
                        onChanged: (value) => change(_value.copyWith(
                            decorationStyle:
                                value ?? _value.decorationStyle)))),
                ColorField(
                    title: Text(AppLocalizations.of(context)!.color),
                    color: Color(_value.decorationColor),
                    onChanged: (value) =>
                        change(_value.copyWith(decorationColor: value.value))),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ExactSlider(
                      header: Text(AppLocalizations.of(context)!.thickness),
                      defaultValue: 1,
                      value: _value.decorationThickness,
                      min: 0.1,
                      max: 4,
                      onChanged: (value) =>
                          change(_value.copyWith(decorationThickness: value))),
                ),
              ]))
        ],
      ),
      const SizedBox(height: 32),
      ColorField(
          title: Text(AppLocalizations.of(context)!.color),
          color: Color(_value.color),
          onChanged: (value) => change(_value.copyWith(color: value.value))),
    ]);
  }
}
