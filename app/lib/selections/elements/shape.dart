part of '../selection.dart';

class ShapeElementSelection extends ElementSelection<ShapeElement> {
  ShapeElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    return [
      ...super.buildProperties(context),
      ColorField(
        title: Text(LeapLocalizations.of(context).color),
        value: element.property.color.withValues(a: 255),
        onChanged: (color) => updateElements(
          context,
          elements
              .map(
                (e) => e.copyWith(
                  property: e.property.copyWith(
                    color: color.withValues(a: element.property.color.a),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      ExactSlider(
        value: element.property.color.a.toDouble(),
        header: Text(AppLocalizations.of(context).alpha),
        fractionDigits: 0,
        max: 255,
        min: 0,
        defaultValue: 255,
        onChangeEnd: (value) => updateElements(
          context,
          elements
              .map(
                (e) => e.copyWith(
                  property: e.property.copyWith(
                    color: e.property.color.withValues(a: value.toInt()),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).strokeWidth),
        value: element.property.strokeWidth,
        min: 0,
        max: 70,
        defaultValue: 5,
        onChangeEnd: (value) => updateElements(
          context,
          elements
              .map(
                (e) => e.copyWith(
                  property: e.property.copyWith(strokeWidth: value),
                ),
              )
              .toList(),
        ),
      ),
      _ShapeElementStrokeStyleSection(
        property: element.property,
        onPropertyChanged: (property) => updateElements(
          context,
          elements
              .map((e) => e.copyWith(property: property))
              .toList(),
        ),
      ),
      ShapeView(
        shape: element.property.shape,
        onChanged: (value) => updateElements(
          context,
          elements
              .map(
                (e) => e.copyWith(property: e.property.copyWith(shape: value)),
              )
              .toList(),
        ),
      ),
    ];
  }

  @override
  Selection insert(element) {
    if (element is Renderer<ShapeElement>) {
      return ShapeElementSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconGetter get icon => selected.first.element.property.shape.icon;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).shape;
}

class _ShapeElementStrokeStyleSection extends StatefulWidget {
  final ShapeProperty property;
  final ValueChanged<ShapeProperty> onPropertyChanged;

  const _ShapeElementStrokeStyleSection({
    required this.property,
    required this.onPropertyChanged,
  });

  @override
  State<_ShapeElementStrokeStyleSection> createState() =>
      _ShapeElementStrokeStyleSectionState();
}

class _ShapeElementStrokeStyleSectionState
    extends State<_ShapeElementStrokeStyleSection> {
  bool _advancedExpanded = false;

  @override
  Widget build(BuildContext context) {
    final property = widget.property;
    final isStyled = property.strokeStyle != StrokeStyle.solid;

    return ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        setState(() {
          _advancedExpanded = isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: _advancedExpanded,
          headerBuilder: (context, isExpanded) => ListTile(
            title: Text(AppLocalizations.of(context).strokeStyle),
            trailing: DropdownMenu<StrokeStyle>(
              initialSelection: property.strokeStyle,
              dropdownMenuEntries: StrokeStyle.values
                  .map(
                    (e) => DropdownMenuEntry(
                      label: e.getLocalizedName(context),
                      value: e,
                      leadingIcon: Icon(e.icon(PhosphorIconsStyle.light)),
                    ),
                  )
                  .toList(),
              onSelected: (value) => widget.onPropertyChanged(
                property.copyWith(strokeStyle: value ?? StrokeStyle.solid),
              ),
            ),
          ),
          body: Column(
            children: [
              ExactSlider(
                header: Text(AppLocalizations.of(context).dashLength),
                value: property.dashMultiplier,
                min: 0.1,
                max: 5,
                defaultValue: 1,
                onChangeEnd: isStyled
                    ? (value) => widget.onPropertyChanged(
                          property.copyWith(dashMultiplier: value),
                        )
                    : null,
              ),
              ExactSlider(
                header: Text(AppLocalizations.of(context).gapLength),
                value: property.gapMultiplier,
                min: 0.1,
                max: 5,
                defaultValue: 1,
                onChangeEnd: isStyled
                    ? (value) => widget.onPropertyChanged(
                          property.copyWith(gapMultiplier: value),
                        )
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
