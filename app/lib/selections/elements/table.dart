part of '../selection.dart';

class TableElementSelection extends ElementSelection<TableElement> {
  final TableHitTarget? target;

  TableElementSelection(super.selected, {this.target});

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    final target = this.target;
    if (target != null) {
      return _buildTargetProperties(context, element, target);
    }
    return [
      ...super.buildProperties(context),
      _TableCountTile(
        title: AppLocalizations.of(context).rows,
        value: element.rows,
        onChanged: (value) => updateElements(
          context,
          elements.map((e) => _resizeTable(e, rows: value)).toList(),
        ),
      ),
      _TableCountTile(
        title: AppLocalizations.of(context).columns,
        value: element.columns,
        onChanged: (value) => updateElements(
          context,
          elements.map((e) => _resizeTable(e, columns: value)).toList(),
        ),
      ),
      _TableBorderControls(
        value: element.border,
        title: AppLocalizations.of(context).border,
        onChanged: (value) => updateElements(
          context,
          elements.map((e) => e.copyWith(border: value)).toList(),
        ),
      ),
      _TableColorControls(
        value: element.fillColor,
        title: AppLocalizations.of(context).fill,
        onChanged: (value) => updateElements(
          context,
          elements.map((e) => e.copyWith(fillColor: value)).toList(),
        ),
      ),
    ];
  }

  List<Widget> _buildTargetProperties(
    BuildContext context,
    TableElement element,
    TableHitTarget target,
  ) => switch (target) {
    TableCellTarget(:final row, :final column) => _buildCellProperties(
      context,
      element,
      row,
      column,
    ),
    TableLineTarget(:final axis, :final line) => [
      _TableBorderControls(
        value: element.borderAt(axis, line, 0),
        title: axis == TableAxis.horizontal
            ? AppLocalizations.of(context).horizontalBorder
            : AppLocalizations.of(context).verticalBorder,
        onChanged: (border) => updateElements(context, [
          elements.first.setBorderLine(axis, line, border),
        ]),
      ),
    ],
    TableBorderTarget(:final axis, :final line, :final segment) => [
      _TableBorderControls(
        value: element.borderAt(axis, line, segment),
        title: AppLocalizations.of(context).cellBorder,
        onChanged: (border) => updateElements(context, [
          elements.first.setBorder(axis, line, segment, border),
        ]),
      ),
    ],
  };

  List<Widget> _buildCellProperties(
    BuildContext context,
    TableElement element,
    int row,
    int column,
  ) {
    final renderer = TableRenderer(element);
    final bounds = renderer.cellRect(row, column);
    return [
      ExactSlider(
        header: Text(AppLocalizations.of(context).rowHeight),
        value: bounds.height,
        min: 10,
        max: 1000,
        defaultValue: 60,
        onChangeEnd: (height) =>
            updateElements(context, [elements.first.setRowExtent(row, height)]),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).columnWidth),
        value: bounds.width,
        min: 10,
        max: 1000,
        defaultValue: 120,
        onChangeEnd: (width) => updateElements(context, [
          elements.first.setColumnExtent(column, width),
        ]),
      ),
      _TableColorControls(
        value: element.cellAt(row, column).fillColor,
        title: AppLocalizations.of(context).cellColor,
        onChanged: (color) => updateElements(context, [
          elements.first.setCell(
            row,
            column,
            elements.first.cellAt(row, column).copyWith(fillColor: color),
          ),
        ]),
      ),
      _TableBorderControls(
        value: element.borderAt(TableAxis.horizontal, row, column),
        title: AppLocalizations.of(context).cellBorders,
        onChanged: (border) => updateElements(context, [
          elements.first.setCellBorders(row, column, border),
        ]),
      ),
    ];
  }

  TableElement _resizeTable(TableElement element, {int? rows, int? columns}) {
    final nextRows = rows ?? element.rows;
    final nextColumns = columns ?? element.columns;
    var updated = element;
    while (updated.rows < nextRows) {
      updated = updated.insertRow(updated.rows);
    }
    while (updated.rows > nextRows) {
      updated = updated.removeRow(updated.rows - 1);
    }
    while (updated.columns < nextColumns) {
      updated = updated.insertColumn(updated.columns);
    }
    while (updated.columns > nextColumns) {
      updated = updated.removeColumn(updated.columns - 1);
    }
    return updated;
  }

  @override
  Selection insert(dynamic element) {
    if (element is Renderer<TableElement>) {
      return TableElementSelection([...selected, element], target: target);
    }
    return super.insert(element);
  }

  @override
  Selection? replaceSelected(List<Renderer<TableElement>>? selected) {
    if (selected == null || selected.isEmpty) return null;
    return TableElementSelection(selected, target: target);
  }

  @override
  IconGetter get icon => PhosphorIcons.table;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).table;
}
