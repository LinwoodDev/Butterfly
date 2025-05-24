part of '../selection.dart';

class ShapeToolSelection extends ToolSelection<ShapeTool> {
  ShapeToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    final property = tool.property;
    void updateProperty(ShapeProperty property) => update(
      context,
      selected.map((e) => e.copyWith(property: property)).toList(),
    );
    return [
      ...super.buildProperties(context),
      CheckboxListTile(
        value: tool.drawFromCenter,
        title: Text(AppLocalizations.of(context).center),
        onChanged: (value) => update(
          context,
          selected
              .map(
                (e) => e.copyWith(drawFromCenter: value ?? tool.drawFromCenter),
              )
              .toList(),
        ),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).width),
        value: tool.constrainedWidth,
        min: 0,
        max: 500,
        defaultValue: 0,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(constrainedWidth: value)).toList(),
        ),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).height),
        value: tool.constrainedHeight,
        min: 0,
        max: 500,
        defaultValue: 0,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(constrainedHeight: value)).toList(),
        ),
      ),
      ExactSlider(
        header: Row(
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context).aspectRatio,
                textAlign: TextAlign.center,
              ),
            ),
            MenuAnchor(
              builder: defaultMenuButton(
                tooltip: AppLocalizations.of(context).aspectRatio,
              ),
              menuChildren: AspectRatioPreset.values
                  .map(
                    (e) => MenuItemButton(
                      child: Text(e.getLocalizedName(context)),
                      onPressed: () => update(
                        context,
                        selected
                            .map(
                              (c) =>
                                  c.copyWith(constrainedAspectRatio: e.ratio),
                            )
                            .toList(),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(width: 4),
          ],
        ),
        value: tool.constrainedAspectRatio,
        min: 0,
        max: 10,
        defaultValue: 0,
        onChangeEnd: (value) => update(
          context,
          selected
              .map((e) => e.copyWith(constrainedAspectRatio: value))
              .toList(),
        ),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).strokeWidth),
        value: property.strokeWidth,
        min: 0,
        max: 70,
        defaultValue: 5,
        onChangeEnd: (value) => update(
          context,
          selected
              .map(
                (e) => e.copyWith(
                  property: e.property.copyWith(strokeWidth: value),
                ),
              )
              .toList(),
        ),
      ),
      ColorField(
        value: property.color.withValues(a: 255),
        onChanged: (color) => update(
          context,
          selected
              .map(
                (e) => e.copyWith(
                  property: e.property.copyWith(
                    color: color.withValues(a: property.color.a),
                  ),
                ),
              )
              .toList(),
        ),
        title: Text(LeapLocalizations.of(context).color),
      ),
      ExactSlider(
        value: property.color.a.toDouble(),
        header: Text(AppLocalizations.of(context).alpha),
        fractionDigits: 0,
        max: 255,
        min: 0,
        defaultValue: 255,
        onChangeEnd: (value) => update(
          context,
          selected
              .map(
                (e) => e.copyWith(
                  property: e.property.copyWith(
                    color: property.color.withValues(a: value.toInt()),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      ShapeView(
        shape: property.shape,
        onChanged: (shape) => updateProperty(property.copyWith(shape: shape)),
      ),
      const SizedBox(height: 16),
      CheckboxListTile(
        value: tool.zoomDependent,
        title: Text(AppLocalizations.of(context).zoomDependent),
        onChanged: (value) => update(
          context,
          selected
              .map(
                (e) => e.copyWith(zoomDependent: value ?? tool.zoomDependent),
              )
              .toList(),
        ),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is ShapeTool) {
      return ShapeToolSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconGetter get icon => selected.first.property.shape.icon;
}

class ShapeView extends StatefulWidget {
  final PathShape shape;
  final ValueChanged<PathShape> onChanged;
  const ShapeView({super.key, required this.shape, required this.onChanged});

  @override
  State<ShapeView> createState() => _ShapeViewState();
}

class _ShapeViewState extends State<ShapeView> {
  late PathShape _currentShape;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _currentShape = widget.shape;
  }

  void _onShapeChanged(PathShape shape) {
    setState(() {
      _currentShape = shape;
    });
    widget.onChanged(shape);
  }

  Widget _buildShapeView() {
    final current = _currentShape;
    if (current is CircleShape) {
      return _CircleShapeView(shape: current, onChanged: _onShapeChanged);
    }
    if (current is TriangleShape) {
      return _TriangleShapeView(shape: current, onChanged: _onShapeChanged);
    }
    if (current is RectangleShape) {
      return _RectangleShapeView(shape: current, onChanged: _onShapeChanged);
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    Widget shapeView = _buildShapeView();

    final shapes = Map.fromEntries(
      [
        PathShape.circle,
        PathShape.rectangle,
        PathShape.line,
        PathShape.triangle,
      ].map((e) => e()).map((e) => MapEntry(e.getLocalizedName(context), e)),
    );

    return ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        setState(() {
          _expanded = isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          isExpanded: _expanded,
          canTapOnHeader: true,
          headerBuilder: (context, expanded) => ListTile(
            title: Text(AppLocalizations.of(context).shape),
            trailing: DropdownMenu<String>(
              initialSelection: _currentShape.getLocalizedName(context),
              dropdownMenuEntries: shapes.entries
                  .map(
                    (e) => DropdownMenuEntry(
                      label: e.key,
                      value: e.key,
                      leadingIcon: Icon(e.value.icon(PhosphorIconsStyle.light)),
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                final shape = shapes[value];
                if (shape != null) {
                  _onShapeChanged(shape);
                }
              },
            ),
          ),
          body: shapeView,
        ),
      ],
    );
  }
}

class _CircleShapeView extends StatelessWidget {
  final CircleShape shape;
  final ValueChanged<CircleShape> onChanged;
  const _CircleShapeView({required this.shape, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorField(
          value: shape.fillColor.withValues(a: 255),
          title: Text(AppLocalizations.of(context).fill),
          leading: const PhosphorIcon(PhosphorIconsLight.paintBucket),
          defaultColor: SRGBColor.transparent,
          onChanged: (color) => onChanged(
            shape.copyWith(fillColor: color.withValues(a: shape.fillColor.a)),
          ),
        ),
        ExactSlider(
          value: shape.fillColor.a.toDouble(),
          header: Text(AppLocalizations.of(context).alpha),
          fractionDigits: 0,
          max: 255,
          min: 0,
          defaultValue: 255,
          onChangeEnd: (value) => onChanged(
            shape.copyWith(
              fillColor: shape.fillColor.withValues(a: value.toInt()),
            ),
          ),
        ),
      ],
    );
  }
}

class _TriangleShapeView extends StatelessWidget {
  final TriangleShape shape;
  final ValueChanged<TriangleShape> onChanged;
  const _TriangleShapeView({required this.shape, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorField(
          value: shape.fillColor.withValues(a: 255),
          title: Text(AppLocalizations.of(context).fill),
          leading: const PhosphorIcon(PhosphorIconsLight.paintBucket),
          defaultColor: SRGBColor.transparent,
          onChanged: (color) => onChanged(
            shape.copyWith(fillColor: color.withValues(a: shape.fillColor.a)),
          ),
        ),
        ExactSlider(
          value: shape.fillColor.a.toDouble(),
          header: Text(AppLocalizations.of(context).alpha),
          fractionDigits: 0,
          max: 255,
          min: 0,
          defaultValue: 255,
          onChangeEnd: (value) => onChanged(
            shape.copyWith(
              fillColor: shape.fillColor.withValues(a: value.toInt()),
            ),
          ),
        ),
      ],
    );
  }
}

class _RectangleShapeView extends StatefulWidget {
  final RectangleShape shape;
  final ValueChanged<RectangleShape> onChanged;
  const _RectangleShapeView({required this.shape, required this.onChanged});

  @override
  State<_RectangleShapeView> createState() => _RectangleShapeViewState();
}

class _RectangleShapeViewState extends State<_RectangleShapeView> {
  bool _cornerExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorField(
          title: Text(AppLocalizations.of(context).fill),
          leading: const PhosphorIcon(PhosphorIconsLight.paintBucket),
          value: widget.shape.fillColor.withValues(a: 255),
          defaultColor: SRGBColor.transparent,
          onChanged: (color) => widget.onChanged(
            widget.shape.copyWith(
              fillColor: color.withValues(a: widget.shape.fillColor.a),
            ),
          ),
        ),
        ExactSlider(
          value: widget.shape.fillColor.a.toDouble(),
          header: Text(AppLocalizations.of(context).alpha),
          fractionDigits: 0,
          max: 255,
          min: 0,
          defaultValue: 255,
          onChangeEnd: (value) => widget.onChanged(
            widget.shape.copyWith(
              fillColor: widget.shape.fillColor.withValues(a: value.toInt()),
            ),
          ),
        ),
        ExpansionPanelList(
          expansionCallback: (index, isExpanded) {
            setState(() {
              _cornerExpanded = isExpanded;
            });
          },
          children: [
            ExpansionPanel(
              headerBuilder: (context, isExpanded) => ListTile(
                title: Text(AppLocalizations.of(context).cornerRadius),
              ),
              canTapOnHeader: true,
              isExpanded: _cornerExpanded,
              body: Column(
                children: [
                  ExactSlider(
                    defaultValue: 0,
                    min: 0,
                    max: 100,
                    value: widget.shape.topLeftCornerRadius,
                    header: Text(AppLocalizations.of(context).topLeft),
                    onChangeEnd: (value) => widget.onChanged(
                      widget.shape.copyWith(topLeftCornerRadius: value),
                    ),
                  ),
                  ExactSlider(
                    defaultValue: 0,
                    min: 0,
                    max: 100,
                    value: widget.shape.topRightCornerRadius,
                    header: Text(AppLocalizations.of(context).topRight),
                    onChangeEnd: (value) => widget.onChanged(
                      widget.shape.copyWith(topRightCornerRadius: value),
                    ),
                  ),
                  ExactSlider(
                    defaultValue: 0,
                    min: 0,
                    max: 100,
                    value: widget.shape.bottomLeftCornerRadius,
                    header: Text(AppLocalizations.of(context).bottomLeft),
                    onChangeEnd: (value) => widget.onChanged(
                      widget.shape.copyWith(bottomLeftCornerRadius: value),
                    ),
                  ),
                  ExactSlider(
                    defaultValue: 0,
                    min: 0,
                    max: 100,
                    value: widget.shape.bottomRightCornerRadius,
                    header: Text(AppLocalizations.of(context).bottomRight),
                    onChangeEnd: (value) => widget.onChanged(
                      widget.shape.copyWith(bottomRightCornerRadius: value),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
