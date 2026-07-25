part of '../selection.dart';

class TableToolSelection extends ToolSelection<TableTool> {
  TableToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    return [
      ...super.buildProperties(context),
      _TableCountTile(
        title: AppLocalizations.of(context).rows,
        value: tool.rows,
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(rows: value)).toList(),
        ),
      ),
      _TableCountTile(
        title: AppLocalizations.of(context).columns,
        value: tool.columns,
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(columns: value)).toList(),
        ),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).width),
        value: tool.constrainedWidth,
        min: 0,
        max: 1000,
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
        max: 1000,
        defaultValue: 0,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(constrainedHeight: value)).toList(),
        ),
      ),
      _TableBorderControls(
        value: tool.border,
        title: AppLocalizations.of(context).border,
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(border: value)).toList(),
        ),
      ),
      _TableColorControls(
        value: tool.fillColor,
        title: AppLocalizations.of(context).fill,
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(fillColor: value)).toList(),
        ),
      ),
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
    if (element is TableTool) {
      return TableToolSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconGetter get icon => PhosphorIcons.table;
}

class _TableBorderControls extends StatefulWidget {
  final TableBorderProperty value;
  final String title;
  final ValueChanged<TableBorderProperty> onChanged;

  const _TableBorderControls({
    required this.value,
    required this.title,
    required this.onChanged,
  });

  @override
  State<_TableBorderControls> createState() => _TableBorderControlsState();
}

class _TableBorderControlsState extends State<_TableBorderControls> {
  late TableBorderProperty _value = widget.value;

  @override
  void didUpdateWidget(covariant _TableBorderControls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _value = widget.value;
  }

  void _change(TableBorderProperty value) {
    setState(() => _value = value);
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final value = _value;
    return Column(
      children: [
        _TableColorControls(
          value: value.color,
          title: widget.title,
          onChanged: (color) => _change(value.copyWith(color: color)),
        ),
        ExactSlider(
          header: Text(AppLocalizations.of(context).strokeWidth),
          value: value.width,
          min: 0,
          max: 20,
          defaultValue: 1,
          onChangeEnd: (width) => _change(value.copyWith(width: width)),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).strokeStyle),
          trailing: DropdownButton<StrokeStyle>(
            value: value.strokeStyle,
            items: StrokeStyle.values
                .map(
                  (style) => DropdownMenuItem(
                    value: style,
                    child: Text(style.getLocalizedName(context)),
                  ),
                )
                .toList(),
            onChanged: (style) {
              if (style != null) {
                _change(value.copyWith(strokeStyle: style));
              }
            },
          ),
        ),
        if (value.strokeStyle != StrokeStyle.solid) ...[
          ExactSlider(
            header: Text(AppLocalizations.of(context).dashLength),
            value: value.dashMultiplier,
            min: 0.1,
            max: 5,
            defaultValue: 1,
            onChangeEnd: (dashMultiplier) =>
                _change(value.copyWith(dashMultiplier: dashMultiplier)),
          ),
          ExactSlider(
            header: Text(AppLocalizations.of(context).gapLength),
            value: value.gapMultiplier,
            min: 0.1,
            max: 5,
            defaultValue: 1,
            onChangeEnd: (gapMultiplier) =>
                _change(value.copyWith(gapMultiplier: gapMultiplier)),
          ),
        ],
      ],
    );
  }
}

class _TableColorControls extends StatefulWidget {
  final SRGBColor value;
  final String title;
  final ValueChanged<SRGBColor> onChanged;

  const _TableColorControls({
    required this.value,
    required this.title,
    required this.onChanged,
  });

  @override
  State<_TableColorControls> createState() => _TableColorControlsState();
}

class _TableColorControlsState extends State<_TableColorControls> {
  late SRGBColor _value = widget.value;

  @override
  void didUpdateWidget(covariant _TableColorControls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _value = widget.value;
  }

  void _change(SRGBColor value) {
    setState(() => _value = value);
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final value = _value;
    return Column(
      children: [
        ColorField(
          value: value.withValues(a: 255),
          title: Text(widget.title),
          onChanged: (color) => _change(color.withValues(a: value.a)),
        ),
        ExactSlider(
          value: value.a.toDouble(),
          header: Text(AppLocalizations.of(context).alpha),
          fractionDigits: 0,
          min: 0,
          max: 255,
          defaultValue: 255,
          onChangeEnd: (alpha) => _change(value.withValues(a: alpha.toInt())),
        ),
      ],
    );
  }
}

class _TableCountTile extends StatelessWidget {
  final String title;
  final int value;
  final ValueChanged<int> onChanged;

  const _TableCountTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('$value'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: AppLocalizations.of(context).remove,
            onPressed: value > 1 ? () => onChanged(value - 1) : null,
            icon: const PhosphorIcon(PhosphorIconsLight.minus),
          ),
          IconButton(
            tooltip: AppLocalizations.of(context).add,
            onPressed: () => onChanged(value + 1),
            icon: const PhosphorIcon(PhosphorIconsLight.plus),
          ),
        ],
      ),
    );
  }
}
