part of '../selection.dart';

class LabelPropertySelection extends PropertySelection<LabelProperty> {
  bool _decorationExpanded = false;
  LabelPropertySelection();

  @override
  List<Widget> build(
    BuildContext context,
    LabelProperty property,
    ValueChanged<LabelProperty> onChanged,
  ) {
    return [
      ExactSlider(
          header: Text(AppLocalizations.of(context).size),
          value: property.size,
          defaultValue: 12,
          min: 6,
          max: 512,
          onChangeEnd: (value) => onChanged(property.copyWith(size: value))),
      ExactSlider(
          header: Text(AppLocalizations.of(context).spacing),
          value: property.letterSpacing,
          defaultValue: 0,
          min: 0,
          max: 20,
          onChangeEnd: (value) => onChanged(
                property.copyWith(letterSpacing: value),
              )),
      const SizedBox(height: 16),
      ToggleButtons(
          isSelected: [
            property.horizontalAlignment == HorizontalAlignment.left,
            property.horizontalAlignment == HorizontalAlignment.center,
            property.horizontalAlignment == HorizontalAlignment.right,
            property.horizontalAlignment == HorizontalAlignment.justify,
          ],
          onPressed: (index) {
            var alignments = [
              HorizontalAlignment.left,
              HorizontalAlignment.center,
              HorizontalAlignment.right,
              HorizontalAlignment.justify,
            ];
            onChanged(
              property.copyWith(horizontalAlignment: alignments[index]),
            );
          },
          children: const [
            Icon(PhosphorIcons.textAlignLeftLight),
            Icon(PhosphorIcons.textAlignCenterLight),
            Icon(PhosphorIcons.textAlignRightLight),
            Icon(PhosphorIcons.textAlignJustifyLight),
          ]),
      ToggleButtons(
          isSelected: [
            property.verticalAlignment == VerticalAlignment.top,
            property.verticalAlignment == VerticalAlignment.center,
            property.verticalAlignment == VerticalAlignment.bottom,
          ],
          onPressed: (index) {
            var alignments = [
              VerticalAlignment.top,
              VerticalAlignment.center,
              VerticalAlignment.bottom,
            ];
            onChanged(property.copyWith(verticalAlignment: alignments[index]));
          },
          children: const [
            Icon(PhosphorIcons.alignTopLight),
            Icon(PhosphorIcons.alignCenterVerticalLight),
            Icon(PhosphorIcons.alignBottomLight),
          ]),
      const SizedBox(height: 16),
      ListTile(
          title: Text(AppLocalizations.of(context).fontWeight),
          trailing: DropdownButton<FontWeight>(
              value: FontWeight.values[property.fontWeight],
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
              onChanged: (value) => onChanged(property.copyWith(
                  fontWeight: value?.index ?? property.fontWeight)))),
      CheckboxListTile(
          title: Text(AppLocalizations.of(context).italic),
          value: property.italic,
          onChanged: (value) =>
              onChanged(property.copyWith(italic: value ?? property.italic))),
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
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                    body: Column(children: [
                      CheckboxListTile(
                          title: Text(AppLocalizations.of(context).lineThrough),
                          value: property.lineThrough,
                          onChanged: (value) => onChanged(property.copyWith(
                              lineThrough: value ?? property.lineThrough))),
                      CheckboxListTile(
                          title: Text(AppLocalizations.of(context).underline),
                          value: property.underline,
                          onChanged: (value) => onChanged(property.copyWith(
                              underline: value ?? property.underline))),
                      CheckboxListTile(
                          title: Text(AppLocalizations.of(context).overline),
                          value: property.overline,
                          onChanged: (value) => onChanged(property.copyWith(
                              overline: value ?? property.overline))),
                      ListTile(
                          title: Text(AppLocalizations.of(context).style),
                          trailing: DropdownButton<TextDecorationStyle>(
                              value: property.decorationStyle,
                              items: List.generate(
                                  TextDecorationStyle.values.length, (index) {
                                String text;
                                var style = TextDecorationStyle.values[index];
                                switch (style) {
                                  case TextDecorationStyle.solid:
                                    text = AppLocalizations.of(context).solid;
                                    break;
                                  case TextDecorationStyle.dashed:
                                    text = AppLocalizations.of(context).dashed;
                                    break;
                                  case TextDecorationStyle.dotted:
                                    text = AppLocalizations.of(context).dotted;
                                    break;
                                  case TextDecorationStyle.double:
                                    text = AppLocalizations.of(context).double;
                                    break;
                                  case TextDecorationStyle.wavy:
                                    text = AppLocalizations.of(context).wavy;
                                }
                                return DropdownMenuItem(
                                    value: TextDecorationStyle.values[index],
                                    child: Text(text));
                              }),
                              onChanged: (value) => onChanged(property.copyWith(
                                  decorationStyle:
                                      value ?? property.decorationStyle)))),
                      ColorField(
                          title: Text(AppLocalizations.of(context).color),
                          value: Color(property.decorationColor),
                          onChanged: (value) => onChanged(
                              property.copyWith(decorationColor: value.value))),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ExactSlider(
                            header:
                                Text(AppLocalizations.of(context).thickness),
                            defaultValue: 1,
                            value: property.decorationThickness,
                            min: 0.1,
                            max: 4,
                            onChangeEnd: (value) => onChanged(
                                property.copyWith(decorationThickness: value))),
                      ),
                    ]))
              ],
            )),
      ),
      const SizedBox(height: 32),
      ColorField(
          title: Text(AppLocalizations.of(context).color),
          value: Color(property.color),
          onChanged: (value) =>
              onChanged(property.copyWith(color: value.value))),
    ];
  }
}
